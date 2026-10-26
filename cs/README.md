# Noema computer science

Busy Beaver: among all Turing machines with n states and two symbols that eventually stop, which runs longest, and which leaves the most ones on the tape?

```sh
python3 -m unittest discover -s tests
python3 busy.py 4
```

The enumerator builds machines as a tree, defining a transition only when a run reaches it, and fixes the first move to the right because the mirror image behaves the same. It reproduces the published values for one through four states: 1, 6, 21 and 107 steps, and 1, 4, 6 and 13 ones. Two deciders remove holdouts from the search: an exact repeated configuration proves a cycle, and a translated cycler (the head reaches a new edge in a state it had at an earlier edge on that side, and the tape behind it repeats shifted) proves the run never halts. At 3 states the translated-cycler decider takes holdouts at cap 200 from 3,119 to 92, and those 92 are unchanged at caps 400 and 1000, so BB(3) is not yet fully decided. At 4 states, cap 300, holdouts fall from 521,462 to 20,569 and the run takes 14 seconds instead of about 253. Until every holdout is decided, the maxima are bounded observations, not proofs. BB(5) = 47,176,870 was proved in 2024 by the bbchallenge collaboration with a Coq-checked proof; that is the frontier this lane reads toward, not one it claims.
