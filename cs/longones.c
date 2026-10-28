/* Ones left by each long 5-state halter (halters-5.json): read "step machine" lines, run each from blank to its
   --- row, print "step steps ones-before-the-halting-write machine". The halting row then writes 0 or 1.

       cc -O2 -o longones longones.c && python3 platypus.py   (platypus.py feeds it) */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    char m[64]; long step;
    static unsigned char tape[1 << 27];
    while (scanf("%ld %63s", &step, m) == 2) {
        int tr[5][2][3], def[5][2];
        for (int q = 0; q < 5; q++) for (int s = 0; s < 2; s++) {
            char *c = m + q * 7 + s * 3;
            def[q][s] = c[0] != '-';
            if (def[q][s]) { tr[q][s][0] = c[0] - '0'; tr[q][s][1] = c[1] == 'R'; tr[q][s][2] = c[2] - 'A'; }
        }
        memset(tape, 0, sizeof tape);
        long pos = 1 << 26, t = 0, ones = 0; int q = 0;
        while (def[q][tape[pos]]) {
            int s = tape[pos], *e = tr[q][s];
            ones += e[0] - s; tape[pos] = e[0]; pos += e[1] ? 1 : -1; q = e[2]; t++;
        }
        printf("%ld %ld %ld %s\n", step, t + 1, ones - tape[pos], m);
    }
    return 0;
}
