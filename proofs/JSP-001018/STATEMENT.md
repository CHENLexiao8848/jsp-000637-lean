# Statement correspondence and proof

Source: https://www.erdosproblems.com/1213, retrieved 2026-09-17.
The catalog asks an existence question; the sharper Hegyvári bound is an
additional known result, not a hypothesis silently added to the theorem.

| Original quantity or condition | Lean representation |
|---|---|
| a,K ≥ 1 | `A K : ℕ`, `1 ≤ A`, `1 ≤ K` |
| a finite integer sequence of positive length | `s : ℕ`, `0 < s`, `a : ℕ → ℤ` restricted to indices `< s` |
| first term a | `a 0 = (A : ℤ)` |
| strictly increasing | `∀ j, j+1 < s → a j < a (j+1)` |
| gaps at most K | `∀ j, j+1 < s → a (j+1)-a j ≤ (K : ℤ)` |
| last term exceeds threshold | `(F : ℤ) < a (s-1)` |
| nonempty intervals within sequence | `0 < l`, `0 < m`, `i+l ≤ s`, `j+m ≤ s` |
| different intervals | `Ico i (i+l) ≠ Ico j (j+m)` |
| equal sums | equality of the two integer `Finset.Ico` sums |

The infinite function type is only a representation of a finite sequence:
every finite sequence extends to such a function, and all assumptions and
witness indices are restricted to the first s values. Zero-based half-open
intervals correspond exactly to the original consecutive index intervals.
The positive first term and strict increase imply nonnegative values needed
by `toNat`; `erdos1213_int` proves this and transports both sums explicitly.

## Dyadic counting argument

Bounded gaps give `a(i) ≤ A+Ki`. Put `R=A+3K+2`, `M=2^(2R)`.
For each `0≤r<R`, take every block with length `2^r≤l<2^(r+1)` and
start `0≤i<2^(2R-r)`. There are exactly M blocks per scale, and RM
distinct start/length pairs in total. All end before `2M`.

Their nonnegative sums satisfy
`S(i,l) ≤ l(A+K(i+l)) = Al+Kli+Kl² ≤ (A+3K)M`.
Thus there are at most `(A+3K)M+1 < RM` possible sums. Pigeonhole gives
two equal sums from distinct blocks. Equality of nonempty `Ico` intervals
forces equal start/length pairs, so the output intervals are distinct.

Finally `a(s-1)>A+K(2M)` forces `s≥2M`, making all chosen blocks valid
inside the original finite sequence. No exhaustive bound on s is substituted
for the general theorem; the argument is symbolic in A, K and s.
