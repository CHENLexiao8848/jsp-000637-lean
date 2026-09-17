"""Exact arithmetic checks for the comparison note; not a Lean proof checker."""
import json


def floor_cuberoot(value):
    assert value >= 0
    lo, hi = 0, 1
    while hi ** 3 <= value:
        hi *= 2
    while lo + 1 < hi:
        mid = (lo + hi) // 2
        if mid ** 3 <= value:
            lo = mid
        else:
            hi = mid
    assert lo ** 3 <= value < (lo + 1) ** 3
    return lo


def guarantees(k, n):
    assert k >= 1 and n >= 0
    square = n * n
    s = floor_cuberoot(square // (6 * k))
    assert 6 * k * s ** 3 <= square < 6 * k * (s + 1) ** 3
    lower = (s + 1) // 2
    coefficient = 24 * k + 4
    root_floor = floor_cuberoot(square // coefficient)
    upper = root_floor if coefficient * root_floor ** 3 == square else root_floor + 1
    assert square <= coefficient * upper ** 3
    assert upper == 0 or coefficient * (upper - 1) ** 3 < square
    if lower:
        t = lower - 1
        delta = 6 * k * (2 * t + 1) ** 3 - coefficient * t ** 3
        expanded = (24 * k - 4) * t ** 3 + 72 * k * t ** 2 + 36 * k * t + 6 * k
        assert delta == expanded > 0
        assert s >= 2 * t + 1
        assert square > coefficient * t ** 3
    assert upper >= lower
    return lower, upper


def main():
    equal = strict = 0
    for k in range(1, 101):
        for n in range(2001):
            old, new = guarantees(k, n)
            equal += old == new
            strict += old < new
    cases = [(4, 1000), (10, 1000), (100, 1000), (4, 1000000), (10, 1000000), (100, 1000000)]
    examples = [{"k": k, "n": n, "earlier_guarantee": guarantees(k, n)[0],
                 "user_guarantee": guarantees(k, n)[1]} for k, n in cases]
    print(json.dumps({"schema_version": 1, "scope": "exact arithmetic certificate comparison; not Lean verification",
                      "pairs_checked": equal + strict, "equal": equal, "strict_improvement": strict,
                      "counterexamples": 0, "examples": examples}, indent=2))


if __name__ == "__main__":
    main()
