# Noema Computer Science Technical Whitepaper

**v0.2.0** | October 2026

The computer science lane asks how long small Turing machines can run before they stop. It rebuilds the known Busy Beaver values from scratch, proves the small ones in Lean, then uses the same machine tree to count every halting machine and add up how long they all run.

![Architecture](architecture.svg)

## The core mechanic

A machine is grown as a tree. A run from a blank tape starts with no rules. When it reaches a state and symbol with no rule yet, the tree branches over every rule it could have, and only those. A machine that never reaches a rule never needs one, so most of the space is never built.

Each branch ends one of three ways. It halts, a decider proves it never halts, or it hits the step cap and becomes a holdout. A holdout is unfinished work, never a proof.

## Deciders

A repeated configuration is a cycle. A translated cycler reaches a new edge of the tape in a state it had at an earlier edge, with the same nearby cells, so it repeats forever while moving. Backward reasoning shows no configuration can lead to a halt. The n-gram closed position set abstracts the tape to the nearest blocks on each side and closes that set under the rules. FAR certificates give a finite automaton that accepts every reachable tape and no halting one.

## What is decided here

BB(3) = 21 and BB(4) = 107, with no holdouts left. These reproduce Lin and Rado (1965) and Brady (1983). BB(2,3) = 38 too.

## What is machine-checked

Lean 4 checks the cycle and translated-cycler deciders once as theorems, then applies them to every case at 2 and 3 states. All 41 FAR certificates pass `decide +kernel` under one soundness theorem. A checker replays the whole 3-state tree inside Lean, so BB(3) = 21 is proved in full, and BB(2,3) = 38 the same way. No `sorry`, no `native_decide`, axioms propext and Quot.sound only.

## Counting halters

`halters.c` walks the same tree with weights, so each leaf stands for every full machine that agrees with it. Rules a run never reaches are counted, not built. The step cap is the proved Busy Beaver value, so a run that passes it never halts. Machines that pass 2,000 steps are each rerun alone by a second simulator.

At 5 states it counts 26,751,695,615,616 halting machines, matching OEIS A004147(5) and Ligocki's separate count. Their running times add up to 64,068,865,333,248 steps, a term OEIS A386859 did not have. The halting times take 1, 6, 21, 79 and 1,207 distinct values for 1 to 5 states, which answers a question Aaronson asks in The Busy Beaver Frontier, section 5.9. Both new numbers are computed, not proved, and wait for OEIS review.

## Sorting networks

`sortnet.py` finds the fewest comparators that sort n inputs by searching over the sets of 0-1 vectors a network can still output. It gets 0, 1, 3, 5, 9, 12 and 16 for n = 1 to 7, matching OEIS A003075. A reproduction.

## Limits

BB(5) was proved by the bbchallenge collaboration in Coq in 2024. This lane reads toward that, it does not claim it. Counts above 3 states are computed, not checked in Lean. No universal claim comes from a finite run.

MIT License · Copyright 2026 Joshua Trommel.
