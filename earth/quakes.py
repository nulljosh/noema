"""Gutenberg-Richter on the USGS earthquake catalog: the b-value, and catalog rows that contradict themselves.

    python3 quakes.py fetch DIR 2020 2025    # global M4.5+ events, one CSV per year, from the USGS FDSN service
    python3 quakes.py DIR                    # b-value by Aki's maximum-likelihood estimate, with its error

The number of earthquakes of magnitude at least M falls as 10^(a - bM), with b close to 1 for global seismicity.
Aki (1965): b = log10(e) / (mean M - (Mc - dM/2)) over events at or above the completeness magnitude Mc, binned
at dM, with standard error b / sqrt(n). Shi and Bolt (1982) give the error used here, which also counts the spread.
"""
import csv
import glob
import math
import os
import sys
import urllib.request

API = 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&minmagnitude=4.5&orderby=time-asc'


def fetch(out, first, last):
    for y in range(first, last + 1):
        url = '%s&starttime=%d-01-01&endtime=%d-01-01' % (API, y, y + 1)
        with urllib.request.urlopen(url, timeout=300) as r:
            open(os.path.join(out, 'q%d.csv' % y), 'wb').write(r.read())


def b_value(mags, mc, dm=0.1):
    """Aki's estimate and the Shi-Bolt standard error, over magnitudes at or above mc."""
    m = [x for x in mags if x >= mc - 1e-9]
    n, mean = len(m), sum(m) / len(m)
    b = math.log10(math.e) / (mean - (mc - dm / 2))
    se = 2.3 * b * b * math.sqrt(sum((x - mean) ** 2 for x in m) / (n * (n - 1)))
    return n, b, se


def load(d):
    rows = []
    for f in sorted(glob.glob(os.path.join(d, 'q*.csv'))):
        rows += [r for r in csv.DictReader(open(f)) if r['type'] == 'earthquake' and r['mag']]
    return rows


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2], int(sys.argv[3]), int(sys.argv[4]))
    else:
        rows = load(sys.argv[1])
        for kind in ('mww', 'mb'):  # moment magnitude is the one b ~ 1 is quoted for; mb saturates and hands off
            mags = [round(float(r['mag']), 1) for r in rows if r['magType'] == kind]
            for mc in (5.5, 6.0):
                n, b, se = b_value(mags, mc)
                print('%s Mc %.1f: n %d, b %.3f +- %.3f' % (kind, mc, n, b, se))
