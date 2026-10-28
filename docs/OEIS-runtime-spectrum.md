# New OEIS sequence: the runtime spectrum. Draft for Joshua.

Joshua signs in at https://oeis.org/login, opens https://oeis.org/submit and fills in the fields below. Nothing goes to OEIS until he does, and an editor reviews it first. Search first: https://oeis.org/search?q=1,6,21,79,1207 should find nothing.

## Fields

Name:

    Number of distinct running times of halting n-state 2-symbol Turing machines started on a blank tape.

Data:

    1, 6, 21, 79, 1207

Offset: 1,2

Comments:

    The running times are the elements of the runtime spectrum R(n) in Aaronson, section 5.9, where he asks how many distinct runtimes there are. The machines and the step count are those of A060843 and A004147: 5-tuple machines with moves left or right, counting the halting step.
    a(n) <= A060843(n), and A337805(n) - 1 <= a(n), since every time below the Lazy Beaver number occurs.
    For n = 5, the 919 times up to 2000 all appear in a run capped at 2000 steps. The other 288 are the distinct times of the 333 halting branches that pass step 2000, each rerun from blank. The second longest time is 23554764, the runner-up found by Marxen and Buntrock (see Michel's survey). - Joshua Trommel, Oct 27 2026

Example:

    a(2) = 6: the 2-state machines halt in exactly 1, 2, 3, 4, 5 or 6 steps (see A337805).

Links:

    Scott Aaronson, <a href="https://www.scottaaronson.com/papers/bb.pdf">The Busy Beaver Frontier</a>, SIGACT News 51 (2020), section 5.9.
    Pascal Michel, <a href="https://arxiv.org/abs/0906.3749">The Busy Beaver Competition: a historical survey</a>, arXiv:0906.3749.
    Joshua Trommel, <a href="https://github.com/nulljosh/labs/blob/main/noema/cs/halters.c">C program</a> and <a href="https://github.com/nulljosh/labs/blob/main/noema/cs/halters-5.json">5-state output</a>.

Cross-references:

    Cf. A004147, A060843, A337805, A386859.

Keywords: nonn,hard,more

## Note to the editor

The same program gives A004147(1..5) and A386859(1..4) exactly and A337805(1..5). The step cap for n = 5 relies on S(5) = 47176870 (Coq-BB5, arXiv:2509.12337). The program was written with the help of an AI coding assistant; I checked the results as described.
