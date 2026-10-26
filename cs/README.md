# Noema computer science

Busy Beaver: among all Turing machines with n states and two symbols that eventually stop, which runs longest, and which leaves the most ones on the tape?

```sh
python3 -m unittest discover -s tests
python3 busy.py 4
```

The enumerator builds machines as a tree, defining a transition only when a run reaches it, and fixes the first move to the right because the mirror image behaves the same. It reproduces the published values for one through four states: 1, 6, 21 and 107 steps, and 1, 4, 6 and 13 ones.

Each decider is a proof that a partial machine never halts from a blank tape. A repeated configuration is a cycle. A translated cycler is a run where the head reaches a new edge in a state it had at an earlier edge on that side, and the tape behind it repeats shifted. Backward reasoning closes the set of configurations that can reach an undefined transition, and checks that the blank tape is not in it. The closed tape reads the tape as runs of short words, and checks that no reachable run reads an undefined transition. The block tape does the same over blocks of two cells, which keeps the parity of a run of ones that the cell version loses.

The n-gram closed position set is the strongest of these. It abstracts a configuration as a state, the symbol under the head, and the nearest blocks on each side. It keeps every window seen on each side. A move pops a new block only when the window it forms is already seen. The closure runs as a worklist, so a configuration is rerun only when a window it waits on appears. The wider stages add closed tapes over blocks of three and four cells, and n-grams of up to three windows over blocks of two to four cells. A last stage reruns each holdout at cap 2,000 through the simulator, so a longer cycle or translated cycle is caught.

Results. At 3 states, cap 200, no holdouts remain. So BB(3) = 21 and Sigma(3) = 6 are decided by this code. That is still a reproduction of Lin and Rado (1965), not new work. At 4 states, cap 300, the first chain leaves 643 holdouts. The wider stages settle 602 of them: block tape k=3 settles 438, block tape k=4 settles 52, n-gram (2 windows, 3-cell blocks) settles 94, n-gram (3, 2-cell) settles 9, n-gram (3, 3-cell) settles 7 and n-gram (3, 4-cell) settles 2. The 41 that remain are open to those deciders. A finite automata reduction pass (`far.py`) settles the 41. Its first search, which grows a DFA and merges states, finds 14 certificates. The direct search finds the other 27 in under three seconds. It is Blanchard's method, written as pushdown reachability: fix a small DFA for the tape left of the head, treat the tape right of the head as a stack, and compute every reachable stack exactly (post* saturation). Left DFAs of up to 4 states settle 25 of the 27, and 5 states settle the last 2. Each certificate is checked for the machine or its mirror. `far-certificates.json` stores all 41, and `busy.py` re-checks each one exactly on every run, with `far_verify.py` checking it again word by word. The cap 2,000 rerun settles nothing once the wider stages run. The run takes about 25 seconds with `python3 busy.py 4`, which prints `"holdouts_at_cap": 0` and `"far_proved": 41` for 4 states.

So BB(4) = 107 and Sigma(4) = 13 are decided by this code: every 4-state machine halts within 107 steps or is proved never to halt. That reproduces Brady (1983). It is not new work. Of the original 41, 32 grow their tape like the logarithm of the steps, which looks like a counter, 7 grow like the square root of the steps, and 2 do neither. The last two, 1RB0RB_1LC1RB_---0LD_1RA1LD and 1RB1LA_1LA0RC_1LD1RC_---0LA, needed the 5-state left DFAs.

Soundness check: the 20,528 machines the deciders flag at 4 states were each run with no deciders for 100,000 steps. None halts. The 3-state flags did not change, so the earlier 3-state checks still hold: none of the flagged machines halts within 100,000 steps, and none of the 4 n-gram flags halts within 1,000,000 steps. The 41 machines the FAR pass settles were each run with no deciders for 1,000,000 steps. None halts. The maxima do not move: 1, 6, 21 and 107 steps, and 1, 4, 6 and 13 ones.

BB(5) = 47,176,870 was proved in 2024 by the bbchallenge collaboration with a Coq-checked proof; that is the frontier this lane reads toward, not one it claims.
