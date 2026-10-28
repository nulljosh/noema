/* 6-state witnesses for the Placid Platypus. For each 5-state machine on stdin ("v machine", bbchallenge
   notation, one Z halting row), send the halting row to a new state F with every write and move, try every pair
   of rows for F, and print the first 6-state machine found for each ones count as "ones machine". Runs are cut
   at CAP steps (first argument). platypus.py feeds it and reruns every machine it keeps.

       cc -O2 -o sixstate sixstate.c && ./sixstate 150000 < bases.txt */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int CAP = 20000;
#define T (1 << 18)
static unsigned char tape[T];
static int W[6][2], R[6][2], X[6][2];   /* X = next state, 6 = halt, -1 = undefined */
static char seenv[1 << 18];
static int LO = T / 2, HI = T / 2;
static int run(void) {
    int lo = T / 2, hi = T / 2, p = T / 2, q = 0; LO = HI = T / 2;
    for (int t = 0; t < CAP; t++) {
        int s = tape[p], x = X[q][s];
        if (x < 0) { int o = 0; for (int i = lo; i <= hi; i++) o += tape[i]; return o; }
        tape[p] = W[q][s];
        if (x == 6) { int o = 0; for (int i = lo; i <= hi; i++) o += tape[i]; return o; }
        p += R[q][s] ? 1 : -1; q = x;
        if (p < lo) lo = LO = p; if (p > hi) hi = HI = p;
        if (p <= 0 || p >= T - 1) return -1;
    }
    return -1;
}
static void put(int q, int s, const char *c) {
    if (c[0] == '-') { X[q][s] = -1; return; }
    W[q][s] = c[0] - '0'; R[q][s] = c[1] == 'R'; X[q][s] = c[2] == 'Z' ? 6 : c[2] - 'A';
}
static void show(int o) {
    printf("%d ", o);
    for (int q = 0; q < 6; q++) {
        for (int s = 0; s < 2; s++) {
            if (X[q][s] < 0) printf("---");
            else printf("%d%c%c", W[q][s], R[q][s] ? 'R' : 'L', X[q][s] == 6 ? 'Z' : 'A' + X[q][s]);
        }
        printf(q < 5 ? "_" : "\n");
    }
    fflush(stdout);  /* a stopped run keeps what it found */
}
int main(int argc, char **argv) {
    if (argc > 1) CAP = atoi(argv[1]);
    int v; char m[64];
    while (scanf("%d %63s", &v, m) == 2) {
        int hq = -1, hs = -1;
        for (int q = 0; q < 5; q++) for (int s = 0; s < 2; s++) {
            char *c = m + q * 7 + s * 3; put(q, s, c);
            if (c[2] == 'Z') { hq = q; hs = s; }
        }
        if (hq < 0) continue;
        for (int w = 0; w < 2; w++) for (int d = 0; d < 2; d++)
            for (int a = 0; a < 26; a++) for (int b = 0; b < 26; b++) {
                W[hq][hs] = w; R[hq][hs] = d; X[hq][hs] = 5;
                W[5][0] = a < 2 ? a : (a - 2) / 12; R[5][0] = a < 2 ? 1 : (a - 2) / 6 % 2; X[5][0] = a < 2 ? 6 : (a - 2) % 6;
                W[5][1] = b < 2 ? b : (b - 2) / 12; R[5][1] = b < 2 ? 1 : (b - 2) / 6 % 2; X[5][1] = b < 2 ? 6 : (b - 2) % 6;
                int o = run();
                memset(tape + LO, 0, HI - LO + 1);
                if (o >= 0 && o < (1 << 18) && !seenv[o]) { seenv[o] = 1; show(o); }
            }
    }
    return 0;
}
