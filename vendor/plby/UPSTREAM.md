# Upstream attribution and local changes

- Repository: https://github.com/plby/lean-proofs
- Pinned commit: `8822f7ddef30fadbd92e1c6ab4ed897af356af5e`
- Source: https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos777.lean
- Original target: Lean / Mathlib v4.33.0.
- Local target: Lean v4.34.0; Mathlib `5ed2965256430c3649e86755f9576b54eca72435`.
- Copyright: 2026 The Lean-Proofs Authors.
- License: Apache-2.0. The original file header is retained; the complete license is in `LICENSE` and the upstream license notice in `LICENSE.upstream`.
- Informal mathematical authors credited upstream: Noga Alon, Péter Frankl, Shagnik Das, Roman Glebov, Benny Sudakov.
- Formal authors credited upstream: Codex and GPT-5.6 Sol.

Local changes on 2026-09-17:

1. Update the version comment.
2. In `four_mul_edges_le_sq_of_triangleFree`, rewrite the new `turanNumber` bound using `SimpleGraph.turanNumber_two`, then apply `Nat.mul_div_le`. This replaces the v4.33-specific expanded-form simplification and leaves the lemma statement unchanged.
3. Add the separate `Jsp637` module exposing the three answers with explicit quantifiers and the catalog ID.

The full mathematical proof is reused with attribution. No original authorship, first-publication priority, or award eligibility is claimed.
