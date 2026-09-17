import fs from 'node:fs/promises';
import crypto from 'node:crypto';
import path from 'node:path';

const revision = '8822f7ddef30fadbd92e1c6ab4ed897af356af5e';
const sourcePath = 'artifacts/sources/upstream-audit/ErdosProblems/Erdos402.lean';
const destination = '.lake/upstream-src/ErdosProblems/Erdos402.lean';
const expectedHash = '09a31c0c26c3ca20ea7c82897cf15182b1984e31a018bdb0c22970823e7a76d0';
const sha256 = value => crypto.createHash('sha256').update(value).digest('hex');
const sourceUrl = 'https://raw.githubusercontent.com/plby/lean-proofs/' + revision +
  '/src/latest/ErdosProblems/Erdos402.lean';
let source;
try { source = await fs.readFile(sourcePath, 'utf8'); } catch (error) {
  if (error.code !== 'ENOENT') throw error;
  const response = await fetch(sourceUrl);
  if (!response.ok) throw new Error('Pinned source download failed: ' + response.status);
  source = await response.text();
  if (sha256(source) !== expectedHash) throw new Error('Downloaded source hash mismatch');
  await fs.mkdir(path.dirname(sourcePath), {recursive: true});
  await fs.writeFile(sourcePath, source);
}
if (sha256(source) !== expectedHash) throw new Error('Unexpected pinned Erdos402 source hash');

// Preserve offsets while excluding nested Lean comments, strings and line comments.
function cleanLean(s) {
  let out = '', i = 0, depth = 0, line = false, str = false;
  while (i < s.length) {
    if (depth) {
      if (s.startsWith('/-', i)) { depth++; out += '  '; i += 2; }
      else if (s.startsWith('-/', i)) { depth--; out += '  '; i += 2; }
      else { out += s[i] === '\n' ? '\n' : ' '; i++; }
    } else if (line) {
      out += s[i] === '\n' ? '\n' : ' '; if (s[i] === '\n') line = false; i++;
    } else if (str) {
      if (s[i] === '\\') { out += '  '; i += 2; }
      else { if (s[i] === '"') str = false; out += s[i] === '\n' ? '\n' : ' '; i++; }
    } else if (s.startsWith('/-', i)) { depth = 1; out += '  '; i += 2; }
    else if (s.startsWith('--', i)) { line = true; out += '  '; i += 2; }
    else if (s[i] === '"') { str = true; out += ' '; i++; }
    else { out += s[i]; i++; }
  }
  return out;
}
const clean = cleanLean(source);
const declarationRE = /^(?:@\[[^\]\n]*\]\s*)*(?:(?:private|protected|noncomputable|unsafe)\s+)*(?:def|lemma|theorem|abbrev|opaque|axiom)\s+([^\s({:]+)/gm;
const declarations = [...clean.matchAll(declarationRE)].map(m => ({
  name: m[1], offset: m.index, line: clean.slice(0, m.index).split('\n').length
}));
const byName = new Map(declarations.map(d => [d.name, d]));
for (let i = 0; i < declarations.length; i++) {
  const d = declarations[i];
  const rawEnd = declarations[i + 1]?.offset ?? clean.length;
  d.end = d.offset + clean.slice(d.offset, rawEnd).trimEnd().length;
  const body = clean.slice(d.offset, d.end);
  d.dependencies = [...new Set([...body.matchAll(/[\p{L}_][\p{L}\p{N}_'.]*/gu)]
    .flatMap(m => [m[0], ...m[0].split('.')]).filter(n => n !== d.name && byName.has(n)))];
}
const kept = new Set(), queue = ['erdos_402'];
while (queue.length) {
  const n = queue.pop(); if (kept.has(n)) continue; kept.add(n);
  if (!byName.has(n)) throw new Error('Missing declaration ' + n);
  queue.push(...byName.get(n).dependencies);
}
const selected = declarations.filter(d => kept.has(d.name));
for (const d of selected) {
  if (/\b(?:sorry|admit|axiom|native_decide)\b/.test(clean.slice(d.offset, d.end)))
    throw new Error('Unsupported token in retained declaration ' + d.name);
}
const prefix = source.slice(0, declarations[0].offset)
  .replace('import PrimeNumberTheoremAnd.MediumPNT', 'import ErdosProblems.Erdos49.PNT.MediumPNT');
const annotation = '/- Local extraction of the eventual theorem and its source-identifier dependency closure.\n' +
  'Original authors and references are retained below. Finite native_decide certificates are omitted.\n' +
  'No all-cardinality result is asserted. Reproduce with scripts/extract-erdos402-eventual.mjs.\n' +
  'Pinned source SHA256: ' + expectedHash + '. -/\n';
const output = annotation + prefix + selected.map(d =>
  '-- Pinned upstream declaration ' + d.name + ', original line ' + d.line + '.\n' +
  source.slice(d.offset, d.end)).join('\n\n') +
  '\n\nend Erdos402\n\nalias Erdos402.erdos_402_of_sufficiently_large := Erdos402.erdos_402\n';
await fs.mkdir(path.dirname(destination), {recursive: true});
await fs.mkdir('artifacts/audit', {recursive: true});
await fs.writeFile('artifacts/audit/erdos402-eventual-base.lean', output);
await fs.writeFile(destination, output);
await fs.writeFile('artifacts/audit/gcd402-extraction.json', JSON.stringify({
  revision, source: sourcePath, sourceSha256: expectedHash, destination,
  sourceUrl,
  extractedSha256: sha256(output), declarationCount: selected.length,
  declarations: selected.map(d => ({name: d.name, line: d.line,
    endLine: clean.slice(0, d.end).split('\n').length, sha256: sha256(source.slice(d.offset, d.end))}))
}, null, 2));
console.log('Extracted ' + selected.length + ' declarations; ' + output.split('\n').length + ' lines.');
