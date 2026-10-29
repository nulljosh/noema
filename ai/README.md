# Noema AI

Does a published benchmark number match the files the submission released alongside it?

```sh
python3 -m unittest discover -s tests
python3 bench.py fetch DIR && python3 bench.py DIR
```

SWE-bench Verified is 500 software tasks. A submission publishes a results file saying what happened on
each one, and the leaderboard publishes one percentage. The file should cover exactly the 500 tasks.

Across all 182 Verified submissions, only 13 publish a file that lists every task. Six of those 13 do not
cover the 500. One, SWE-agent + GPT-4 (1106), carries 502 entries covering 495 distinct tasks: five tasks
appear more than once and five of the official 500 appear nowhere, so the repeats make up the difference
and 502 against 500 looks complete. The others are simply short, by 1, 4, 4, 8 and 19 tasks.

The remaining 169 cannot be checked at all. 122 publish only exception lists, where a task that was
attempted and failed appears in none of them, so which tasks were attempted is not recoverable from the
file. 47 publish no results file at that path.

The scores are not in dispute. SWE-agent + GPT-4 reads 22.40% on the leaderboard, which is 112 of 500;
over the 495 it attempted it is 22.63%. The point is narrower and more awkward: for 169 of 182 entries on
a leaderboard the field quotes constantly, you cannot tell from the published files which tasks were
attempted, and among the 13 where you can, nearly half fall short of the benchmark.

An error here is a contradiction between published files. It is not a claim that anyone's score is wrong.
