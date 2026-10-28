/* Every machine one or two transitions away from each seed: for each 6-state seed on stdin ("ones machine"), try
   all single and all paired changes of its 12 transitions (write 0/1, move L/R, next state A-F or halt) and print
   "ones machine" for each halter whose ones fall in [LO, HI]. platypus.sim() reruns anything kept.

       cc -O2 -o nbhd nbhd.c && ./nbhd CAP LO HI < seeds.txt */
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
int main(int argc, char **argv) {
    CAP = atoi(argv[1]); LO = atoi(argv[2]); HI = atoi(argv[3]);
    int ones; char seed[64], m[64];
    while (scanf("%d %63s", &ones, seed) == 2) {
        if (strlen(seed) != 41) continue;
        for (int a = 0; a < 12; a++)
            for (int va = 0; va < 28; va++) {
                strcpy(m, seed); set(m, a, va); try(m);
                for (int b = a + 1; b < 12; b++)
                    for (int vb = 0; vb < 28; vb++) { char n[64]; strcpy(n, m); set(n, b, vb); try(n); }
            }
    }
    return 0;
}
