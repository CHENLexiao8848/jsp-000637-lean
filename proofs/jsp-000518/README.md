# JSP-000518 / Erdos 637

## Complete original scope

For every C>0, there are alpha,beta>0 and N such that every C-Ramsey graph G on n>=N vertices has an induced subgraph on at least alpha*n vertices with at least beta*sqrt(n) distinct internal degrees. Both clique and independence bounds and both output lower bounds are retained.

The [original problem](https://www.erdosproblems.com/637) requires both a linear-sized induced vertex set and square-root degree diversity. The stronger n^(2/3) degree bound without the linear size condition is not claimed here.

## Attribution

Boris Bukh and Benny Sudakov; supporting richness results retain the authors credited in their source headers.

The full formal proof is reused from [plby/lean-proofs](https://github.com/plby/lean-proofs/tree/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest). Source copyright/Apache-2.0 notices are preserved. Root formal-author headers identify Codex / GPT-5.6 Sol; they do not establish an additional human author. Supporting modules retain their individual attribution. CHENLexiao8848 supplies this explicit JSP interface, reproducible packaging and verification evidence with Codex assistance. No new mathematical discovery, original authorship of reused proof, first formalization, independent human verification or award entitlement is claimed.

Prior [PR287](https://github.com/TheJustinSunPrize/awards/pull/287) supplies the JKLY n^(2/3) bound and already includes the Bukh-Sudakov proof as reused upstream work. This submission is attributed reproducibility/catalog evidence for the complete original Bukh-Sudakov statement, not a new stronger theorem or priority claim.

## Fixed proof and environment

- Entrypoint: [JSP000518.lean](JSP000518.lean), Formalization20.jsp_000518.
- Full proof: [Erdos637.lean](vendor/plby/ErdosProblems/Erdos637.lean).
- Lean4.33.0, Mathlib db584cd6d46c92f209a44c0f1c829460d327499d and transitive revisions in lake-manifest.json.
- All11 custom imports are included; the only external proof library is pinned Mathlib.

## Reproduce

Run from this package directory after installing elan and Python3.10+:

~~~bash
lake exe cache get
python verify.py
~~~

The verifier checks source hashes, builds the complete local package, prints each final declaration axiom set and saves actual results under verification-output/. Optional --replay runs the bundled Lean checker sequentially over every custom module.

[Retained local evidence](evidence/verification.json) uses successful workspace checks, with the source bytes and environment matched. No new full local build, all-Mathlib fresh replay or independent checker is claimed. The current package CI, if completed, separately records its exact checked commit.
