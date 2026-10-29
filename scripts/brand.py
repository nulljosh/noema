"""Write the Noema brand kit: lane glyphs, the brand sheet and every architecture diagram, from one place.

    python3 scripts/brand.py

Colours and type come from brand/tokens.css; keep the two in step. Diagrams use the hub's look: a navy page,
an electric blue band dithered with an ordered (Bayer) pattern, thin caps, square boxes, blue wires.
"""
import os
from xml.sax.saxutils import escape

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BG, SURFACE, LINE, TEXT, SUB = '#000f1e', '#04192e', '#12304d', '#f2f6fa', '#9db0c4'
BLUE, BAND, ART, LINK = '#0074D9', '#0059a8', '#3d9ae8', '#7FDBFF'  # clrs.cc blue and aqua
FONT = "'Hanken Grotesk', -apple-system, 'Helvetica Neue', Helvetica, Arial, sans-serif"

# 48-unit glyphs, drawn with one stroke weight; each is one picture of what the lane studies
GLYPHS = {
    'math': '<path d="M6 30 13 12l6 14 7-18 6 22 5-6 5 14"/><circle cx="42" cy="38" r="2.5" fill="currentColor"/>',  # a Collatz path falling home
    'cs': '<rect x="5" y="28" width="12" height="12"/><rect x="18" y="28" width="12" height="12"/><rect x="31" y="28" width="12" height="12"/><path d="M24 22 18 12h12z"/>',  # a tape and its head
    'physics': '<path d="M22 13.5 9 36h30L26 13.5"/><circle cx="9" cy="36" r="4" fill="currentColor"/><circle cx="39" cy="36" r="4" fill="currentColor"/><circle cx="24" cy="10" r="4"/>',  # a frustrated triangle: two spins agree, the third cannot
    'chemistry': '<path d="M8 32 18 24l10 6 10-8M18 24V12M28 30v10M38 22l4-10"/><circle cx="18" cy="24" r="2.5" fill="currentColor"/><circle cx="28" cy="30" r="2.5" fill="currentColor"/><circle cx="38" cy="22" r="2.5" fill="currentColor"/>',  # a branched carbon tree
    'biology': '<path d="M14 4c0 10 20 10 20 20S14 34 14 44M34 4c0 10-20 10-20 20s20 10 20 20"/><path d="M17 10h14M17 38h14M21 17h6M21 31h6"/>',  # the double helix
    'medicine': '<path d="M24 6v36" stroke-dasharray="2 4"/><path d="M8 16h22M14 28h28"/><path d="M19 12l4 4-4 4-4-4zM29 24l4 4-4 4-4-4z" fill="currentColor"/>',  # a forest plot
    'statistics': '<path d="M4 40h40"/><path d="M5 39c8 0 10-30 19-30s11 30 19 30"/><path d="M24 9v31" stroke-dasharray="2 4"/>',  # the bell curve and its mean
    'astronomy': '<g transform="rotate(-20 24 24)"><ellipse cx="24" cy="24" rx="20" ry="9"/><circle cx="6" cy="24" r="3" fill="currentColor"/><circle cx="44" cy="24" r="2.5" fill="currentColor"/></g>',  # a star at one focus, a planet on the orbit
    'earth': '<path d="M4 24h10l3-13 3 24 3-17 3 11 3-5h14"/>',  # a seismogram trace
    'information': '<rect x="8" y="14" width="22" height="22"/><rect x="18" y="8" width="22" height="22"/><path d="M8 14 18 8M30 14 40 8M8 36 18 30M30 36 40 30"/><circle cx="8" cy="36" r="3" fill="currentColor"/><circle cx="40" cy="8" r="3" fill="currentColor"/>',  # two codewords at opposite corners of a cube
}


