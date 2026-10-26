# Noema chemistry

How many different alkanes have n carbon atoms? An alkane is a chain or branched tree of carbons, each carbon bonded to as many hydrogens as it needs. Two alkanes are the same molecule when one tree can be turned into the other without changing which carbons touch. The count is OEIS A000602: 1, 1, 1, 2, 3, 5, 9, 18, 35, 75 for n = 1 to 10, and 366319 at n = 20.

```sh
python3 -m unittest discover -s tests
python3 alkanes.py
```

Two methods count the same thing. The first is exact: rooted alkyl groups come from Pólya's cycle index, and a centroid formula turns them into unrooted trees with at most four bonds per carbon. The second is brute force: grow every tree one carbon at a time and keep one canonical string per shape. They agree for n = 1 to 12. The formula alone runs to n = 100, and every value from 1 to 100 matches the OEIS b-file kept in `benchmarks/`. The b-file is a copy of rows 0 to 100 from https://oeis.org/A000602/b000602.txt, so the check runs offline. Results go to `benchmarks/alkanes-latest.json`.
