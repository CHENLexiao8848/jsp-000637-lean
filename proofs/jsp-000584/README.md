# JSP-000584 / Erdős 715

## Complete mathematical scope

Every nonempty finite simple 4-regular graph contains a nonempty 3-regular subgraph. The subgraph need not be induced or spanning. The existential cubic-forcing-degree question is also proved by degree four.

## Attribution

V. A. Tashkinov.

The full proof is reused from [plby/lean-proofs](https://github.com/plby/lean-proofs/tree/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest). Original headers and Apache-2.0 licensing are retained. The upstream formal-author headers name Codex / GPT-5.6 Sol; no additional human authorship is inferred. CHENLexiao8848 contributes the explicit JSP interface, packaging, reproduction and catalog evidence, with Codex assistance. No original discovery, first-formalization priority, independent human review or prize entitlement is claimed.

Upstream proof tokens retained; CRLF line endings normalized to LF.

## Reproduce

Lean4.33.0 and Mathlib db584cd6d46c92f209a44c0f1c829460d327499d are pinned. From this directory:

~~~bash
lake exe cache get
python verify.py
~~~

The verifier checks source hashes, builds only this package, audits the listed final declarations, and writes actual results under verification-output/. Use --replay to additionally replay every local module sequentially with the bundled leanchecker. No such replay is claimed in retained local evidence unless actually run.

Entrypoint: [JSP000584.lean](JSP000584.lean). Declarations: Formalization20.jsp_000584, Formalization20.jsp_000584_exists_degree.

[Local evidence](evidence/verification.json) reports the original workspace compilation and axiom audit. Pinned imported caches were reused; public CI performs a clean checkout build of these local sources.

Earlier related public submissions: https://github.com/TheJustinSunPrize/awards/pull/88. This is accurately attributed additional evidence, not a claim that no prior proof exists.
