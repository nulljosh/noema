// Count every n-state m-symbol machine that halts from blank, and sum their halting times.
// Convention of A052200, A004147 and A386859: a row is (write, move, next) with next a state or
// halt, so 2m(n+1) choices per row, and a halt row keeps its write and move.
// Tree walk: run from blank; at an undefined row the machine may halt there (a leaf, weighted by
// the machines it stands for) or get a new row. The first move goes right (mirror, weight 2) and a
// new state takes the lowest free label (weight = free labels). A node that never reaches an
// undefined row is cut by an exact repeat of the whole configuration (cycler), a translated repeat
// between two record cells (translated cycler), backward reasoning, an n-gram closed position set,
// or the step cap, which must be the known BB value. A run that leaves the tape buffer is counted
// as overflow and leaves the result open.
//   cc -O2 -o halters halters.c && ./halters N M CAP [SPLIT WORKERS INDEX]
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned __int128 u128;
#define TAPE (1 << 22)
#define MAXL 16
#define WIN 512
#define RING 8

static int N, M, NM, SPLIT, K, I;
static long long CAP;
static int8_t TW[8][8], TM[8][8], TX[8][8];  // TX = -1 undefined
static uint8_t *buf[MAXL];
static int dirty_lo[MAXL], dirty_hi[MAXL];
typedef struct { int pos, q, lo, hi; long long t; uint64_t h; } Cfg;
static Cfg cfg[MAXL];
static u128 halters, stepsum;
static long long nodes, leaves, capped, cycles, tcs, overflow, idx;
static long long maxstep, lowmiss = 1 << 30;
static uint8_t seen[1 << 16];

static inline uint64_t z(int p, int s) {
    uint64_t x = (uint64_t)(p * 8 + s) * 0x9E3779B97F4A7C15ull;
    x ^= x >> 31; x *= 0xBF58476D1CE4E5B9ull; x ^= x >> 29;
    return s ? x : 0;
}

typedef struct { int q, p, minsince, wlen; uint8_t win[WIN]; } Snap;
static Snap snaps[2][8][RING];
static int nsnap[2][8];
static uint8_t *brent;
static long long bws, TRIG = 2048;
static int backward(int limit);
static int ngram_any(int limit);
static long long ngs;
static void p128(const char *name, u128 v);

