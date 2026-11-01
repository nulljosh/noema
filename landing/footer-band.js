// Footer band: Noema's own things in a row (a check, the integral, an atom, the helix, an orbit, the sum), cut like a line engraving in plain 2D canvas. Faint rules
// run across the band; inside the glyphs they thicken, and thicken again on the edge facing away from the light, so the
// glyphs look cut into the page. Drawn once per size and theme. Same engine as the Hermes landing; only the glyphs differ.
(function () {
  var band = document.querySelector('.word-band'), canvas = band && band.querySelector('canvas');
  if (!canvas) return;

  // Each glyph is drawn white on a 100 unit square.
  var GLYPHS = [
    function (c) { // checked
      c.lineWidth = 7; c.beginPath(); c.roundRect(16, 16, 68, 68, 8); c.stroke();
      c.lineWidth = 10; c.lineCap = 'round'; c.lineJoin = 'round'; c.beginPath(); c.moveTo(30, 52); c.lineTo(45, 66); c.lineTo(72, 34); c.stroke();
    },
    function (c) { // the integral
      c.lineWidth = 8; c.lineCap = 'round'; c.beginPath(); c.moveTo(66, 18); c.bezierCurveTo(54, 6, 48, 22, 50, 50); c.bezierCurveTo(52, 78, 46, 94, 34, 82); c.stroke();
    },
    function (c) { // an atom
      c.lineWidth = 4; for (var a = 0; a < 3; a++) { c.beginPath(); c.ellipse(50, 50, 38, 14, a * Math.PI / 3, 0, 7); c.stroke(); }
      c.beginPath(); c.arc(50, 50, 7, 0, 7); c.fill();
    },
    function (c) { // the double helix
      c.lineWidth = 5; c.beginPath(); for (var y = 10; y <= 90; y += 2) c.lineTo(50 + Math.sin(y / 10) * 24, y); c.stroke();
      c.beginPath(); for (y = 10; y <= 90; y += 2) c.lineTo(50 - Math.sin(y / 10) * 24, y); c.stroke();
      c.lineWidth = 3; for (y = 16; y <= 86; y += 10) { c.beginPath(); c.moveTo(50 + Math.sin(y / 10) * 24, y); c.lineTo(50 - Math.sin(y / 10) * 24, y); c.stroke(); }
    },
    function (c) { // a planet and its orbit
      c.lineWidth = 4; c.beginPath(); c.ellipse(50, 50, 40, 16, -0.3, 0, 7); c.stroke(); c.beginPath(); c.arc(50, 50, 18, 0, 7); c.fill();
      c.beginPath(); c.arc(84, 38, 6, 0, 7); c.fill();
    },
    function (c) { // the sum
      c.beginPath(); c.moveTo(22, 14); c.lineTo(78, 14); c.lineTo(78, 26); c.lineTo(42, 26); c.lineTo(62, 50); c.lineTo(42, 74); c.lineTo(78, 74); c.lineTo(78, 86); c.lineTo(22, 86); c.lineTo(22, 80); c.lineTo(46, 50); c.lineTo(22, 20); c.closePath(); c.fill();
    }
  ];
  // Lays the glyphs out evenly across a w by h 2D context, in the given colour: one row, or two on a narrow band.
  function grid(w, h) {
    var n = GLYPHS.length, rows = w < h * 3 ? 2 : 1, per = Math.ceil(n / rows);
    return { rows: rows, per: per, cell: Math.min(h / rows * 0.86, w / per) };
  }
  function paint(c, w, h, colour) {
    var g = grid(w, h), gap = (w - g.cell * g.per) / g.per, rowH = h / g.rows;
    GLYPHS.forEach(function (draw, i) {
      var col = i % g.per, row = Math.floor(i / g.per);
      c.save(); c.translate(gap / 2 + col * (g.cell + gap), row * rowH + (rowH - g.cell) / 2 + rowH * 0.04); c.scale(g.cell / 100, g.cell / 100);
      c.fillStyle = c.strokeStyle = colour; draw(c); c.restore();
    });
  }

  var ctx = canvas.getContext('2d');
  if (!ctx) return;
  function layer(w, h) { var c = document.createElement('canvas'); c.width = w; c.height = h; return c; }
  // Horizontal rules `t` px thick, one every `pitch` px, kept only where `mask` is drawn (everywhere when null).
  function rules(w, h, pitch, t, colour, mask) {
    var c = layer(w, h), x = c.getContext('2d');
    x.fillStyle = colour;
    for (var y = 0; y < h; y += pitch) x.fillRect(0, Math.round(y + (pitch - t) / 2), w, Math.max(1, Math.round(t)));
    if (mask) { x.globalCompositeOperation = 'destination-in'; x.drawImage(mask, 0, 0); }
    return c;
  }
  var drawnW = 0;
  function draw() {
    var dpr = Math.min(window.devicePixelRatio || 1, 2), w = Math.round(canvas.clientWidth * dpr), h = Math.round(canvas.clientHeight * dpr);
    if (!w || !h) return;
    drawnW = w; canvas.width = w; canvas.height = h;
    var colour = getComputedStyle(band).color, pitch = Math.min(5 * dpr, Math.max(3 * dpr, grid(w, h).cell / 22)), s = Math.max(2, h * 0.014);
    var glyphs = layer(w, h); paint(glyphs.getContext('2d'), w, h, '#fff');
    // the shadow side: glyph pixels whose neighbour down and right is outside the glyph (light from the top left)
    var shade = layer(w, h), sc = shade.getContext('2d');
    sc.drawImage(glyphs, 0, 0); sc.globalCompositeOperation = 'destination-out'; sc.drawImage(glyphs, -s, -s);
    ctx.globalAlpha = 0.28; ctx.drawImage(rules(w, h, pitch, dpr * 0.75, colour, null), 0, 0);
    ctx.globalAlpha = 1; ctx.drawImage(rules(w, h, pitch, pitch * 0.32, colour, glyphs), 0, 0);
    ctx.drawImage(rules(w, h, pitch, pitch * 0.6, colour, shade), 0, 0);
    // fade out toward the legal line
    var g = ctx.createLinearGradient(0, h * 0.88, 0, h);
    g.addColorStop(0, '#000'); g.addColorStop(1, 'rgba(0,0,0,0)');
    ctx.globalCompositeOperation = 'destination-in'; ctx.fillStyle = g; ctx.fillRect(0, 0, w, h);
    ctx.globalCompositeOperation = 'source-over';
  }
  band.classList.add('live');
  draw();
  // iOS fires resize as the toolbar slides; only a width change needs a redraw
  window.addEventListener('resize', function () { if (Math.round(canvas.clientWidth * Math.min(window.devicePixelRatio || 1, 2)) !== drawnW) draw(); });
  matchMedia('(prefers-color-scheme: dark)').addEventListener('change', draw);
})();
