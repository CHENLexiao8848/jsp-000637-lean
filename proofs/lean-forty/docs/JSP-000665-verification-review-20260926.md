# JSP-000665 verification and source-adaptation review — 2026-09-26

The checked proof version is `CHENLexiao8848/jsp-000637-lean`, branch `codex/lean-forty-proof-evidence`, commit `48c3418968a906d21ca8327214f344cef0c32a1d`, package `proofs/lean-forty`. This review executed the fixed source extraction and checked bytes and historical evidence. It did not run Lean, create a new clean-build result, or perform a separate kernel replay.

The fixed [source/restoration specification](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/sources.json) points to the complete [plby Erdős808 source](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos808.lean), whose raw SHA256 was reproduced as `95b7dc1da430646787edf04e2b9db862695a458999b638d2356593a5cda64b24`. Running the immutable `scripts/extract_808_disproof.py` produced the 791-line `vendor/plby/ErdosProblems/Erdos808Disproof.lean` with exactly the recorded SHA256 `7310a281db64211f40d349c86751f9937f42c3033d01c4cffa4d4fa6a6d505c3`.

The script preserves the full strong-conjecture disproof while omitting the separately headed complementary incidence-lower-bound development. It replaces the PNT-based eventual prime-block bound with the same interface proved by local `LeanForty.prime_block_le_seventh_eventually`; imports are narrowed accordingly. The local `PrimeBlockBound.lean` derives `Nat.nth Nat.Prime (q²+i) ≤ q⁷` for `q≥64` and `i:Fin q` from Mathlib's Chebyshev estimate. The entry adds the explicit cofinal threshold interface and reuses the upstream counterexample construction. This is a concrete local dependency replacement, not authorship of the complete reused construction or proof of firstness.

Twenty-one selected tracked files matched their fixed Git blob IDs. Seven relevant `expected_sources.json` inputs were independently rehashed: entry, prime-block lemma, graph imports, generated disproof and the three environment files. The original upstream file was separately authenticated as above. The current environment hashes match the per-problem record, and all nine dependency revisions in the publication record match the package manifest. The full nine-problem package's claimed 96 downloads/two generated outputs were not repeated by this focused review; only the relevant 808 extraction and available inputs are claimed here.

The immutable [per-problem build](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/evidence/000665/build.log) reports `Built LeanForty.Problem000665` and success in 3,541 jobs, while replaying cached dependency/local results. The [final shared-package build](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/evidence/final-local-build.log) succeeds in 3,712 jobs, likewise with cached/replayed results. Neither is described as a fresh clean build. No GitHub Actions run was returned for this exact proof SHA when checked; catalog CI does not execute this Lean proof.

The fixed [verification record](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/evidence/000665/verification.json), dated 2026-09-17, reports two successful commands and nine target/dependency axiom checks. Their names and all observed outputs agree with the [published audit](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/audits/Audit000665.lean). The historical command names `scripts/Audit000665.lean`; the fixed published audit now lives at `audits/Audit000665.lean`, which the current verifier uses. That historical path is not presented as a currently available file.

Historical environment hashes were not recorded by the original verifier. The [publication check](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48c3418968a906d21ca8327214f344cef0c32a1d/proofs/lean-forty/evidence/publication-check.json) pins the current dependency state and final package build, but cannot retroactively authenticate missing state from the old command. There is no claim of a fresh Mathlib rebuild, independent human mathematical review, an independently implemented kernel, or organizer acceptance. The complete result remains attributed to the mathematical authors and upstream formalization; local changes alone do not establish an award entitlement.

The following exact target list and SHA256 inventory make the focused review reproducible. The actual audit log is permanently available at the selected commit and contains the complete outputs.

| Target | Observed axioms |
| --- | --- |
| `LeanForty.prime_block_le_seventh` | `Classical.choice, Quot.sound, propext` |
| `Erdos808.blockPrime_le_seventh_eventually` | `Classical.choice, Quot.sound, propext` |
| `Erdos808.counterLabel_injective` | `Classical.choice, Quot.sound, propext` |
| `Erdos808.counterGraph_edge_threshold_eventually` | `Classical.choice, Quot.sound, propext` |
| `Erdos808.counterGraph_output_small_eventually` | `Classical.choice, Quot.sound, propext` |
| `Erdos808.erdos808_disproved` | `Classical.choice, Quot.sound, propext` |
| `LeanForty.Problem000665.strong_sum_product_false` | `Classical.choice, Quot.sound, propext` |
| `LeanForty.Problem000665.explicit_counterexamples` | `Classical.choice, Quot.sound, propext` |
| `LeanForty.Problem000665.positive_injective_labels` | `Classical.choice, Quot.sound, propext` |

| Checked input | SHA256 |
| --- | --- |
| `LeanForty/GraphImports.lean` | `917ca525eabb487832cc34caadaec2b8cb6712c617a1edb661931780260a5b13` |
| `LeanForty/PrimeBlockBound.lean` | `6dff91791542397207636e9be01af254d74de37bd962192946193e60c1be59d3` |
| `LeanForty/Problem000665.lean` | `adebc8194b61f19c89ed23c124408b54c7f1b12d1d245091186c020a63f235b2` |
| `vendor/plby/ErdosProblems/Erdos808Disproof.lean` | `7310a281db64211f40d349c86751f9937f42c3033d01c4cffa4d4fa6a6d505c3` |
| `lakefile.toml` | `8e0d158048010730f9381862c36b521c3de7fc6741979bfd69c5e7a0741c677e` |
| `lake-manifest.json` | `0a058816fc85a2db5dd6bdae9bc9fea01022ecbe924e800619703dbb49d15c81` |
| `lean-toolchain` | `8733782dc070a99b312039cda424f601b80f3be6f6f512627da5ba25adc27632` |
| `evidence/000665/verification.json` | `b9440737053f3d10ba9205bdfa4aee9b5d5fbdbd459f85b22739ce7d49faa6d1` |
| `evidence/000665/build.log` | `1d00ce1254f1380d7dfdd9fcc033ca1f4f707dc87efcb5e2fc861d99c47e8beb` |
| `evidence/000665/axioms.log` | `1a4afea856db1b300558b1c3975b530f2e5c118bbf21832c1b4f599aa80fbcc9` |
| `evidence/publication-check.json` | `9ec7ccb6e77d832642aa1b1f641464ff5c5506522194e1fae55eaf20474df58b` |
| `evidence/final-local-build.log` | `c32be94fa3627c4bd1e9b5fc8bd4b2e4b6271efc38c8e302eca703f3b2bb9ffb` |