def glyph(name, x=0, y=0, size=48, color='currentColor', width=2.5):
    k = size / 48
    return ('<g transform="translate(%g %g) scale(%g)" fill="none" stroke="%s" stroke-width="%g" '
            'stroke-linecap="round" stroke-linejoin="round" color="%s">%s</g>' % (x, y, k, color, width, color, GLYPHS[name]))


def bayer_defs():
    """Eight 4x4 ordered-dither tiles, from sparse to dense, as reusable patterns."""
    order = [0, 8, 2, 10, 12, 4, 14, 6, 3, 11, 1, 9, 15, 7, 13, 5]
    out = []
    for level, keep in enumerate((1, 2, 4, 6, 8, 10, 12, 14)):
        dots = ''.join('<rect x="%d" y="%d" width="1.6" height="1.6"/>' % (i % 4 * 2, i // 4 * 2) for i in range(16) if order[i] < keep)
        out.append('<pattern id="d%d" width="8" height="8" patternUnits="userSpaceOnUse"><g fill="%s">%s</g></pattern>' % (level, ART, dots))
    return '<defs>%s</defs>' % ''.join(out)


def band(x, y, w, h):
    """A band that fades left to right in eight dithered steps."""
    s = w / 8
    return '<rect x="%g" y="%g" width="%g" height="%g" fill="%s"/>' % (x, y, w, h, BAND) + ''.join(
        '<rect x="%g" y="%g" width="%g" height="%g" fill="url(#d%d)"/>' % (x + i * s, y, s + .5, h, 7 - i) for i in range(8))


def text(x, y, s, size=15, color=TEXT, weight=400, anchor='start', caps=False, spacing=0):
    return ('<text x="%g" y="%g" font-family="%s" font-size="%g" font-weight="%d" fill="%s" text-anchor="%s"%s>%s</text>'
            % (x, y, FONT, size, weight, color, anchor,
               ' letter-spacing="%g"' % spacing if spacing else '', escape(s.upper() if caps else s)))


def diagram(path, lane, title, rows, label, lanes=False):
    W, BW, BH, G, X0 = 760, 162, 72, 24, 20
    H = 132 + len(rows) * 124 + (104 if lanes else 0)
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d" role="img" aria-label="%s">' % (W, H, escape(label)),
           bayer_defs(), '<rect width="%d" height="%d" fill="%s"/>' % (W, H, BG), band(0, 0, W, 96),
           glyph(lane, X0, 24, 48, '#ffffff', 2.5), text(X0 + 68, 64, title, 34, '#ffffff', 200, caps=True, spacing=-.5),
           text(W - X0, 64, 'Noema', 11, '#cfe6ff', 600, 'end', True, 1.5)]
    n = 0
    for r, (name, boxes) in enumerate(rows):
        y = 140 + r * 124
        out.append(text(X0, y - 14, name, 11, SUB, 600, caps=True, spacing=1.3))
        for i, b in enumerate(boxes):
            n += 1
            x = X0 + i * (BW + G)
            if i:
                out.append('<path d="M%d %dh%d" stroke="%s" stroke-width="2"/>' % (x - G, y + BH // 2, G, BLUE))
                out.append('<rect x="%d" y="%d" width="6" height="6" fill="%s"/>' % (x - 3, y + BH // 2 - 3, BLUE))
            out.append('<rect x="%d" y="%d" width="%d" height="%d" rx="2" fill="%s" stroke="%s"/>' % (x, y, BW, BH, SURFACE, LINE))
            out.append(text(x + 12, y + 18, '%02d' % n, 10, LINK, 600, spacing=1))
            lines = b.split('|')
            for j, t in enumerate(lines):
                out.append(text(x + 12, y + 42 + j * 18 - (len(lines) - 1) * 4, t, 14))
    if lanes:  # the hub diagram ends with every live lane's glyph
        y = 140 + len(rows) * 124
        out.append(text(X0, y - 14, 'The lanes', 11, SUB, 600, caps=True, spacing=1.3))
        for i, name in enumerate(GLYPHS):
            x = X0 + i * 74
            out.append(glyph(name, x, y, 36, TEXT, 2.2))
            out.append(text(x + 18, y + 54, name, 8, SUB, 600, 'middle', True, .6))
    out.append('</svg>')
    open(os.path.join(ROOT, path), 'w').write(''.join(out) + '\n')


DIAGRAMS = [
    ('architecture.svg', 'math', 'Show your work',
     [('Every lane', ['Precise claim', 'Reproduce a|published result', 'Second, independent|check', 'Ledger row with|its claim level']),
      ('Out to people', ['ledger.md', 'Lane README|and roadmap', './deploy.sh|tests every lane', 'noema.jaybulb.com'])],
     'Claim, reproduction, independent check and ledger row, then README, deploy and site, over ten lanes', True),
    ('cs/architecture.svg', 'cs', 'Busy Beaver',
     [('Deciding', ['busy.py grows|only reached rules', 'Deciders: cycles,|shifts, n-grams', 'FAR certificates|for the rest', 'Lean 4 kernel|checks each leaf']),
      ('Counting halters', ['halters.c|weighted tree walk', 'Step cap set|to the proved BB', 'Long halters|rerun alone', 'Counts, step sums,|runtime spectrum']),
      ('Placid Platypus', ['Every ones count|5 states can print', 'Add a sixth state|to a 5-state base', 'Walk and neighbour|search for the rest', 'Rerun from blank|before it counts'])],
     'Busy Beaver tree to deciders to FAR certificates to Lean, halters.c counting, and the Placid Platypus search'),
    ('medicine/architecture.svg', 'medicine', 'Trials, redone',
     [('Registry', ['ClinicalTrials.gov|API, 1 per second', 'Baseline tables,|outcome analyses', 'Checks against|themselves', 'Flags, judged|by the p-value']),
      ('Papers', ['PubMed abstracts|and PMC full text', 'Printed numbers|recomputed', 'Every flag|read by hand', 'Ledger: clear|mismatch or open'])],
     'Registry rows and papers checked against themselves, flags read by hand, then the ledger'),
    ('physics/architecture.svg', 'physics', 'Tiny magnets',
     [('Ising', ['Count one row|at a time', 'Exact counts on|wrapped grids', 'Beale and|Onsager values', 'Triangle grid|cold states']),
      ('Nuclear data', ['NUBASE2020 against|ENSDF ground states', 'Half-lives that|disagree', 'Ground and isomer|order reversed', 'One decay mode|named twice'])],
     'Exact Ising counts checked against Beale and Onsager, and NUBASE2020 read against the ENSDF ground states'),
    ('chemistry/architecture.svg', 'chemistry', 'Counting molecules',
     [('Alkanes', ['Polya cycle|index count', 'Brute-force|tree growth', 'Both agree with|OEIS A000602', 'Alkane isomer|counts'])],
     'Two independent alkane counts checked against OEIS A000602'),
    ('statistics/architecture.svg', 'statistics', 'Chance, exactly',
     [('Chance', ['Exact rational|arithmetic', 'Birthday and|coupon collector', 'Checked by|simulation', 'Exact values'])],
     'Exact arithmetic for classic probability problems, checked against closed forms'),
    ('biology/architecture.svg', 'biology', 'One base at a time',
     [('HBB', ['Annotated coding|sequence', 'Every one-base|substitution', 'Protein checked|against UniProt', 'Held-out ClinVar|benchmark'])],
     'Every single-base change in HBB, checked against UniProt, scored on a held-out ClinVar set'),
    ('astronomy/architecture.svg', 'astronomy', 'Orbits, checked',
     [('Kepler', ['NASA archive|composite table', 'Third law from|mass and period', 'Flag a miss past|a factor of two', 'Read the paper|before any claim'])],
     'Kepler third law on the NASA composite table, outliers read against their own papers'),
    ('earth/architecture.svg', 'earth', 'Ground shaking',
     [('Quakes', ['USGS catalog,|one magnitude type', 'Aki maximum|likelihood b', 'Completeness cut|quoted with it', 'b per type,|never mixed'])],
     'USGS catalog to an Aki maximum-likelihood b-value, quoted per magnitude type above a completeness cut'),
    ('information/architecture.svg', 'information', 'Best codes',
     [('A(n, d)', ['Words as a graph|at distance d', 'Exhaustive maximum|clique search', 'Distance rechecked|pair by pair', 'Exact value|and one code'])],
     'Largest binary codes by exhaustive clique search, distances rechecked pair by pair'),
]


def sheet():
    """One page that shows the whole kit: glyphs, colours, type and spacing."""
    PER, W = 7, 960
    glyph_rows = -(-len(GLYPHS) // PER)
    drop = (glyph_rows - 1) * 128  # everything under the glyph grid moves down a row at a time
    H = 584 + drop
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 %d %d" role="img" aria-label="Noema brand kit: lane glyphs, colours, type and spacing">' % (W, H),
           bayer_defs(), '<rect width="%d" height="%d" fill="%s"/>' % (W, H, BG), band(0, 0, W, 200),
           text(40, 118, 'A thought, checked', 64, '#ffffff', 100, caps=True, spacing=-2),
           text(40, 160, 'Noema brand kit', 12, '#cfe6ff', 600, caps=True, spacing=1.6)]
    out.append(text(40, 244, 'Lane glyphs', 11, SUB, 600, caps=True, spacing=1.3))
    for i, name in enumerate(GLYPHS):
        x, y = 40 + i % PER * 128, 260 + i // PER * 128
        out.append('<rect x="%d" y="%d" width="112" height="112" rx="2" fill="%s" stroke="%s"/>' % (x, y, SURFACE, LINE))
        out.append(glyph(name, x + 32, y + 16, 48, TEXT))
        out.append(text(x + 56, y + 96, name, 10, SUB, 600, 'middle', True, 1.2))
    out.append(text(40, 412 + drop, 'Colour', 11, SUB, 600, caps=True, spacing=1.3))
    for i, (c, n) in enumerate(((BG, 'page'), (SURFACE, 'surface'), (LINE, 'line'), (BLUE, 'blue'), (BAND, 'band'), (ART, 'band art'), (LINK, 'link'), (TEXT, 'text'))):
        x = 40 + i * 64
        out.append('<rect x="%d" y="%d" width="56" height="56" rx="2" fill="%s" stroke="%s"/>' % (x, 428 + drop, c, LINE))
        out.append(text(x, 502 + drop, n, 10, SUB, 600, caps=True, spacing=.8))
        out.append(text(x, 518 + drop, c, 10, SUB))
    out.append(text(560, 412 + drop, 'Type and space', 11, SUB, 600, caps=True, spacing=1.3))
    out.append(text(560, 452 + drop, 'Hanken Grotesk', 28, TEXT, 200))
    out.append(text(560, 476 + drop, 'Thin caps for display, 400 for reading, 600 caps labels.', 12, SUB))
    for i, s in enumerate((8, 12, 16, 24, 32, 48, 64)):
        out.append('<rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>' % (560 + sum((8, 12, 16, 24, 32, 48, 64)[:i]) + i * 8, 560 + drop - s, s, s, BLUE))
    out.append('</svg>')
    open(os.path.join(ROOT, 'brand/sheet.svg'), 'w').write(''.join(out) + '\n')


if __name__ == '__main__':
    os.makedirs(os.path.join(ROOT, 'brand/glyphs'), exist_ok=True)
    for name in GLYPHS:
        open(os.path.join(ROOT, 'brand/glyphs/%s.svg' % name), 'w').write(
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="48" height="48">%s</svg>\n' % glyph(name))
    for d in DIAGRAMS:
        diagram(*d)
    sheet()
