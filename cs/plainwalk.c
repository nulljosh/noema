/* Plain tree walk of every n-state 2-symbol machine from blank, with no deciders: only the step cap cuts a
   branch. A second program for the halting counts, step sums and runtimes below a cap, sharing no code with
   halters.c. Same convention and weights as runtimes.py (A004147, A386859).

       cc -O2 -o plainwalk plainwalk.c && ./plainwalk 5 2000

   Children resume from the parent's configuration, so each step is simulated once per branch. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef __int128 i128;
enum { M = 2 };
static int N, CAP, W;                   /* states, step cap, tape width */
static int tr[8][M];                    /* -1 undefined, else w | mv << 1 | next << 2 (mv 1 = right) */
static i128 halters, steps, *hist;
static long long leaves, capped;
static int SIG, KW;                     /* with a third argument: also the ones left on the tape (Placid Platypus); a
                                           number there keeps that many machines per count, for wider searches */
static char **wit;                      /* wit[s * KW + i]: machines that halt with exactly s ones, in bbchallenge notation */
static int *nwit;

/* the current partial table, halting on (q, s) after writing w, as 1RB1RZ_... with --- for unused rows */
static char *name(int hq, int hs, int hw) {
    char *b = malloc(8 * N), *p = b;
    for (int q = 0; q < N; q++) {
        for (int s = 0; s < M; s++) {
            int e = tr[q][s];
            if (q == hq && s == hs) p += sprintf(p, "%dRZ", hw);
            else if (e < 0) p += sprintf(p, "---");
            else p += sprintf(p, "%d%c%c", e & 1, (e >> 1 & 1) ? 'R' : 'L', 'A' + (e >> 2));
        }
        if (q < N - 1) *p++ = '_';
    }
    *p = 0;
    return b;
}

static void print128(const char *name, i128 v) {
    char buf[48], *p = buf + 47; *p = 0;
    do { *--p = '0' + (int)(v % 10); v /= 10; } while (v);
    printf("%s %s\n", name, p);
}

/* tape[lo..hi] holds the visited cells; the run is at state q, head pos, step t, with d entries defined,
   k states introduced so far, weight f */
static void walk(unsigned char *tape, int lo, int hi, int pos, int q, int t, int d, int k, i128 f, int ones) {
    for (;;) {
        if (t == CAP) { capped++; leaves++; return; }   /* as runtimes.py: the cap is checked first */
        int s = tape[pos], e = tr[q][s];
        if (e < 0) break;
        ones += (e & 1) - tape[pos];
        tape[pos] = e & 1; pos += (e >> 1 & 1) ? 1 : -1; q = e >> 2; t++;
        if (pos < lo) { lo = pos; tape[pos] = 0; }
        if (pos > hi) { hi = pos; tape[pos] = 0; }
    }
    /* undefined entry reached: every machine that halts here, then every way to define it */
    i128 w = f * 2 * M;
    for (int i = 0; i < N * M - d - 1; i++) w *= 2 * M * (N + 1);
    halters += w; steps += w * (t + 1); hist[t + 1] += w; leaves++;
    if (SIG)                             /* the halting row writes 0 or 1 over the head cell */
        for (int hw = 0; hw < M; hw++) {
            int o = ones - tape[pos] + hw;
            if (nwit[o] < KW) wit[o * KW + nwit[o]++] = name(q, tape[pos], hw);
        }
    if (d == N * M - 1) return;          /* no entry left to define */
    int s = tape[pos];
    unsigned char *copy = malloc(W);
    for (int wr = 0; wr < M; wr++)
        for (int mv = 1; mv >= (d ? 0 : 1); mv--)
            for (int x = 0; x < (k + 1 < N ? k + 1 : N); x++) {
                i128 g = f * (x == k ? N - k : 1) * (d ? 1 : 2);
                memcpy(copy + lo, tape + lo, hi - lo + 1);
                tr[q][s] = wr | mv << 1 | x << 2;
                walk(copy, lo, hi, pos, q, t, d + 1, x == k ? k + 1 : k, g, ones);
                tr[q][s] = -1;
            }
    free(copy);
}

int main(int argc, char **argv) {
    if (argc < 3) { fprintf(stderr, "usage: plainwalk N CAP [sigma]\n"); return 1; }
    N = atoi(argv[1]); CAP = atoi(argv[2]); W = 2 * CAP + 8; SIG = argc > 3;
    KW = SIG && atoi(argv[3]) > 1 ? atoi(argv[3]) : 1;
    wit = calloc((size_t)(CAP + 3) * KW, sizeof *wit); nwit = calloc(CAP + 3, sizeof *nwit);
    memset(tr, -1, sizeof tr);
    hist = calloc(CAP + 2, sizeof *hist);
    unsigned char *tape = calloc(W, 1);
    walk(tape, CAP + 4, CAP + 4, CAP + 4, 0, 0, 0, 1, 1, 0);
    int distinct = 0, maxstep = 0, lazy = 0;
    for (int i = 1; i <= CAP + 1; i++)
        if (hist[i]) { distinct++; maxstep = i; } else if (!lazy) lazy = i;
    print128("halters", halters);
    print128("stepsum", steps);
    printf("runtimes %d maxstep %d lazy %d leaves %lld capped %lld\n", distinct, maxstep, lazy, leaves, capped);
    for (int i = 1; i <= CAP + 1; i++) if (hist[i]) { printf("t %d ", i); print128("", hist[i]); }
    for (int i = 0; SIG && i <= CAP + 2; i++) for (int j = 0; j < nwit[i]; j++) printf("s %d %s\n", i, wit[i * KW + j]);
    return 0;
}
