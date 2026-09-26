# JSP-000838: preserved CI evidence and migration review

Reviewed and preserved on 2026-09-26 for [awards PR #707](https://github.com/TheJustinSunPrize/awards/pull/707). **The selected proof's existing Linux CI passed on 2026-09-17. This document reviews and preserves that execution; no new Lean run was performed on 2026-09-26.**

Selected proof A: `48fd10d0009408a1a3cdd1640bc22884facf00c3`, in [https://github.com/CHENLexiao8848/jsp-000637-lean](https://github.com/CHENLexiao8848/jsp-000637-lean), branch `codex/jsp-000301-000139-000838`, project `packages/jsp-000838/proof`. The companion [mathematical and contribution supplement](review-supplement.md) explains statement scope and prior work. The [corrected migration note](MIGRATION.md) replaces the mistaken raw-byte-identity description. These later documents do not replace proof A.

## CI identity and archive preservation

- [Run 35226624341](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341), selected proof A, and [JSP-000838 job 105219764302](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/job/105219764302), completed successfully on 2026-09-17.
- [Artifact 10499142078](https://github.com/CHENLexiao8848/jsp-000637-lean/actions/runs/35226624341/artifacts/10499142078), `jsp-000838-verification`: **6,597 bytes**, ZIP SHA-256 `a2eee9c44184ad300b96e4aa4f9d1a211df99217e829d92fcc400fe986686812`, independently recomputed and matching GitHub metadata and the upload log. ZIP integrity and every extracted member's bytes were checked.
- GitHub metadata listed expiry `2026-12-16T13:22:08Z`. The short current CI records below are preserved verbatim so these results do not depend solely on temporary artifact access. Historical files also packaged in that artifact are explicitly separated below.

## Actual scope of the successful CI

The [fixed workflow](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/.github/workflows/jsp-batch.yml) starts from a fresh Ubuntu checkout, disables the GitHub project cache and enables pinned Mathlib dependency caches. The actual job records both project-cache restore and save as skipped. The selected package tree contains no tracked `.lake` directory or `.olean` files. The build transcript below records **17 newly built modules**, including the root, and successful completion of **1,302 jobs**. `JSP000838/AxiomAudit.lean` is the eighteenth Lean file and was directly elaborated afterward, not included in the default module build count.

The six verifier commands all returned exit 0: toolchain identification, Mathlib HEAD, Mathlib tracked status, `lake build`, direct Main elaboration, and direct axiom-audit elaboration. Its original `clean_requested:false` is retained. Fresh checkout and actual build outputs support fresh compilation of the project; this was not a verifier `--clean` invocation or a rebuild of all Mathlib from source. The verifier recorded no warning lines for those six commands and an empty forbidden-token scan.

All nine named axiom reports appear below, each with only `propext`, `Classical.choice` and `Quot.sound`. The final signatures are also printed. The workflow then explicitly ran `lake env leanchecker --verbose JSP000838.Main`; the successful shell step and overwritten `kernel-replay.txt` support a **Main-entry replay using imported dependencies**. This is Lean's bundled checker, not a second independent checker, a new replay of every local module, or a `--fresh` check of the entire imported environment.

## Historical files that are not new CI executions

The artifact includes files already present at checkout. The bytes of `kernel-replay-result.json`, `leanchecker-result.json`, `leanchecker-fresh.txt` and `leanchecker.txt` equal their preexisting committed blobs. The workflow does not regenerate those files. The first JSON therefore does not itself establish the current replay; the explicit command, successful step and fresh text log do. The other JSON describes earlier evidence at `cee43256a4674c25eb1f4dab64d91d8a7647a584` and says no new full-environment replay occurred during migration. Their inclusion in this artifact is not a new full-environment or all-local-module replay. They are hash-identified below without being presented as current-run results.

The fixed source's Windows `evidence/summary.json` is another historical execution; the Linux artifact's `summary.json` reproduced below is the source of this report's current CI command, input and axiom conclusions. These are submitter-controlled machine checks, not independent human mathematical review, organizer verification, authorship proof, priority or prize eligibility.

## Input and dependency identity

All **22 recorded verification inputs** were independently rehashed against A's immutable Git tree and the actual Linux CI summary: 18 Lean files, `lean-toolchain`, `lakefile.toml`, `lake-manifest.json` and `verify.py`. The complete SHA-256 mapping is preserved in the original summary below. Those are hashes of the **new CRLF bytes**. The verifier records that the same input hashes remained unchanged during its checks. The tracked Mathlib worktree was clean.

All nine dependency checkout revisions in the actual job log agree with the fixed manifest:

| Dependency | Exact revision |
| --- | --- |
| `plausible` | `118aa17ee84656b8bd727fef7c458ee8c833385c` |
| `LeanSearchClient` | `ddf04cf3949fa556442341e87d47f9f6e6074707` |
| `importGraph` | `e928b72544873815af278d38681b31c0293588e3` |
| `proofwidgets` | `106ff4fafc74ef4ac99d81dbf3ab399118f497a5` |
| `aesop` | `355695d523e41d0554926416cba2a2b3544fbbc9` |
| `Qq` | `6a489d9af5d0c47e5b259e2e8bcdfc1811b5a259` |
| `batteries` | `f2effa3d803fda822b1f97b806c47cf2adfbcbc2` |
| `Cli` | `e92c9f15fdfacc8536f31cfb3b7ad26c3c8cd204` |
| `mathlib` | `5ed2965256430c3649e86755f9576b54eca72435` |

## Migration identity: LF to CRLF, not byte identity

Old original public source: [`CHENLexiao8848/awards`, `cee43256a4674c25eb1f4dab64d91d8a7647a584`](https://github.com/CHENLexiao8848/awards/tree/cee43256a4674c25eb1f4dab64d91d8a7647a584/submissions/jsp-000838/proof), rooted at `submissions/jsp-000838/proof`. New source A is rooted at `packages/jsp-000838/proof`.

All 18 Lean files differ as raw bytes and Git blobs. Replacing **only CRLF with LF** in each new file reproduces the exact old blob and old SHA-256. No other content change is needed. Both commit trees used for comparison are complete and non-truncated. The historical `migration-source-hashes.json` hashes identify the new CRLF bytes despite naming the old commit as source provenance. The table distinguishes the two versions explicitly.

| Lean file | Old LF SHA-256 | New CRLF SHA-256 |
| --- | --- | --- |
| `JSP000838.lean` | `e54bb27b042292910d6556c669743f7c20743fa1ae19a40f452ad2d7e5a5d171` | `5b8c6c601f5a8edad7ca65f3b779d9bf15ffa3022d2f24e521a05283efce3858` |
| `JSP000838/AxiomAudit.lean` | `ecb845f0dfb8e3804ecd6e74192a72a6ea446d5ee69e7a2bde91fa72ebd9efe1` | `ffcfeb853d53e0f45ac3d72624762984c6f6ba5227aaa592794ec502e92f156c` |
| `JSP000838/Carrier.lean` | `176db3c3b96d7e18c554828c11674c498c3e72027ad5cc32742f698afe1cb64f` | `44c734bd31475ae44fca860905edfcb813352b61890e898c0d2136eaeca17c57` |
| `JSP000838/CoverObstruction.lean` | `0007879c92147d0e7c841a3142689f9f1ef5c2f70d33a3ebd67c7d0938be5103` | `2ce86b10bd5fcf65fb0b18c58cbf2025fc7137e6ba1be8c3c59dd5b497402cb1` |
| `JSP000838/Cycles.lean` | `52a86bc3f9dfd33cab5b48bd2b3baa0f8bbb723c2777edd063f5d3fae8ae1819` | `2a534490e7aa2cbfb38ee27ce523ede2b60b152e4304daa11ccfeea1c9eba086` |
| `JSP000838/Defs.lean` | `ecfaf2a91975a7c03c90d128b535b470b63c5cc7f33d8000c1984fc1139d411b` | `727b5ada4209fdcb93deb6250aef11e51123927bb80d0976c36e14682694e4d1` |
| `JSP000838/FiniteChoice.lean` | `a0e50ce5269a1fde58e74edc4986b5591e5a8c3bc20c2079bce5aa85a1766524` | `dc113541e932a4114a5ccd22cb232deddccae6e74d8455f0ab67ef38df44c937` |
| `JSP000838/FiniteSeparation.lean` | `c206da5dde383f29e548a2be596840887a457e1862a15a9968df1230cbae0c0c` | `eb0d767d57070a1f81478a31060c33e9f1062357724d4a0ba04712ea9b56f2ef` |
| `JSP000838/Gluing.lean` | `86ce651841186d135ab8d25552140ec3bbdbaa6a52c1f1937de4c7d32cac7a87` | `6fee4b8f4e5fd1b54765333a5284022f99ad4cbc41c7c0defc20ef77f25ce3f3` |
| `JSP000838/HasseBridge.lean` | `6cc0df1b401b15ba6bf7183464b1f300ce7177bec7108ac078becd45cebc44bc` | `0f98c2147e836976c2af52e723854253f591d4a313ef09723887107b1616f098` |
| `JSP000838/LocalCycle.lean` | `a74aa2b37a03d0891106639ce6df3af659bcc8d2b72f55b76be39afa82af79f7` | `eb53e0d490556aae1256f586266cb40e2e54f57e2002e0629352b6c6abb0643f` |
| `JSP000838/Main.lean` | `6ec0df95e8c1b0d1dae6236f1e74bda145768c8f0a491ad014f929e0d9017079` | `c43a160085fffb6b73afe24e67476486ee83b172e792248bba9dd52393be33e0` |
| `JSP000838/OrderedObstruction.lean` | `47deda879ff84ad6c28d66ab9a6da2badb82724882bececb9f31d9ce6de661fc` | `fb48ac396f264deaa35451c258e1b435200f13c87db4560d4a40b5bc144f8260` |
| `JSP000838/Orientation.lean` | `3f097617eb7ee1f8498bc2e2bd32404e8942440d7698a68045d0481ab9f4643e` | `ec6e632b52068208dc85c8df0f1ed1ce490c770e55e3fd3c5916b26e07566f02` |
| `JSP000838/Pasting.lean` | `1cd9d46c662af6dd6e95e025d238c3e9b9bfcd1d9c9b1934f336c7f0e37e9c63` | `d4ec4f4359a3790e2911484e2f429804ed64208ae44a5554799723a4e1377f5e` |
| `JSP000838/Reachability.lean` | `5b0e74acc98e34faf3a712aba7299891c6ff9bcf4951aba72557ee26e3d6d5d5` | `7c79650c8d73875884ebe242126a4569aeb824dd8a3e77278cd44d05a98a9854` |
| `JSP000838/ReverseEdge.lean` | `77ae5f3429dd443b01270a03a5ee7903e7ac95cbed6b04b954a76c8199dbfecc` | `9aa0220cfb8cddaf0a68aadb17217fe4861e2349549d320ba75aa1e0b8c3ea9c` |
| `JSP000838/SourceTheorem.lean` | `277a5ff09be714028758784d94f748399d3c3c943446a51bdac276cb28109302` | `3f699d1c8e550598fed2ff388281fc14c13ef5c5e6643882cb160bbbdd4464fe` |

| Lean file | Old Git blob | New Git blob |
| --- | --- | --- |
| `JSP000838.lean` | `264176a303f84658f8f2db118f7a630179f4421d` | `4b783b72bbf7c87f6fdf1dd05244d9478357a6d1` |
| `JSP000838/AxiomAudit.lean` | `30e337af9c338fac5ea387b4844573bae93feea5` | `1d75c03da31e9a63328001186f6343c2ffaaae19` |
| `JSP000838/Carrier.lean` | `f436ee2009bc3694db88bb58e19b9d52f968c5f8` | `44113996db94a033cf7060bbcc1f8fbd86104469` |
| `JSP000838/CoverObstruction.lean` | `ac732f13ce02a961fbacacf2575d033418f2de34` | `6a286e69c87fcc55b908d47eb3f30cf9eeb6a733` |
| `JSP000838/Cycles.lean` | `ef165246247d5329839b778ca8f892cab82090e0` | `47a198084e3addd692232e504aa58179a7a6f09d` |
| `JSP000838/Defs.lean` | `8362e23045a5e2d0ee568c53280a2695c570c51e` | `5e90eb5a10355b4b84cc1285ee650b4ea373d0a6` |
| `JSP000838/FiniteChoice.lean` | `87acfef43ad111cea00df1fed4d26de54404df5d` | `070fddd3ff840ea55d1fca5a423a7c4840764de8` |
| `JSP000838/FiniteSeparation.lean` | `7e1f6925a858f4215ca7bf4619171f01ae4bde36` | `f1f2fb70198cccf14427f5486fd808cceb043705` |
| `JSP000838/Gluing.lean` | `54144ae1fdb3321397f9b4ce7af5db1d00c807c9` | `339bcd6ebc87ac663a37076ff07445d5e4392e00` |
| `JSP000838/HasseBridge.lean` | `7ab4a865467a61f46ece8244c58360eba9b7c161` | `ee4f1d8941b8080de1e4fed72b21844536da5f64` |
| `JSP000838/LocalCycle.lean` | `95bf3c6a53a6d6f244402e48aacb792952e07d16` | `4604e287b3b4f0a139770dc8774a87ba892ea00f` |
| `JSP000838/Main.lean` | `d3259b25668543c4a4d1dc28a3971313470a9470` | `962df8efb937a5f231b2e605405df27d5e9ef2e8` |
| `JSP000838/OrderedObstruction.lean` | `b1eec8b08c02bcb59e220bd9619db294df5b3c10` | `9ee1ac18d7bf7ace173ba1bbf8423d84490882b7` |
| `JSP000838/Orientation.lean` | `058076f4028c5268a5240aa2bda892cf17403e5c` | `181de14a1854a5c5f608a4d4da8a66f802c89514` |
| `JSP000838/Pasting.lean` | `31b22a3921fdceab024413c2bfdb14a71633634b` | `1913698f9b5c3fca6350dbf6d6b15a554e27fcd2` |
| `JSP000838/Reachability.lean` | `51d9f25912084160ea324cc42b3d2f5b979e2950` | `280fbf56b0d6dce44266b9bd527989bbc0423cc1` |
| `JSP000838/ReverseEdge.lean` | `03ec9d6968dedc18824ee3b816ac535c5b65ee72` | `1224d3e615a1d6fbfcafeb8ac65b18583bad544c` |
| `JSP000838/SourceTheorem.lean` | `b5b9b5a96ecf2ac82b44807b69044ba8c4360555` | `72a19b37f792740c0027350e35cc2814e1e93cd8` |

The same newline-only conversion was independently checked for these non-Lean files; the proof license remains MIT.

| File | Old Git blob | New Git blob |
| --- | --- | --- |
| `LICENSE` | `3e673189a5277750596629b4f0e9bcc3e43da80b` | `d09a81e94a8196090907f656d340bdbed49d67a0` |
| `lean-toolchain` | `12359f928f18e4a89ebd1444a0310b025931b17d` | `4658817ad199fc5a36f9c7411f23a64eea843a89` |
| `lakefile.toml` | `6d4034233f95bb34560d33daafde64144c42c325` | `6af37667f2fbf524cf0ebd71ff33de00056c09d5` |
| `lake-manifest.json` | `71e8762f52b82f7eb5ea044796ac0f295bd42643` | `5c6854477986f38c86b98523e724b2a0e046cda9` |
| `verify.py` | `b8b5cbe152eabc38514bae5eaeceb4d29a314673` | `9d030a4095188db9cfcae08c867a14391b128630` |

## Artifact member hashes

Hashes below were independently recomputed from the ZIP. Current short records are embedded as their original UTF-8 text with LF endings; empty records are explicitly identified. The preexisting CRLF files are hash-identified only, without changing their bytes or attributing them to a new run.

| Original member | SHA-256 | Treatment |
| --- | --- | --- |
| `axioms.txt` | `32df7bdfdf43616d9a3e7c871422415ecbf052303d9a105053e01a6985aa86d6` | Original full text below |
| `build.txt` | `249bf9e33670dd2639af7afc579f029ed11a527a2b9afc0ae7dc33fd5931e537` | Original full text below |
| `kernel-replay-result.json` | `b3682418a9083925a7a5e9ac85869241aa4f005214f287941ffa605f4a66e3ff` | Preexisting record; hash only |
| `kernel-replay.txt` | `22bb145612b1260019278cafcefeb6a87b0f690001222422f95f8965eb009e32` | Original full text below |
| `leanchecker-fresh.txt` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` | Preexisting record; hash only |
| `leanchecker-result.json` | `5cd06e83a5fcb02079adc1399e3fc9bd4891374f26c8d6e1c5b63f7b29079e18` | Preexisting record; hash only |
| `leanchecker.txt` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` | Preexisting record; hash only |
| `main.txt` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` | Empty current record |
| `mathlib-head.txt` | `32cdc265134a1c8d482764d3fe02900f0f1f7f7899895ef0691000865651df5f` | Original full text below |
| `mathlib-status.txt` | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` | Empty current record |
| `migration-source-hashes.json` | `de1698f9725693c1f3ab17a1c53f6b4de729b11201912c5ec814f085490b7e4f` | Preexisting record; hash only |
| `placeholder_scan.json` | `4cd0d16e94c551f9f3c967ee397df732a6c4fcb9cfb46d2fa55ebee4610d226c` | Original full text below |
| `summary.json` | `f1efef8793032f8234303032cee3a670bbc04e01cda2a0f82f8973cf2860df0d` | Original full text below |
| `toolchain.txt` | `cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d` | Original full text below |

`main.txt` and `mathlib-status.txt` are empty original current-run records (zero bytes); their commands returned exit 0.

## Original job-log excerpts

These exact lines bind checkout, skipped project caches, and the artifact upload. Other lines are omitted.

```text
2026-09-17T13:22:13.6186106Z 48fd10d0009408a1a3cdd1640bc22884facf00c3
2026-09-17T13:22:23.9219949Z ##[end-action id=__leanprover_lean-action.__actions_cache;outcome=skipped;conclusion=skipped;duration_ms=0]
2026-09-17T13:23:53.8902451Z ##[end-action id=__leanprover_lean-action.__actions_cache_2;outcome=skipped;conclusion=skipped;duration_ms=0]
2026-09-17T13:24:16.9557490Z SHA256 digest of uploaded artifact zip is a2eee9c44184ad300b96e4aa4f9d1a211df99217e829d92fcc400fe986686812
2026-09-17T13:24:17.1981451Z Artifact jsp-000838-verification.zip successfully finalized. Artifact ID 10499142078
2026-09-17T13:24:17.1982569Z Artifact jsp-000838-verification has been successfully uploaded! Final size is 6597 bytes. Artifact ID is 10499142078
```

## summary.json

Original SHA-256: `f1efef8793032f8234303032cee3a670bbc04e01cda2a0f82f8973cf2860df0d`.

```json
{
  "format_version": 1,
  "status": "PASS",
  "started_utc": "2026-09-17T13:23:53.939634+00:00",
  "verification_scope": "Local Lean kernel compilation, source scan and axiom audit. This is not an independent checker or an isolated environment.",
  "expected_lean": "4.34.0",
  "expected_mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
  "clean_requested": false,
  "commands": [
    {
      "command": [
        "lake",
        "env",
        "lean",
        "--version"
      ],
      "log": "toolchain.txt",
      "started_utc": "2026-09-17T13:23:53.944174+00:00",
      "exit_code": 0,
      "finished_utc": "2026-09-17T13:23:54.661397+00:00",
      "warning_lines": 0
    },
    {
      "command": [
        "git",
        "-C",
        ".lake/packages/mathlib",
        "rev-parse",
        "HEAD"
      ],
      "log": "mathlib-head.txt",
      "started_utc": "2026-09-17T13:23:54.662089+00:00",
      "exit_code": 0,
      "finished_utc": "2026-09-17T13:23:54.663994+00:00",
      "warning_lines": 0
    },
    {
      "command": [
        "git",
        "-C",
        ".lake/packages/mathlib",
        "status",
        "--porcelain",
        "--untracked-files=no"
      ],
      "log": "mathlib-status.txt",
      "started_utc": "2026-09-17T13:23:54.664468+00:00",
      "exit_code": 0,
      "finished_utc": "2026-09-17T13:23:54.842888+00:00",
      "warning_lines": 0
    },
    {
      "command": [
        "lake",
        "build"
      ],
      "log": "build.txt",
      "started_utc": "2026-09-17T13:23:54.843251+00:00",
      "exit_code": 0,
      "finished_utc": "2026-09-17T13:24:08.793634+00:00",
      "warning_lines": 0
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "JSP000838/Main.lean"
      ],
      "log": "main.txt",
      "started_utc": "2026-09-17T13:24:08.793984+00:00",
      "exit_code": 0,
      "finished_utc": "2026-09-17T13:24:10.365575+00:00",
      "warning_lines": 0
    },
    {
      "command": [
        "lake",
        "env",
        "lean",
        "JSP000838/AxiomAudit.lean"
      ],
      "log": "axioms.txt",
      "started_utc": "2026-09-17T13:24:10.365994+00:00",
      "exit_code": 0,
      "finished_utc": "2026-09-17T13:24:11.928120+00:00",
      "warning_lines": 0
    }
  ],
  "sha256": {
    "JSP000838/AxiomAudit.lean": "ffcfeb853d53e0f45ac3d72624762984c6f6ba5227aaa592794ec502e92f156c",
    "JSP000838/Carrier.lean": "44c734bd31475ae44fca860905edfcb813352b61890e898c0d2136eaeca17c57",
    "JSP000838/CoverObstruction.lean": "2ce86b10bd5fcf65fb0b18c58cbf2025fc7137e6ba1be8c3c59dd5b497402cb1",
    "JSP000838/Cycles.lean": "2a534490e7aa2cbfb38ee27ce523ede2b60b152e4304daa11ccfeea1c9eba086",
    "JSP000838/Defs.lean": "727b5ada4209fdcb93deb6250aef11e51123927bb80d0976c36e14682694e4d1",
    "JSP000838/FiniteChoice.lean": "dc113541e932a4114a5ccd22cb232deddccae6e74d8455f0ab67ef38df44c937",
    "JSP000838/FiniteSeparation.lean": "eb0d767d57070a1f81478a31060c33e9f1062357724d4a0ba04712ea9b56f2ef",
    "JSP000838/Gluing.lean": "6fee4b8f4e5fd1b54765333a5284022f99ad4cbc41c7c0defc20ef77f25ce3f3",
    "JSP000838/HasseBridge.lean": "0f98c2147e836976c2af52e723854253f591d4a313ef09723887107b1616f098",
    "JSP000838/LocalCycle.lean": "eb53e0d490556aae1256f586266cb40e2e54f57e2002e0629352b6c6abb0643f",
    "JSP000838/Main.lean": "c43a160085fffb6b73afe24e67476486ee83b172e792248bba9dd52393be33e0",
    "JSP000838/OrderedObstruction.lean": "fb48ac396f264deaa35451c258e1b435200f13c87db4560d4a40b5bc144f8260",
    "JSP000838/Orientation.lean": "ec6e632b52068208dc85c8df0f1ed1ce490c770e55e3fd3c5916b26e07566f02",
    "JSP000838/Pasting.lean": "d4ec4f4359a3790e2911484e2f429804ed64208ae44a5554799723a4e1377f5e",
    "JSP000838/Reachability.lean": "7c79650c8d73875884ebe242126a4569aeb824dd8a3e77278cd44d05a98a9854",
    "JSP000838/ReverseEdge.lean": "9aa0220cfb8cddaf0a68aadb17217fe4861e2349549d320ba75aa1e0b8c3ea9c",
    "JSP000838/SourceTheorem.lean": "3f699d1c8e550598fed2ff388281fc14c13ef5c5e6643882cb160bbbdd4464fe",
    "JSP000838.lean": "5b8c6c601f5a8edad7ca65f3b779d9bf15ffa3022d2f24e521a05283efce3858",
    "lake-manifest.json": "3ce2923cf5748e90c5661f926de0bf314e6466b29063a0b3b98bce4008fc030c",
    "lakefile.toml": "dda4b8d23fc191fc0364a0778ca709ce4023585c4116fc5a6e6097bef1070bfb",
    "lean-toolchain": "744874093261c1854638246b978f088eae15414b0f636ac08481a088a7aaa867",
    "verify.py": "d22d1cf95c9649ad920b7514cf6e01741e052fff80a7eb75411ea74c41ef5b30"
  },
  "source_files": 18,
  "lean_toolchain_file": "leanprover/lean4:v4.34.0",
  "manifest_mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
  "placeholder_scan": {
    "status": "PASS",
    "files_scanned": 18,
    "hits": [],
    "method": "lexical whole-word scan including comments"
  },
  "lean_version_output": "Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)",
  "lean_version": "4.34.0",
  "mathlib_commit": "5ed2965256430c3649e86755f9576b54eca72435",
  "mathlib_tracked_worktree_clean": true,
  "axiom_audit": {
    "status": "PASS",
    "theorems": {
      "JSP000838.exists_large_separated_family": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.exists_ordered_graph_of_carrier": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.exists_noShortCycles_ordered_five": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.exists_noShortCycles_not_cover": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.exists_noShortCycles_not_hasse_subgraph": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.IsRobustAcyclicOrientation.isCoverGraph": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.reverseEdge_not_acyclic_of_intermediate": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.jsp_000838_counterexample": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ],
      "JSP000838.jsp_000838_conjecture_false": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    }
  },
  "sources_unchanged_during_checks": true,
  "finished_utc": "2026-09-17T13:24:11.930436+00:00"
}
```

## build.txt

Original SHA-256: `249bf9e33670dd2639af7afc579f029ed11a527a2b9afc0ae7dc33fd5931e537`.

```text
✔ [990/1137] Built JSP000838.Gluing (1.1s)
✔ [1119/1137] Built JSP000838.FiniteSeparation (1.3s)
✔ [1127/1142] Built JSP000838.FiniteChoice (1.8s)
✔ [1131/1142] Built JSP000838.Carrier (1.7s)
✔ [1133/1142] Built JSP000838.Defs (993ms)
✔ [1134/1142] Built JSP000838.Pasting (1.2s)
✔ [1135/1210] Built JSP000838.LocalCycle (1.4s)
✔ [1136/1210] Built JSP000838.Orientation (1.1s)
✔ [1206/1302] Built JSP000838.ReverseEdge (1.1s)
✔ [1207/1302] Built JSP000838.Reachability (1.1s)
✔ [1295/1302] Built JSP000838.HasseBridge (1.0s)
✔ [1296/1302] Built JSP000838.Cycles (1.3s)
✔ [1297/1302] Built JSP000838.OrderedObstruction (1.1s)
✔ [1298/1302] Built JSP000838.CoverObstruction (1.0s)
✔ [1299/1302] Built JSP000838.SourceTheorem (1.5s)
✔ [1300/1302] Built JSP000838.Main (1.1s)
✔ [1301/1302] Built JSP000838 (1.0s)
Build completed successfully (1302 jobs).
```

## axioms.txt

Original SHA-256: `32df7bdfdf43616d9a3e7c871422415ecbf052303d9a105053e01a6985aa86d6`.

```text
'JSP000838.exists_large_separated_family' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.exists_ordered_graph_of_carrier' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.exists_noShortCycles_ordered_five' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.exists_noShortCycles_not_cover' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.exists_noShortCycles_not_hasse_subgraph' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.IsRobustAcyclicOrientation.isCoverGraph' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.reverseEdge_not_acyclic_of_intermediate' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.jsp_000838_counterexample' depends on axioms: [propext, Classical.choice, Quot.sound]
'JSP000838.jsp_000838_conjecture_false' depends on axioms: [propext, Classical.choice, Quot.sound]
JSP000838.jsp_000838_counterexample :
  ∃ n G, JSP000838.NoShortCycles 5 G ∧ ∀ (D : Fin n → Fin n → Prop), ¬JSP000838.IsRobustAcyclicOrientation G D
JSP000838.jsp_000838_conjecture_false :
  ¬∀ (n : ℕ) (G : SimpleGraph (Fin n)), JSP000838.NoShortCycles 5 G → ∃ D, JSP000838.IsRobustAcyclicOrientation G D
```

## kernel-replay.txt

Original SHA-256: `22bb145612b1260019278cafcefeb6a87b0f690001222422f95f8965eb009e32`.

```text
replaying JSP000838.Main
```

## toolchain.txt

Original SHA-256: `cf6e65bfc214882b1c13717aae89d383a03f6bcf5c96dfbae13368cd3e07ff9d`.

```text
Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)
```

## mathlib-head.txt

Original SHA-256: `32cdc265134a1c8d482764d3fe02900f0f1f7f7899895ef0691000865651df5f`.

```text
5ed2965256430c3649e86755f9576b54eca72435
```

## placeholder_scan.json

Original SHA-256: `4cd0d16e94c551f9f3c967ee397df732a6c4fcb9cfb46d2fa55ebee4610d226c`.

```json
{
  "status": "PASS",
  "files_scanned": 18,
  "hits": [],
  "method": "lexical whole-word scan including comments"
}
```

## Reproduction at A

These instructions describe a new reproduction; they do not relabel the historical CI as having used `--clean`.

```sh
git clone --branch codex/jsp-000301-000139-000838 https://github.com/CHENLexiao8848/jsp-000637-lean.git
cd jsp-000637-lean
git checkout --detach 48fd10d0009408a1a3cdd1640bc22884facf00c3
cd packages/jsp-000838/proof
lake exe cache get
python3 verify.py --clean --output-dir ../evidence-reproduced
lake env lean JSP000838/AxiomAudit.lean
lake env leanchecker --verbose JSP000838.Main
```

The pinned [audit source](https://github.com/CHENLexiao8848/jsp-000637-lean/blob/48fd10d0009408a1a3cdd1640bc22884facf00c3/packages/jsp-000838/proof/JSP000838/AxiomAudit.lean) contains the nine `#print axioms` commands and checks both final theorem signatures. The supplied mathematical solution, contributor history and prior complete proof must be assessed separately from machine-verification success.
