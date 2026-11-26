// One small chart per field on the landing, drawn from numbers the lane's own ledger rows state. The caption under
// each chart (in index.html) says which. Placeholders: <div class="viz" data-viz="key">.
(function () {
  var W = 240, H = 48, B = 'var(--blue)', L = 'var(--link)', G = 'var(--line)';
  var r = function (x, y, w, h, c) { return '<rect x="' + x.toFixed(1) + '" y="' + y.toFixed(1) + '" width="' + Math.max(w, 1).toFixed(1) + '" height="' + Math.max(h, 1).toFixed(1) + '" rx="1.5" fill="' + (c || B) + '"/>'; };
  var t = function (x, y, s, a, c, z) { return '<text x="' + x.toFixed(1) + '" y="' + y.toFixed(1) + '" text-anchor="' + (a || 'middle') + '" fill="' + (c || 'var(--sub)') + '" font-size="' + (z || 10) + '" font-family="inherit">' + s + '</text>'; };
  var poly = function (p, c) { return '<polyline points="' + p.map(function (q) { return q[0].toFixed(1) + ',' + q[1].toFixed(1); }).join(' ') + '" fill="none" stroke="' + c + '" stroke-width="2"/>'; };
  function bars(v, o) {
    o = o || {}; var n = v.length, gap = n < 9 ? 6 : 4, w = (W - gap * (n - 1)) / n, f = o.log ? Math.log10 : function (x) { return x; }, mx = f(Math.max.apply(0, v)), s = '';
    v.forEach(function (x, i) { var h = f(x) > 0 ? f(x) / mx * (H - 14) : 1.5, X = i * (w + gap), Y = H - 2 - h; s += r(X, Y, w, h, o.hi === i ? L : B) + (o.labels === false ? '' : t(X + w / 2, Y - 2, x.toLocaleString('en-US'))); });
    return s;
  }
  function hbars(rows, max) { return rows.map(function (q, i) { var y = 3 + i * 15, w = q[1] / max * (W - 34); return r(0, y, w, 10, q[2]) + t(w + 4, y + 8.5, q[0], 'start'); }).join(''); }
  var Lx = function (l) { return 8 + (l - 2) / 8 * (W - 16); };
  var chart = {
    // Collatz residue tree: 24 levels, each matching OEIS A076227
    collatz: function () { var s = ''; for (var i = 0; i < 24; i++) s += r(i * 10, 17, 8, 14); return s; },
    // distinct halting times of 1..5-state machines (A402754)
    cs: function () { return bars([1, 6, 21, 79, 1207], { log: true }); },
    // Ising heat-capacity peak, L = 2..10, toward Onsager's 2.269
    physics: function () { var T = [2.511, 2.439, 2.390, 2.362, 2.345], y = function (v) { return H - 8 - (v - 2.269) / (2.511 - 2.269) * (H - 18); };
      return '<line x1="0" x2="' + W + '" y1="' + y(2.269) + '" y2="' + y(2.269) + '" stroke="' + L + '" stroke-dasharray="3 3"/>' + poly(T.map(function (v, i) { return [Lx(2 + 2 * i), y(v)]; }), B) + T.map(function (v, i) { return '<circle cx="' + Lx(2 + 2 * i).toFixed(1) + '" cy="' + y(v).toFixed(1) + '" r="2.5" fill="' + B + '"/>'; }).join(''); },
    // alkane isomer counts C1..C10 (OEIS A000602)
    chemistry: function () { return bars([1, 1, 1, 2, 3, 5, 9, 18, 35, 75], { labels: false, hi: 9 }); },
    // medicine: impossible SDs, lost minus signs, standard errors filed as SDs
    medicine: function () { return hbars([['407', 407], ['61', 61], ['292', 292]], 407); },
    // birthday problem, exact
    statistics: function () { var p = [], q = 1, i; for (i = 1; i <= 60; i++) { q *= (365 - (i - 1)) / 365; p.push([8 + (i - 1) / 59 * (W - 16), H - 6 - (1 - q) * (H - 12)]); }
      return '<line x1="0" x2="' + W + '" y1="' + (H - 6 - .5 * (H - 12)) + '" y2="' + (H - 6 - .5 * (H - 12)) + '" stroke="' + G + '"/>' + poly(p, B) + '<circle cx="' + p[22][0].toFixed(1) + '" cy="' + p[22][1].toFixed(1) + '" r="3.2" fill="' + L + '"/>'; },
    // held-out ClinVar balanced accuracy: rule 0.67, both baselines 0.50
    biology: function () { var w = W - 40; return r(0, 6, w, 14) + t(w + 4, 17, '0.67', 'start') + r(0, 26, .5 / .67 * w, 14, G) + t(.5 / .67 * w + 4, 37, '0.50', 'start'); },
    // 5,609 planets, one square per 56; 55 miss Kepler's third law by more than 2x
    astronomy: function () { var s = ''; for (var i = 0; i < 100; i++) s += r(i % 20 * 12, Math.floor(i / 20) * 9.6, 9, 7, i === 99 ? L : G); return s; },
    // Gutenberg-Richter fit on 45,844 USGS events, b = 1.03, M4.5 to 7.5
    earth: function () { var p = [], m, top = Math.log10(45844), lo = top - 1.03 * 3; for (m = 4.5; m <= 7.501; m += .1) p.push([8 + (m - 4.5) / 3 * (W - 16), 4 + (1.03 * (m - 4.5)) / (top - lo) * (H - 10)]); return poly(p, B); },
    // largest binary codes A(n,3), n = 3..8
    information: function () { return bars([2, 2, 4, 8, 16, 20], { hi: 5 }); },
    // SWE-bench Verified: 182 submissions, 13 list every task, 6 of those miss the 500
    ai: function () { return r(0, 3, W, 10, G) + t(0, 10, '182', 'start', 'var(--text)', 9) + r(0, 18, 13 / 182 * W, 10) + t(13 / 182 * W + 4, 26, '13', 'start') + r(0, 33, 6 / 182 * W, 10, L) + t(6 / 182 * W + 4, 41, '6', 'start'); }
  };
  document.querySelectorAll('[data-viz]').forEach(function (e) {
    var f = chart[e.getAttribute('data-viz')]; if (!f) return;
    e.innerHTML = '<svg viewBox="0 0 ' + W + ' ' + H + '" preserveAspectRatio="xMinYMid meet" aria-hidden="true" focusable="false">' + f() + '</svg>';
  });
})();
