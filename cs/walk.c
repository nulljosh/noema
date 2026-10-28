/* Random walk over 6-state machines for Placid Platypus witnesses. Start from seeds on stdin ("ones machine",
   5-state seeds get an unused sixth state), change one or two rows at a time, keep a change in the pool when it
   still halts within CAP with at least KEEP ones (LO - 50 unless given), and print the first machine found for each count in [LO, HI].
   Seeds were the 5-state halters with 100 or more ones; platypus-walk.txt holds what it found, and platypus.py
   reruns every one from blank.

       cc -O2 -o walk walk.c && ./walk SEED 200000 131 152 3000000 < seeds.txt */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define T (1 << 17)
#define P 4096
static unsigned char tape[T];
static char pool[P][64]; static int np;
static int CAP;
static int run(const char *m) {   /* ones on halt, -1 if no halt within CAP */
    memset(tape, 0, T); int p = T / 2, q = 0, lo = p, hi = p;
    for (int t = 0; t < CAP; t++) {
        const char *r = m + 7 * q + 3 * tape[p];
        if (r[0] == '-') break;
        tape[p] = r[0] - '0';
        if (r[2] == 'Z') break;
        p += r[1] == 'R' ? 1 : -1; q = r[2] - 'A';
        if (p < lo) lo = p; if (p > hi) hi = p;
        if (p <= 0 || p >= T - 1) return -1;
        if (t == CAP - 1) return -1;
    }
    int o = 0; for (int i = lo; i <= hi; i++) o += tape[i]; return o;
}
int main(int argc, char **argv) {
    srand(atoi(argv[1])); CAP = atoi(argv[2]); int LO = atoi(argv[3]), HI = atoi(argv[4]); long it = atol(argv[5]); int KEEP = argc > 6 ? atoi(argv[6]) : LO - 50;
    static char seen[1 << 16]; char line[200], m[64];
    while (fgets(line, sizeof line, stdin) && np < P) {
        int o; if (sscanf(line, "%d %63s", &o, m) != 2) continue;
        if (strlen(m) == 34) strcat(m, "_------");   /* 5-state seed: add an unused sixth state */
        if (strlen(m) == 41) strcpy(pool[np++], m);
    }
    for (long i = 0; i < it; i++) {
        strcpy(m, pool[rand() % np]);
        int k = 1 + rand() % 2;
        while (k--) {
            int q = rand() % 6, s = rand() % 2; char *r = m + 7 * q + 3 * s;
            r[0] = '0' + rand() % 2; r[1] = rand() % 2 ? 'R' : 'L'; int x = rand() % 7; r[2] = x == 6 ? 'Z' : 'A' + x;
        }
        int o = run(m);
        if (o < 0) continue;
        if (o >= KEEP) strcpy(pool[rand() % np], m);
        if (o >= LO && o <= HI && !seen[o]) { seen[o] = 1; printf("%d %s\n", o, m); fflush(stdout); }
    }
}