// 1 = stopped at an undefined row, 0 = proved to never reach one (or capped / overflow)
static int run(int l) {
    uint8_t *T = buf[l];
    Cfg c = cfg[l];
    memset(nsnap, 0, sizeof nsnap);
    long long t0 = c.t, next = 1;
    int sq = -1, sp = 0, slo = 0, shi = -1; uint64_t sh = 0;
    int mr = c.pos, ml = c.pos;  // min since last right record, max since last left record
    for (;;) {
        int s = T[c.pos], x = TX[c.q][s];
        if (x < 0) { cfg[l] = c; dirty_lo[l] = c.lo; dirty_hi[l] = c.hi; return 1; }
        if (c.t >= CAP) { capped++; break; }
        int w = TW[c.q][s];
        if (w != s) { c.h ^= z(c.pos, s) ^ z(c.pos, w); T[c.pos] = w; }
        c.pos += TM[c.q][s]; c.q = x; c.t++;
        if (c.pos < 1 || c.pos >= TAPE - 1) {
            overflow++;
            printf("overflow %lld ", c.t);
            for (int a = 0; a < N; a++) { for (int b = 0; b < M; b++) if (TX[a][b] < 0) printf("---"); else printf("%d%c%c", TW[a][b], TM[a][b] > 0 ? 'R' : 'L', 'A' + TX[a][b]); printf(a < N - 1 ? "_" : "\n"); }
            break;
        }
        if (c.pos < mr) mr = c.pos;
        if (c.pos > ml) ml = c.pos;
        int dir = -1;
        if (c.pos > c.hi) { c.hi = c.pos; dir = 0; }
        else if (c.pos < c.lo) { c.lo = c.pos; dir = 1; }
        if (dir >= 0) {
            int ext = dir ? ml : mr, sg = dir ? -1 : 1;
            for (int qq = 0; qq < N; qq++)
                for (int k = 0; k < nsnap[dir][qq]; k++) {
                    Snap *S = &snaps[dir][qq][k];
                    if (dir ? ext > S->minsince : ext < S->minsince) S->minsince = ext;
                }
            int found = 0;
            for (int k = 0; k < nsnap[dir][c.q] && !found; k++) {
                Snap *S = &snaps[dir][c.q][k];
                int L = sg * (S->p - S->minsince);
                if (L > S->wlen) continue;
                int ok = 1;
                for (int i = 1; i <= L && ok; i++) ok = S->win[i - 1] == T[c.pos - sg * i];
                found = ok;
            }
            if (found) { tcs++; break; }
            Snap *S;
            if (nsnap[dir][c.q] < RING) S = &snaps[dir][c.q][nsnap[dir][c.q]++];
            else { memmove(&snaps[dir][c.q][0], &snaps[dir][c.q][1], sizeof(Snap) * (RING - 1)); S = &snaps[dir][c.q][RING - 1]; }
            S->q = c.q; S->p = c.pos; S->minsince = c.pos; S->wlen = WIN;
            for (int i = 1; i <= WIN; i++) {
                int pp = c.pos - sg * i;
                S->win[i - 1] = (pp >= 0 && pp < TAPE) ? T[pp] : 0;
            }
            if (dir) ml = c.pos; else mr = c.pos;
        }
        if (c.q == sq && c.pos == sp && c.h == sh) {
            int ok = 1;
            for (int p = c.lo; p <= c.hi && ok; p++) ok = T[p] == ((p >= slo && p <= shi) ? brent[p - slo] : 0);
            if (ok) { cycles++; break; }
        }
        if ((c.t - t0 == TRIG && backward(2000)) || (c.t - t0 == (1 << 18) && backward(12000))) { bws++; break; }
        if ((c.t - t0 == TRIG && ngram_any(30000)) || (c.t - t0 == (1 << 20) && ngram_any(60000))) { ngs++; break; }
        if (c.t - t0 == next) {
            next *= 2; sq = c.q; sp = c.pos; sh = c.h; slo = c.lo; shi = c.hi;
            memcpy(brent, T + c.lo, c.hi - c.lo + 1);
        }
    }
    dirty_lo[l] = c.lo; dirty_hi[l] = c.hi;
    return 0;
}


// Backward closure over patterns, as busy.backward: 1 = no pattern reaching an undefined row matches blank.
#define BW 9
#define HS 16384
static uint64_t hs[HS];
static int backward(int limit) {
    static uint64_t stack[HS];
    memset(hs, 0, sizeof hs);
    int sp = 0, count = 0;
    for (int q = 0; q < N; q++) for (int s = 0; s < M; s++) if (TX[q][s] < 0)
        stack[sp++] = ((uint64_t)q << 40) | ((uint64_t)1 << (20 + BW)) | ((uint64_t)s << BW);
    uint32_t full = (1u << (2 * BW + 1)) - 1;
    while (sp) {
        uint64_t p = stack[--sp];
        int q = p >> 40; uint32_t mask = (p >> 20) & full, val = p & full;
        if (q == 0 && !(val & mask)) return 0;
        for (int pq = 0; pq < N; pq++) for (int ps = 0; ps < M; ps++) {
            if (TX[pq][ps] != q) continue;
            int ai = BW - TM[pq][ps];
            if ((mask >> ai & 1) && (int)(val >> ai & 1) != TW[pq][ps]) continue;
            uint32_t m2 = mask & ~(1u << ai), v2 = val & ~(1u << ai);
            if (TM[pq][ps] > 0) { m2 = (m2 << 1) & full; v2 = (v2 << 1) & full; }
            else { m2 >>= 1; v2 >>= 1; }
            m2 |= 1u << BW; v2 = (v2 & ~(1u << BW)) | ((uint32_t)ps << BW);
            uint64_t np = ((uint64_t)pq << 40) | ((uint64_t)m2 << 20) | (v2 & m2);
            uint64_t key = np + 1, h = (key * 0x9E3779B97F4A7C15ull) >> 50;
            while (hs[h] && hs[h] != key) h = (h + 1) & (HS - 1);
            if (hs[h]) continue;
            if (++count >= limit || sp >= HS - 1) return 0;
            hs[h] = key; stack[sp++] = np;
        }
    }
    return 1;
}

