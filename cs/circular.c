/* A394183: the longest halting run of any 2-state 2-symbol machine (12^4 tables, as in the OEIS entry) on an
   n-cell circular tape, over every starting tape, head at cell 0, state A.

       cc -O2 -o circular circular.c && ./circular N [WORKERS INDEX]

   Turning the tape so the head is always at cell 0 leaves 2^(n+1) configurations (state, tape). Each has one
   successor, so one memoized pass over that graph gives every halting time: a run that meets a configuration
   already on its own path is a loop. Tables whose moves are all flipped run the mirror image, so only tables
   whose first moving entry goes right are checked (a table with no move at all is its own mirror). */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

static int n; static uint32_t mask;
static int16_t *t;                     /* -2 unknown, -3 on the current path, -1 loops, else steps to halt */
static uint32_t *path;

static inline uint32_t rot(uint32_t x, int right) {   /* head moves right: cell 1 becomes cell 0 */
    if (n == 1) return x;
    return right ? (x >> 1 | (x & 1) << (n - 1)) : ((x << 1 | x >> (n - 1)) & mask);
}

int main(int argc, char **argv) {
    n = atoi(argv[1]); int K = argc > 2 ? atoi(argv[2]) : 1, I = argc > 3 ? atoi(argv[3]) : 0;
    mask = n == 32 ? 0xffffffffu : (1u << n) - 1;
    uint32_t nodes = 2u << n;
    t = malloc(sizeof *t * nodes); path = malloc(sizeof *path * nodes);
    int best = 0, bestm = -1;
    long long checked = 0;
    for (int m = I; m < 20736; m += K) {
        int W[4], R[4], X[4], c = m;
        for (int i = 0; i < 4; i++) { int d = c % 12; c /= 12; W[i] = d % 2; R[i] = d / 2 % 2; X[i] = d / 4; }
        /* mirror: keep the table if no entry moves, or the first entry that goes on (X < 2) moves right */
        int first = -1;
        for (int i = 0; i < 4; i++) if (X[i] < 2) { first = i; break; }
        if (first >= 0 && !R[first]) continue;
        if (X[0] != 2 && X[1] != 2 && X[2] != 2 && X[3] != 2) continue;  /* no halting entry: nothing halts */
        checked++;
        for (uint32_t i = 0; i < nodes; i++) t[i] = -2;
        for (uint32_t s = 0; s <= mask; s++) {         /* start: state A (node s), every tape */
            uint32_t v = s; int len = 0; int32_t end;
            for (;;) {
                if (t[v] != -2) { end = t[v] == -3 ? -1 : t[v]; break; }
                int q = v >> n, sym = v & 1, e = 2 * q + sym;
                if (X[e] == 2) { t[v] = 1; end = -4; break; } /* halts on this step */
                t[v] = -3; path[len++] = v;
                uint32_t tape = (v & mask & ~1u) | (uint32_t)W[e];
                v = (uint32_t)X[e] << n | rot(tape, R[e]);
            }
            int32_t val = end == -4 ? 1 : end;               /* steps from the node where the walk stopped */
            while (len) {
                uint32_t u = path[--len];
                if (val >= 0) val++;
                if (val > 32000) { fprintf(stderr, "halting time past int16 at table %d\n", m); return 1; }
                t[u] = (int16_t)val;
            }
            if (t[s] > best) { best = t[s]; bestm = m; }
        }
    }
    printf("n %d max %d table %d checked %lld\n", n, best, bestm, checked);
    return 0;
}
