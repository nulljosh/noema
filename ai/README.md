# Noema AI

Does a published benchmark number match the files the submission released alongside it?

```sh
python3 -m unittest discover -s tests
python3 bench.py fetch DIR && python3 bench.py DIR
```

SWE-bench Verified is 500 software tasks. A submission publishes a results file saying, per task, whether a
patch was generated and whether it resolved the issue, and the leaderboard publishes one percentage. Those
two should agree with each other and cover exactly the 500 tasks.

For the SWE-agent + GPT-4 (1106) run, they do not. The results file carries 502 entries covering only 495
distinct tasks: five tasks appear more than once, and five of the official 500 appear nowhere in it, so they
were never attempted. The leaderboard's 22.4% is 112 of 500, which silently counts those five as failures.
Over the 495 actually attempted the rate is 22.63%.

The gap is small and the headline number is not in dispute. What the check shows is that a results file can
look complete, 502 entries against 500 tasks, while missing five of them, because repeats make up the
difference. Counting entries catches nothing; counting distinct task ids does.

An error here is a contradiction between published files. It is not a claim that anyone's score is wrong.
