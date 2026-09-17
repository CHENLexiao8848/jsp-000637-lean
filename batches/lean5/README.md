# Ten complete Lean results from LEAN_5

This frozen batch covers JSP-000653, 000690, 000725, 000733, 000746, 000759, 000842, 000896, 000897 and 001021. See proofs.json and the per-problem files in docs/ for exact statements and attribution.

Lean 4.34.0; Mathlib commit 5ed2965256430c3649e86755f9576b54eca72435. All source dependencies are immutable and hash checked.

## Reproduce

After installing elan and Python 3.12+, run from batches/lean5:

```bash
python scripts/verify.py --problem JSP-000690 --fetch-cache
```

Omit --problem to verify all ten sequentially. The script downloads the external originals into .lake/upstream-src, checks source hashes, builds the chosen target, checks the named theorem axioms against the standard three, and replays the entry module with the bundled Lean kernel checker.

The replay imports its dependencies. It is not --fresh over all Mathlib or an independently implemented second checker. Actual command exit codes, source hashes and sanitized logs are stored under verification/JSP-*/. Linux CI starts from a fresh checkout and verifies each problem separately.

## Contribution and terms

CHENLexiao8848 publishes an attributed proof/reproduction batch with OpenAI Codex assistance. Original mathematical work, reused formal proofs, and local contributions are distinguished in docs/JSP-*.md. Repository ownership does not establish original proof authorship. No first-formalization, independent human review, award, or prize entitlement is asserted.

Included Apache-licensed third-party files retain their original notices: LeanTwenty/Upstream/NOTICE.md and LeanTwenty/External/Erdos882/NOTICE.md. The Apache license text is under licenses/. Other public plby sources are downloaded separately from the immutable commit in upstream-lock.json; no new redistribution license is claimed for them.

One selected batch commit is used in all ten official PRs. Each official PR modifies only the corresponding catalog entry; proof code and build assets remain in this public proof repository.
