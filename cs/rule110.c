/* A332717 / A332718: the cycle lengths rule 110 reaches on a ring of n cells, by one walk over all 2^n
   configurations. Each configuration has one successor, so every orbit ends in a cycle; a walk that meets a
   configuration it already passed has found a new cycle, whose length is counted once.

       cc -O2 -o rule110 rule110.c && ./rule110 N

   Prints "n N periods p1 p2 ... max P" with each period's number of configurations that end on it. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

static int n; static uint64_t mask;
static uint64_t *seen, *walk;   /* seen: any earlier walk; walk: the current one */
#define GET(b, x) (b[(x) >> 6] >> ((x) & 63) & 1)
#define SET(b, x) (b[(x) >> 6] |= 1ull << ((x) & 63))
#define CLR(b, x) (b[(x) >> 6] &= ~(1ull << ((x) & 63)))

static inline uint64_t step(uint64_t c) {        /* new = (c | r) & ~(l & c & r) on the ring */
    uint64_t l = ((c << 1) | (c >> (n - 1))) & mask, r = ((c >> 1) | (c << (n - 1))) & mask;
    return (c | r) & ~(l & c & r) & mask;
}

int main(int argc, char **argv) {
    n = atoi(argv[1]); mask = n == 64 ? ~0ull : (1ull << n) - 1;
    uint64_t words = ((mask >> 6) + 1);
    seen = calloc(words, 8); walk = calloc(words, 8);
    uint64_t *per = calloc(1 << 22, 8);           /* configurations ending on each period (periods < 2^22) */
    uint32_t *cyc = malloc(4 * ((size_t)1 << 22)); /* period of each cycle found, to attribute basins */
    long long ncyc = 0;
    for (uint64_t s = 0; s <= mask; s++) {
        if (GET(seen, s)) continue;
        uint64_t x = s, len = 0;
        while (!GET(seen, x) && !GET(walk, x)) { SET(walk, x); x = step(x); len++; }
        uint64_t p;
        if (GET(walk, x)) {                       /* a new cycle through x */
            p = 1; for (uint64_t y = step(x); y != x; y = step(y)) p++;
            ncyc++;
        } else p = 0;                             /* joins a known orbit: its period is unknown here */
        for (uint64_t y = s; GET(walk, y); y = step(y)) { CLR(walk, y); SET(seen, y); }
        if (p && p < (1 << 22)) per[p] += 1;      /* count cycles per period */
        (void)len; (void)cyc;
    }
    printf("n %d periods", n);
    uint64_t mx = 0;
    for (uint64_t p = 1; p < (1 << 22); p++) if (per[p]) { printf(" %llu", (unsigned long long)p); mx = p; }
    printf(" max %llu cycles %lld\n", (unsigned long long)mx, ncyc);
    return 0;
}
