# Fixed baselines

baseline.json freezes SAT metrics and the canonical enumeration digest. number-theory-baseline.json freezes three bounded stages and their evidence digests. Initial runs established these regression fixtures; they are not external correctness certificates.

Never rewrite a failing baseline automatically. Explain any corrected calculation or domain change before reviewing a new suite version. SAT complete runs retain history, including failures. Partial runs remain under ignored runs/. Accepted viewer findings update only after regression checks pass. Timings and source hashes are informational.

Sieve membership and Goldbach witnesses are checked with trial division. Collatz has known 3, 27 and powers-of-two controls; it has not been compared with an external orbit database. Overlapping stages are not independent samples.

first-descent-baseline.json freezes the initial v1 stage outputs. The v2 study must preserve their stream digests and aggregate results before writing accepted reports. It adds modulo 8 and 16 groups without changing the domain.