// n-gram closed position set over k-cell blocks, a port of busy.ngram_cps (m = 2 only).
// 1 = no abstract configuration reachable from blank reads an undefined row.
#define HZ (1 << 17)
typedef struct { uint64_t key[HZ]; int32_t val[HZ]; uint32_t gen[HZ]; uint32_t g; int n; } Map;
static Map mseen, mleft, mright, mwait;
static void mclear(Map *m) { m->g++; m->n = 0; }
static int32_t *mget(Map *m, uint64_t key, int add) {  // NULL when missing (and add == 0) or full
    uint64_t h = (key * 0x9E3779B97F4A7C15ull) >> 47;
    while (m->gen[h] == m->g) { if (m->key[h] == key) return &m->val[h]; h = (h + 1) & (HZ - 1); }
    if (!add || m->n >= HZ / 2) return NULL;
    m->n++; m->gen[h] = m->g; m->key[h] = key; m->val[h] = -1;
    return &m->val[h];
}
#define POOL (1 << 18)
static uint64_t pool_cfg[POOL], work[POOL];
static int32_t pool_next[POOL];
static int ngram(int n, int k, int limit) {
    mclear(&mseen); mclear(&mleft); mclear(&mright); mclear(&mwait);
    int npool = 0, nw = 0, nk = n * k;
    uint64_t mk = (1ull << k) - 1, mnk = (1ull << nk) - 1, mpre = (1ull << (nk - k)) - 1;
    // config = right | left << nk | off << 2nk | cur << (2nk + 3) | state << (2nk + 3 + k)
#define CF(q, cur, off, L, R) ((R) | (L) << nk | (uint64_t)(off) << (2 * nk) | (uint64_t)(cur) << (2 * nk + 3) | (uint64_t)(q) << (2 * nk + 3 + k))
    mget(&mleft, 0, 1); mget(&mright, 0, 1);
    uint64_t start = CF(0, 0, 0, 0ull, 0ull);
    mget(&mseen, start, 1); work[nw++] = start;
    while (nw) {
        uint64_t c = work[--nw];
        uint64_t R = c & mnk, L = (c >> nk) & mnk;
        int off = (c >> (2 * nk)) & 7, cur = (c >> (2 * nk + 3)) & mk, q = c >> (2 * nk + 3 + k);
        int s = cur >> off & 1;
        if (TX[q][s] < 0) return 0;
        int cells = (cur & ~(1 << off)) | (TW[q][s] << off), off2 = off + TM[q][s], nx = TX[q][s];
        uint64_t succ[64]; int ns = 0;
        if (off2 >= 0 && off2 < k) succ[ns++] = CF(nx, cells, off2, L, R);
        else {
            int right = TM[q][s] > 0;
            uint64_t near = right ? L : R, far = right ? R : L;
            Map *mine = right ? &mleft : &mright, *other = right ? &mright : &mleft;
            uint64_t window = (cells | near << k) & mnk;
            int32_t *v = mget(mine, window, 0);
            if (!v) {
                if (!mget(mine, window, 1)) return 0;
                int32_t *w = mget(&mwait, (uint64_t)right << 62 | (window & mpre), 0);  // wake waiters on this side
                if (w) { for (int i = *w; i >= 0; i = pool_next[i]) { if (nw >= POOL) return 0; work[nw++] = pool_cfg[i]; } *w = -1; }
            }
            uint64_t prefix = far >> k;
            int32_t *w = mget(&mwait, (uint64_t)!right << 62 | prefix, 1);
            if (!w || npool >= POOL) return 0;
            pool_cfg[npool] = c; pool_next[npool] = *w; *w = npool++;
            for (uint64_t b = 0; b <= mk; b++) {
                uint64_t ng2 = prefix | b << (nk - k);
                if (!mget(other, ng2, 0)) continue;
                if (right) succ[ns++] = CF(nx, (int)(far & mk), 0, window, ng2);
                else succ[ns++] = CF(nx, (int)(far & mk), k - 1, ng2, window);
            }
        }
        for (int i = 0; i < ns; i++) {
            if (mget(&mseen, succ[i], 0)) continue;
            if (mseen.n >= limit || !mget(&mseen, succ[i], 1) || nw >= POOL) return 0;
            work[nw++] = succ[i];
        }
    }
    return 1;
#undef CF
}
static int ngram_any(int limit) {
    static const int P[][2] = {{2, 2}, {3, 3}, {2, 4}, {4, 4}, {5, 5}};
    for (int i = 0; i < 5; i++) if (ngram(P[i][0], P[i][1], limit)) return 1;
    return 0;
}

