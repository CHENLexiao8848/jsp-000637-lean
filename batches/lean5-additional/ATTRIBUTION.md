# Attribution and actual contribution

The source repository is [plby/lean-proofs](https://github.com/plby/lean-proofs/tree/8822f7ddef30fadbd92e1c6ab4ed897af356af5e), branch main, commit 8822f7ddef30fadbd92e1c6ab4ed897af356af5e. Its source headers and recorded author labels are retained by the restoration process.

## JSP-000248 / Erdős 292

The official catalog credits Greg Martin, Denser Egyptian fractions, Acta Arithmetica 95 (2000), 231–260, [DOI](https://doi.org/10.4064/aa-95-3-231-260). The reused formal proof derives density one from the stronger positive-upper-density unit-fraction theorem proved in UnitFractions.ErdosProblems. Source: [Erdos292.lean](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos292.lean). Upstream records Codex and GPT-5.6 Sol as formal authors/tools; no unverified human identity is inferred.

The local contribution is an explicit density-limit interface, Lean 4.34 compatibility repairs to nonnegative product lemmas, a hash-checked complete dependency recipe and local verification. This is attributed reuse, not a claim to Martin's mathematical result or the original formalization.

## JSP-000331 / Erdős 402

The original Graham problem and sufficiently-large results are associated with Ronald Graham, Mario Szegedy and Alexandru Zaharescu. The later all-cardinality result is due to R. Balasubramanian and K. Soundararajan, [Acta Arithmetica 75 (1996)](https://www.erdosproblems.com/402). The source header credits the latter work, the Formal Conjectures authors for the statement, and Codex / GPT-5.6 Sol for formalization. The source's remaining finite-to-asymptotic gap is not claimed solved here.

Source: [Erdos402.lean](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos402.lean). Local work extracts the exact eventual theorem and its 138 source declarations, replaces the PNT import with a checked proof of the identical PNT statement, ports three API uses, and proves the witnesses distinct. It omits the unrelated finite native_decide branch rather than claiming it verified. The final axiom checks cover both the underlying theorem and public interface.

The PNT source is [Erdos49/PNT/MediumPNT.lean](https://github.com/plby/lean-proofs/blob/8822f7ddef30fadbd92e1c6ab4ed897af356af5e/src/latest/ErdosProblems/Erdos49/PNT/MediumPNT.lean); all 14 modules and original credits are recoverable through the lock.

CHENLexiao8848 publishes and integrates with OpenAI Codex assistance. Submitter, repository owner, mathematical solver, formalization author and independent verifier are distinct roles. No independent human verification or priority is asserted.
