# JSP-000182 / Erdős 190

## Complete mathematical scope

For the least positive N such that every finite vertex coloring of [N] contains a monochromatic or rainbow k-term progression with positive step, H(k)^(1/k)/k tends to infinity. Existence and minimality of H are proved and audited.

## Attribution

J. H. Bae, as explicitly credited by the retained upstream source header.

The full proof is reused from [plby/lean-proofs](https://github.com/plby/lean-proofs/tree/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest). Original headers and Apache-2.0 licensing are retained. The upstream formal-author headers name Codex / GPT-5.6 Sol; no additional human authorship is inferred. CHENLexiao8848 contributes the explicit JSP interface, packaging, reproduction and catalog evidence, with Codex assistance. No original discovery, first-formalization priority, independent human review or prize entitlement is claimed.

Upstream proof tokens retained; CRLF line endings normalized to LF.

## Reproduce

Lean4.33.0 and Mathlib db584cd6d46c92f209a44c0f1c829460d327499d are pinned. From this directory:

~~~bash
lake exe cache get
python verify.py
~~~

The verifier checks source hashes, builds only this package, audits the listed final declarations, and writes actual results under verification-output/. Use --replay to additionally replay every local module sequentially with the bundled leanchecker. No such replay is claimed in retained local evidence unless actually run.

Entrypoint: [JSP000182.lean](JSP000182.lean). Declarations: Formalization20.jsp_000182, Formalization20.jsp_000182_threshold_spec, Formalization20.jsp_000182_threshold_minimal.

[Local evidence](evidence/verification.json) reports the original workspace compilation and axiom audit. Pinned imported caches were reused; public CI performs a clean checkout build of these local sources.

All original-source attribution is preserved; lack of a listed PR here is not a global priority claim.
