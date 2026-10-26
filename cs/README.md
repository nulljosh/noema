# Noema computer science

Busy Beaver: among all Turing machines with n states and two symbols that eventually stop, which runs longest, and which leaves the most ones on the tape?

```sh
python3 -m unittest discover -s tests
python3 busy.py 4
```

The enumerator builds machines as a tree, defining a transition only when a run reaches it, and fixes the first move to the right because the mirror image behaves the same. It reproduces the published values for one through four states: 1, 6, 21 and 107 steps, and 1, 4, 6 and 13 ones. Machines still running at the cap are counted as holdouts; an exact repeated configuration proves a cycle. Until every holdout is decided, the maxima are bounded observations, not proofs. BB(5) = 47,176,870 was proved in 2024 by the bbchallenge collaboration with a Coq-checked proof; that is the frontier this lane reads toward, not one it claims.
