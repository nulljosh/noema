# Noema chemistry

Python 3.9+, standard library only. `alkanes.py` counts alkane isomers by a Pólya and centroid formula and by brute force, and checks both against the vendored OEIS A000602 b-file.

- Test: `python3 -m unittest discover -s tests`. Study: `python3 alkanes.py` (under a second). The JSON snapshot is `benchmarks/alkanes-latest.json`.
- The reference is `benchmarks/A000602-b-0-100.txt`, cut from the live b-file. Refresh it with curl, never from memory.
