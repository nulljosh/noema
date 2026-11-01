// Hero wall: Noema's own ledger. Each card is one result from discoveries.json (the file the Mac app reads):
// its field, claim level and claim, then its check reruns and passes. Live from GitHub, this snapshot until it lands.
(function () {
  var wall = document.getElementById('nwall'); if (!wall) return;
  var still = matchMedia('(prefers-reduced-motion: reduce)').matches;
  var n = innerWidth <= 560 ? 4 : innerWidth <= 900 ? 6 : 9;
  var ROWS = [["cs", "candidate", "Placid Platypus known to n = 181", "The fewest states a Turing machine needs to print exactly n ones and stop. OEIS knew it for n up to 37; every n up to 181 is now settled, each with a machine that reruns from a blank tape."], ["cs", "candidate", "Total running time of every 5-state halter", "Add up how long every halting 5-state Turing machine runs: 64,068,865,333,248 steps. Two programs that share no code agree."], ["cs", "candidate", "Circular-tape machines extended to 27 terms", "A count of 2-state machines on a loop of tape, which OEIS had to 19 terms, pushed to 27."], ["cs", "candidate", "How many different running times halters have", "Machines with 1 to 5 states stop after 1, 6, 21, 79 and 1,207 distinct step counts. Not in OEIS; a draft waits for a free slot."], ["medicine", "observed", "Standard errors labelled as standard deviations", "292 trial results on ClinicalTrials.gov say SD but are as narrow as a standard error, which makes the treatment look surer than it is. In 15 trials the paper confirms it. Reported to the NLM help desk."], ["medicine", "observed", "Confidence limits missing a minus sign", "61 intervals in 52 trials cross zero while their own p-value says they cannot. In two the paper prints the right sign. Reported to the NLM help desk."], ["medicine", "observed", "Trial counts that break their own totals", "Across all 80,750 trials with results: 274 outcome counts bigger than the group analysed, 28 serious adverse event totals bigger than their parts, 11 dropout tallies that do not add up. Not reported yet."], ["astronomy", "observed", "One star, four densities", "A 2019 paper on K2-285 fits four planets on circular orbits around one star, yet the outer three imply the star is 2 to 6 times denser than the paper says. Of 387 papers with two or more such planets in NASA's archive, this split is the widest, at 29.6 sigma."], ["astronomy", "observed", "A paper whose orbits run long", "Oddo et al. 2023 fit ten small planets. Eight of the orbit sizes sit past Kepler's law from the paper's own numbers, three by more than 4 sigma, and one looks like a typo."], ["astronomy", "observed", "Minimum masses above true masses", "A planet's minimum mass can never beat its real mass, but 99 of 440 rows in NASA's combined table do, because they pair numbers from different papers."], ["astronomy", "observed", "Three stars fit lighter than their own tables", "Hedges et al. 2019 fit seven planets around three stars. Each system shares one star density, but it comes out 1.75 to 6.3 times lower than the star sizes and masses the same table quotes, and two planets miss the earlier papers it says it matches."]];
  var LANE = { cs: 'Computer science', medicine: 'Medicine', astronomy: 'Astronomy', math: 'Mathematics', physics: 'Physics', chemistry: 'Chemistry', biology: 'Biology', statistics: 'Statistics', earth: 'Earth', information: 'Information' };
  var el = function (t, c, x) { var e = document.createElement(t); if (c) e.className = c; if (x != null) e.textContent = x; return e; };
  var wait = function (ms) { return new Promise(function (r) { setTimeout(r, still ? 0 : ms); }); };
  var cards = [];
  function build(rows) {
    wall.textContent = ''; cards.forEach(function (c) { c.dead = true; }); cards = [];
    var m = Math.min(n, rows.length);
    for (var i = 0; i < m; i++) (function (i) {
      var a = wall.appendChild(el('article', 'nc')), me = { dead: false }, k = i; cards.push(me);
      function play() {
        if (me.dead) return Promise.resolve();
        var r = rows[k % rows.length]; k += m;
        a.textContent = '';
        var hd = a.appendChild(el('div', 'nc-hd')); hd.appendChild(el('span', '', LANE[r[0]] || r[0])); hd.appendChild(el('i', 'lv', r[1]));
        a.appendChild(el('b', '', r[2])); a.appendChild(el('p', '', r[3]));
        var ck = a.appendChild(el('div', 'nc-ck')), bar = ck.appendChild(el('span', 'nc-bar')).appendChild(el('i')), st = ck.appendChild(el('em', '', 'Rerunning check'));
        if (still) { bar.style.width = '100%'; st.textContent = 'Check passed'; ck.classList.add('ok'); return Promise.resolve(); }
        return wait(600).then(function () { bar.style.width = '100%'; return wait(1700); })
          .then(function () { st.textContent = 'Check passed'; ck.classList.add('ok'); return wait(4200); });
      }
      if (still) play(); else wait(i * 260).then(function loop() { return me.dead ? null : play().then(loop); });
    })(i);
  }
  build(ROWS);
  fetch('https://raw.githubusercontent.com/nulljosh/noema/main/discoveries.json').then(function (r) { return r.ok ? r.json() : null; }).then(function (d) {
    var rows = d && (d.discoveries || []).map(function (x) { return [x.lane, x.level, x.title, x.plain]; });
    if (rows && rows.length && JSON.stringify(rows) !== JSON.stringify(ROWS)) build(rows);
  }).catch(function () {});
})();

// Hero parallax: the wall drifts at 0.45, the copy lifts at 0.2 and fades. Off under reduced motion.
(function () {
  var bg = document.querySelector('.hero-bg'), copy = document.querySelector('.hero-copy');
  if (!bg || matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  var t = 0;
  addEventListener('scroll', function () {
    if (t) return;
    t = requestAnimationFrame(function () {
      t = 0; var y = scrollY, h = innerHeight; if (y > h * 1.2) return;
      bg.style.setProperty('--py', (y * .45) + 'px');
      copy.style.transform = 'translate3d(0,' + (y * .2) + 'px,0)'; copy.style.opacity = Math.max(0, 1 - y / (h * .7));
    });
  }, { passive: true });
})();
