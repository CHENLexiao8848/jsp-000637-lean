# Attributed Lean evidence for nine completed JSP problems

This directory contains original-statement Lean interfaces, exact pinned source restoration and verification evidence. The mathematical discoveries and upstream formalization credits are retained.

| JSP | Erdos | Complete scope |
| --- | --- | --- |
| [000628](docs/JSP-000628.md) | 767 | Incident-chord cycle extremal number |
| [000640](docs/JSP-000640.md) | 780 | Monochromatic matching theorem |
| [000655](docs/JSP-000655.md) | 797 | AMR acyclic-coloring bounds |
| [000658](docs/JSP-000658.md) | 801 | Small dense induced subgraph |
| [000660](docs/JSP-000660.md) | 803 | Disproof of absolute regularization |
| [000665](docs/JSP-000665.md) | 808 | Strong sum-product disproof |
| [000672](docs/JSP-000672.md) | 815 | Arbitrarily large C23-free critical graphs |
| [000689](docs/JSP-000689.md) | 833 | Exponential incident-degree bound |
| [000764](docs/JSP-000764.md) | 920 | Clique-free chromatic lower bound |

## Reproduce

Use Python 3.10+, elan and Lean 4.34.0. Mathlib and all dependency revisions are pinned by the included lock. Run these commands from this directory:

~~~bash
python scripts/restore_sources.py
lake exe cache get
python scripts/verify.py all
~~~

Replace all with a six-digit JSP suffix to verify just that complete proof, for example python scripts/verify.py 000628. The verifier first checks exact source hashes, builds the selected module and audits every named theorem's transitive axioms. It rejects any axiom outside propext, Classical.choice and Quot.sound.

## Recorded evidence and limits

All nine local theorem closures compiled and all 66 named-theorem axiom checks succeeded; per-problem logs and structured evidence are under evidence/. The source hashes match the current tested files. The original verifier did not record historical lock-file hashes; current dependency commits were separately confirmed and one final whole-project local build succeeded for publication (3712 jobs). This does not claim a fresh full Mathlib rebuild, independent checker implementation, or independent human review.

Source restoration is checked against the exact bytes used by those tests. No private attachment, chat, identity/payment information, credential or .lake cache is published. See [ATTRIBUTION.md](ATTRIBUTION.md), [sources.json](sources.json), [expected_sources.json](expected_sources.json), and [problems.json](problems.json). Maintainers decide acceptance, attribution, priority and eligibility.
