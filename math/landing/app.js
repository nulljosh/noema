'use strict';
const $ = id => document.getElementById(id);
const fmt = n => n.toLocaleString('en-US');
function orbit(start) {
  if (!Number.isInteger(start) || start < 1 || start > 10000) throw new Error('Use a whole number from 1 through 10,000.');
  const values = [start];
  while (values.at(-1) !== 1 && values.length <= 1000) {
    const n = values.at(-1);
    values.push(n % 2 ? 3 * n + 1 : n / 2);
  }
  return values;
}
function chart(id, values) {
  const svg = $(id), hero = id === 'hero-chart';
  const width = hero ? 600 : 680, height = hero ? 340 : 260;
  const left = 42, right = width - 12, top = 30, bottom = height - 32;
  const peak = Math.max(...values), maxLog = Math.max(1, Math.log10(peak));
  const x = i => left + i / Math.max(1, values.length - 1) * (right - left);
  const y = n => bottom - Math.log10(n) / maxLog * (bottom - top);
  const rows = [1, 10, 100, 1000, 10000].filter(n => n <= Math.max(10, peak));
  svg.innerHTML = rows.map(n => `<line x1="${left}" x2="${right}" y1="${y(n)}" y2="${y(n)}" stroke="${hero ? '#DDDDDD' : '#DDDDDD'}"/><text x="${left-9}" y="${y(n)+3}" text-anchor="end" fill="#001F3F" font-size="9">${fmt(n)}</text>`).join('')
    + `<path d="${values.map((n,i) => `${i ? 'L' : 'M'}${x(i).toFixed(2)},${y(n).toFixed(2)}`).join(' ')}" fill="none" stroke="#0074D9" stroke-width="${hero ? 2 : 2.3}" stroke-linejoin="round" stroke-linecap="round"/>`
    + `<circle cx="${x(values.length-1)}" cy="${y(values.at(-1))}" r="4" fill="#0074D9"/><text x="${left}" y="${height-8}" fill="#001F3F" font-size="9">STEP 0</text><text x="${right}" y="${height-8}" text-anchor="end" fill="#001F3F" font-size="9">STEP ${values.length-1}</text>`;
  svg.setAttribute('aria-label', `Collatz trajectory from ${values[0]}, ${values.length-1} steps, peak ${peak}, logarithmic scale`);
}
function showOrbit() {
  const input = $('collatz-start');
  if (!input.checkValidity()) { input.reportValidity(); return; }
  const values = orbit(Number(input.value)), reached = values.at(-1) === 1;
  chart('orbit-chart', values);
  $('orbit-steps').textContent = fmt(values.length - 1);
  $('orbit-steps').nextElementSibling.textContent = reached ? 'steps to reach 1' : 'steps before cap';
  $('orbit-peak').textContent = fmt(Math.max(...values));
  $('orbit-end').textContent = fmt(values.at(-1));
  $('orbit-status').textContent = reached ? 'REACHED 1' : 'UNRESOLVED AT CAP';
  $('orbit-sequence').textContent = values.slice(0, 12).map(fmt).join(' → ') + (values.length > 12 ? ' → … → ' + fmt(values.at(-1)) : '');
}
function prime(n) {
  if (!Number.isInteger(n) || n < 2) return false;
  for (let d = 2; d*d <= n; d++) if (n % d === 0) return false;
  return true;
}
function goldbach(n) {
  if (!Number.isInteger(n) || n < 4 || n > 10000 || n % 2) throw new Error('Use an even number from 4 through 10,000.');
  const pairs = [];
  for (let p = 2; p <= n / 2; p++) if (prime(p) && prime(n-p)) pairs.push([p,n-p]);
  return pairs;
}
function showGoldbach() {
  const input = $('goldbach-number');
  if (!input.checkValidity()) { input.reportValidity(); return; }
  const n = Number(input.value), pairs = goldbach(n);
  $('goldbach-equation').innerHTML = `${fmt(n)} <span>=</span> ${fmt(pairs[0][0])} <span>+</span> ${fmt(pairs[0][1])}`;
  $('goldbach-count').textContent = `${pairs.length} prime ${pairs.length === 1 ? 'pair' : 'pairs'} found. Each pair is independently checkable by division.`;
  $('goldbach-pairs').replaceChildren(...pairs.map(pair => {
    const span = document.createElement('span'); span.textContent = pair.map(fmt).join(' + '); return span;
  }));
}
function clauses(x,y) { return [x||y,x||!y,!x||y,!x||!y]; }
function showSat() {
  const x = $('sat-x').checked, y = $('sat-y').checked;
  const names = ['x or y','x or not y','not x or y','not x or not y'];
  $('sat-clauses').innerHTML = clauses(x,y).map((value,i) => `<div class="clause ${value ? '' : 'false'}">${names[i]}<span>${value ? 'TRUE' : 'FALSE'}</span></div>`).join('');
  $('sat-table').innerHTML = [false,true].flatMap(a => [false,true].map(b => `<tr class="${a===x&&b===y?'active':''}"><td>${a?'True':'False'}</td><td>${b?'True':'False'}</td><td>${clauses(a,b).filter(Boolean).length} / 4</td><td>No</td></tr>`)).join('');
}
function selectTab(name, focus = false) {
  document.querySelectorAll('[role=tab]').forEach(tab => {
    const selected = tab.dataset.tab === name;
    tab.setAttribute('aria-selected', String(selected)); tab.tabIndex = selected ? 0 : -1;
    $('panel-'+tab.dataset.tab).hidden = !selected;
    if (selected && focus) tab.focus();
  });
}
document.querySelectorAll('[role=tab]').forEach((tab,i,tabs) => {
  tab.addEventListener('click', () => selectTab(tab.dataset.tab));
  tab.addEventListener('keydown', event => {
    let index;
    if (event.key === 'ArrowRight') index = (i+1)%tabs.length;
    if (event.key === 'ArrowLeft') index = (i+tabs.length-1)%tabs.length;
    if (event.key === 'Home') index = 0;
    if (event.key === 'End') index = tabs.length-1;
    if (index !== undefined) { event.preventDefault(); selectTab(tabs[index].dataset.tab,true); }
  });
});
$('collatz-form').addEventListener('submit', e => { e.preventDefault(); showOrbit(); });
$('goldbach-form').addEventListener('submit', e => { e.preventDefault(); showGoldbach(); });
document.querySelectorAll('[data-start]').forEach(b => b.addEventListener('click', () => { $('collatz-start').value = b.dataset.start; showOrbit(); }));
$('sat-x').addEventListener('change',showSat); $('sat-y').addEventListener('change',showSat);
$('try-record').addEventListener('click', () => { selectTab('collatz'); $('collatz-start').value=6171; showOrbit(); });
chart('hero-chart',orbit(27)); showOrbit(); showGoldbach(); showSat();
Promise.all(['results.json','ladder.json'].map(path => fetch(path).then(r => { if(!r.ok) throw new Error('Research data unavailable'); return r.json(); }))).then(([sat,ladder]) => {
  if (sat.status !== 'complete' || !sat.regression_passed || ladder.status !== 'complete') throw new Error('Research record is not accepted');
  const stage = ladder.stages.at(-1);
  $('stat-sat').textContent=fmt(sat.metrics.formulas);
  $('stat-goldbach').textContent=fmt(stage.goldbach.even_cases);
  $('stat-collatz').textContent=fmt(stage.collatz.starts);
  $('data-status').textContent=`Python records loaded · SAT ${sat.suite} · Number theory ${ladder.suite} · Last run ${new Date(ladder.updated_at).toLocaleDateString('en-US',{year:'numeric',month:'short',day:'numeric',timeZone:'UTC'})} (UTC)`;
}).catch(() => { $('data-status').textContent='Live reports could not be loaded. Figures above are the initial recorded results; downloads may be unavailable.'; });
