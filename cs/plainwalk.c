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

static void print128(const char *name, i128 v) {
    char buf[48], *p = buf + 47; *p = 0;
    do { *--p = '0' + (int)(v % 10); v /= 10; } while (v);
    printf("%s %s\n", name, p);
}

/* tape[lo..hi] holds the visited cells; the run is at state q, head pos, step t, with d entries defined,
   k states introduced so far, weight f */
static void walk(unsigned char *tape, int lo, int hi, int pos, int q, int t, int d, int k, i128 f) {
    for (;;) {
        if (t == CAP) { capped++; leaves++; return; }   /* as runtimes.py: the cap is checked first */
        int s = tape[pos], e = tr[q][s];
        if (e < 0) break;
        tape[pos] = e & 1; pos += (e >> 1 & 1) ? 1 : -1; q = e >> 2; t++;
        if (pos < lo) { lo = pos; tape[pos] = 0; }
        if (pos > hi) { hi = pos; tape[pos] = 0; }
    }
    /* undefined entry reached: every machine that halts here, then every way to define it */
    i128 w = f * 2 * M;
    for (int i = 0; i < N * M - d - 1; i++) w *= 2 * M * (N + 1);
    halters += w; steps += w * (t + 1); hist[t + 1] += w; leaves++;
    if (d == N * M - 1) return;          /* no entry left to define */
    int s = tape[pos];
    unsigned char *copy = malloc(W);
    for (int wr = 0; wr < M; wr++)
        for (int mv = 1; mv >= (d ? 0 : 1); mv--)
            for (int x = 0; x < (k + 1 < N ? k + 1 : N); x++) {
                i128 g = f * (x == k ? N - k : 1) * (d ? 1 : 2);
                memcpy(copy + lo, tape + lo, hi - lo + 1);
                tr[q][s] = wr | mv << 1 | x << 2;
                walk(copy, lo, hi, pos, q, t, d + 1, x == k ? k + 1 : k, g);
                tr[q][s] = -1;
            }
    free(copy);
}

int main(int argc, char **argv) {
    if (argc < 3) { fprintf(stderr, "usage: plainwalk N CAP\n"); return 1; }
    N = atoi(argv[1]); CAP = atoi(argv[2]); W = 2 * CAP + 8;
    memset(tr, -1, sizeof tr);
    hist = calloc(CAP + 2, sizeof *hist);
    unsigned char *tape = calloc(W, 1);
    walk(tape, CAP + 4, CAP + 4, CAP + 4, 0, 0, 0, 1, 1);
    int distinct = 0, maxstep = 0, lazy = 0;
    for (int i = 1; i <= CAP + 1; i++)
        if (hist[i]) { distinct++; maxstep = i; } else if (!lazy) lazy = i;
    print128("halters", halters);
    print128("stepsum", steps);
    printf("runtimes %d maxstep %d lazy %d leaves %lld capped %lld\n", distinct, maxstep, lazy, leaves, capped);
    for (int i = 1; i <= CAP + 1; i++) if (hist[i]) { printf("t %d ", i); print128("", hist[i]); }
    return 0;
}