static u128 ipow(u128 b, int e) { u128 r = 1; while (e--) r *= b; return r; }

static void node(int l, int d, int k, u128 f) {
    if (d == SPLIT && (idx++ % K) != I) return;
    nodes++;
    Cfg c = cfg[l];
    int q = c.q, s = buf[l][c.pos];
    if (d >= SPLIT || I == 0) {
        u128 wgt = f * (u128)(2 * M) * ipow(2 * M * (N + 1), NM - d - 1);
        halters += wgt; stepsum += wgt * (u128)(c.t + 1); leaves++;
        if (c.t + 1 > maxstep) maxstep = c.t + 1;
        if (c.t + 1 < (1 << 16)) seen[c.t + 1] = 1;
        if (c.t + 1 > 2000) {
            printf("long %lld ", c.t + 1);
            for (int a = 0; a < N; a++) { for (int b = 0; b < M; b++) if (TX[a][b] < 0) printf("---"); else printf("%d%c%c", TW[a][b], TM[a][b] > 0 ? 'R' : 'L', 'A' + TX[a][b]); printf(a < N - 1 ? "_" : " "); }
            p128("weight", wgt);
        }
    }
    if (d + 1 == NM) return;  // last row non-halting: no halt row left
    for (int w = 0; w < M; w++)
        for (int mv = 1; mv >= (d ? -1 : 1); mv -= 2)
            for (int x = 0; x <= k && x < N; x++) {
                u128 g = f * (x == k ? (u128)(N - k) : 1) * (d ? 1 : 2);
                uint8_t *B = buf[l + 1];
                memset(B + dirty_lo[l + 1], 0, dirty_hi[l + 1] - dirty_lo[l + 1] + 1);
                memcpy(B + c.lo, buf[l] + c.lo, c.hi - c.lo + 1);
                dirty_lo[l + 1] = c.lo; dirty_hi[l + 1] = c.hi;
                cfg[l + 1] = c;
                TW[q][s] = w; TM[q][s] = mv; TX[q][s] = x;
                if (run(l + 1)) node(l + 1, d + 1, x == k ? k + 1 : k, g);
                TX[q][s] = -1;
            }
}

static void p128(const char *name, u128 v) {
    char s[50]; int i = 49; s[i] = 0;
    do { s[--i] = '0' + (int)(v % 10); v /= 10; } while (v);
    printf("%s %s\n", name, s + i);
}

int main(int argc, char **argv) {
    N = atoi(argv[1]); M = atoi(argv[2]); CAP = atoll(argv[3]);
    SPLIT = argc > 4 ? atoi(argv[4]) : 99; K = argc > 5 ? atoi(argv[5]) : 1; I = argc > 6 ? atoi(argv[6]) : 0;
    setvbuf(stdout, NULL, _IOLBF, 0);
    NM = N * M; if (getenv("TRIG")) TRIG = atoll(getenv("TRIG"));
    memset(TX, -1, sizeof TX);
    for (int l = 0; l < NM + 2; l++) buf[l] = calloc(TAPE, 1);
    brent = malloc(TAPE);
    cfg[0] = (Cfg){TAPE / 2, 0, TAPE / 2, TAPE / 2, 0, 0};
    node(0, 0, 1, 1);
    p128("halters", halters); p128("stepsum", stepsum);
    for (int i = 1; i < (1 << 16); i++) if (!seen[i]) { lowmiss = i; break; }
    printf("maxstep %lld lazy %lld nodes %lld leaves %lld capped %lld cycles %lld tcs %lld overflow %lld backward %lld ngram %lld\n",
           maxstep, lowmiss, nodes, leaves, capped, cycles, tcs, overflow, bws, ngs);
    return 0;
}
