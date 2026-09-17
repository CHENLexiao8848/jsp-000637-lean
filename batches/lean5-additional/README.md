# Two additional complete LEAN_5 results

This batch publishes the previously checked solutions of **JSP-000248** (Erdős 292) and **JSP-000331** (the sufficiently-large-set statement in the official catalog). It excludes the eight unfinished problems from the original work list.

## Exact scope

- **JSP-000248:** Let A be the natural numbers n for which there is a finite set S contained in {1,...,n}, containing n, with the sum of 1/m over m in S equal to 1. Then |A intersect {0,...,N-1}|/N tends to 1. Entry: [JSP000248.solution](LeanTwenty/JSP000248.lean).
- **JSP-000331:** There exists a natural threshold N0 >= 2 such that every finite set A of positive natural numbers with |A| >= N0 contains distinct a,b satisfying gcd(a,b) <= a/|A|, with rational division. Entry: [JSP000331.solution](LeanTwenty/JSP000331.lean). The threshold is non-effective. This matches the official catalog's explicit sufficiently-large qualifier; it does not prove the stronger all-cardinalities version.

The per-problem statements, original references, and contribution distinctions are in [docs/JSP-000248.md](docs/JSP-000248.md) and [docs/JSP-000331.md](docs/JSP-000331.md).

## Reproduce

Install Git, Node.js 18+, Python 3.10+, and elan. Lean is fixed to 4.34.0 and Mathlib to 5ed2965256430c3649e86755f9576b54eca72435. From this directory run:

    python scripts/verify.py --problem JSP-000248 --fetch-cache
    python scripts/verify.py --problem JSP-000331

The script checks published source hashes, downloads 25 original external modules at a fixed commit, extracts the eventual Graham proof, applies documented v4.34 compatibility changes, and verifies every resulting source hash against the locally checked source. It then builds the selected theorem and checks its recursive axiom dependencies against propext, Classical.choice, and Quot.sound. Actual new runs write logs and exit codes under verification/.

To restore sources without repeating the Lean build, run python scripts/verify.py --prepare-only.

The [upstream lock](upstream-lock.json) records original and final hashes. The [extraction lock](extraction-lock.json) pins the 138-declaration eventual-proof extraction. All internal imports resolve within these files; library imports are covered by lake-manifest.json. No BoundedGaps dependency is required: the alternate PNT module proves the identical global MediumPNT type and is included in the checked closure.

## Actual verification and limits

The published entry files and dependency sources match previously kernel-checked local files. Existing successful builds and recursive axiom audits are reused, with commands, exit codes and sanitized logs preserved in [evidence/JSP-000248](evidence/JSP-000248/verification.json) and [evidence/JSP-000331](evidence/JSP-000331/verification.json). The restoration script is separately checked against those exact source hashes. No additional fresh local Lean build or independent human review is claimed. Clean Linux CI is reported only according to its actual result.

## Attribution and terms

See [ATTRIBUTION.md](ATTRIBUTION.md). CHENLexiao8848 is the publishing and submitting account; that does not establish mathematical discovery or original authorship of reused proofs. Local interfaces, compatibility changes, extraction, integration and verification were developed with OpenAI Codex assistance. No first-formalization, independent-human-verifier, award or payment claim is made.

Original plby sources are fetched from immutable public URLs; no license is invented or full unlicensed source redistributed. Small compatibility patches retain upstream context and provenance. No credentials, private attachments, payment or identity records are included.
