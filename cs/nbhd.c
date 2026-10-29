/* Every machine up to DEPTH transitions away from each seed: for each 6-state seed on stdin ("ones machine"), try
   all changes of up to DEPTH of its 12 transitions (write 0/1, move L/R, next state A-F or halt) and print
   "ones machine" for each halter whose ones fall in [LO, HI]. platypus.sim() reruns anything kept.

       cc -O2 -o nbhd nbhd.c && ./nbhd CAP LO HI [DEPTH=2] < seeds.txt

   Depth 3 is about 90 times the work of depth 2, so feed it few seeds at a time. Depth 0 just reruns the
   seeds, which is how a large list of candidate machines gets filtered in one pass. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define T (1 << 17)
static unsigned char tape[T];
static int CAP, LO, HI;
static int run(const char *m) {   /* ones on halt, -1 if no halt within CAP or off the tape */
    memset(tape, 0, T); int p = T / 2, q = 0, lo = p, hi = p;
    for (int t = 0; t < CAP; t++) {
        const char *r = m + 7 * q + 3 * tape[p];
        tape[p] = r[0] - '0';
        if (r[2] == 'Z') { int o = 0; for (int i = lo; i <= hi; i++) o += tape[i]; return o; }
        p += r[1] == 'R' ? 1 : -1; q = r[2] - 'A';
        if (p < lo) lo = p; if (p > hi) hi = p;
        if (p <= 0 || p >= T - 1) return -1;
    }
    return -1;
}
static void set(char *m, int k, int v) {   /* transition k = 2 * state + symbol gets value v in 0..27 */
    char *r = m + 7 * (k / 2) + 3 * (k % 2);
    r[0] = '0' + v % 2; r[1] = "LR"[v / 2 % 2]; r[2] = "ABCDEFZ"[v / 4];
}
static void try(const char *m) {
    int o = run(m);
    if (o >= LO && o <= HI) { printf("%d %s\n", o, m); fflush(stdout); }
}
static int DEPTH;
static void walk(char *m, int from, int left) {   /* every change of `left` more transitions at index `from` or later */
    if (left < 1) return;
    for (int k = from; k < 12; k++)
        for (int v = 0; v < 28; v++) {
            char n[64]; strcpy(n, m); set(n, k, v); try(n);
            if (left > 1) walk(n, k + 1, left - 1);
        }
}
int main(int argc, char **argv) {
    CAP = atoi(argv[1]); LO = atoi(argv[2]); HI = atoi(argv[3]);
    DEPTH = argc > 4 ? atoi(argv[4]) : 2;
    int ones; char seed[64];
    while (scanf("%d %63s", &ones, seed) == 2)
        if (strlen(seed) == 41) { try(seed); walk(seed, 0, DEPTH); }   /* DEPTH 0 reruns the seeds and nothing else */
    return 0;
}
