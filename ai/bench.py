"""A published benchmark score, checked against the files the submission itself released.

SWE-bench Verified is 500 tasks. A submission publishes a results file listing, per task, whether a patch
was generated and whether it resolved the issue; the leaderboard publishes one percentage. The two should
agree, and the tasks listed should be exactly the 500.

    python3 bench.py fetch DIR   saves results.json, leaderboards.json and the official id list into DIR
    python3 bench.py DIR         prints the check

Plain GETs, no key, no login.
"""
import json
import sys
import urllib.error
import urllib.request

UA = {'User-Agent': 'Noema/1.0 (+https://noema.jaybulb.com)'}
RUN = '20240402_sweagent_gpt4'
RESULTS = ('https://raw.githubusercontent.com/SWE-bench/experiments/main/evaluation/verified/'
           '%s/results/results.json' % RUN)
LISTING = 'https://api.github.com/repos/SWE-bench/experiments/contents/evaluation/verified'
ONE = ('https://raw.githubusercontent.com/SWE-bench/experiments/main/evaluation/verified/'
       '{}/results/results.json')
BOARDS = 'https://raw.githubusercontent.com/SWE-bench/swe-bench.github.io/master/data/leaderboards.json'
ROWS = ('https://datasets-server.huggingface.co/rows?dataset=princeton-nlp%2FSWE-bench_Verified'
        '&config=default&split=test&offset={}&length=100')


def get(url):
    return json.load(urllib.request.urlopen(urllib.request.Request(url, headers=UA), timeout=120))


def fetch(d):
    json.dump(get(RESULTS), open('%s/results.json' % d, 'w'))
    json.dump(get(BOARDS), open('%s/leaderboards.json' % d, 'w'))
    ids = [r['row']['instance_id'] for off in range(0, 500, 100) for r in get(ROWS.format(off))['rows']]
    json.dump(ids, open('%s/official.json' % d, 'w'))
    every = {}
    for name in (x['name'] for x in get(LISTING) if x['type'] == 'dir'):
        try:
            every[name] = get(ONE.format(name))
        except urllib.error.HTTPError as e:
            every[name] = {'error': '%s' % e}
    json.dump(every, open('%s/all.json' % d, 'w'))


def survey(every, official):
    """Sort every submission into: coverage checkable and clean, checkable and short, or not checkable."""
    clean, flagged, opaque, absent = [], {}, [], []
    for name, r in sorted(every.items()):
        if 'error' in r:
            absent.append(name)
        elif not enumerative(r):
            opaque.append(name)
        else:
            c = check(r, official)
            (flagged.setdefault(name, c) if c['repeated'] or c['missing'] or c['unknown'] else clean.append(name))
    return clean, flagged, opaque, absent


def enumerative(results):
    """True when the file lists every task, so coverage can be checked at all.

    Older submissions list each task under `generated` or `no_generation`. Newer ones carry only
    `no_generation`, `no_logs` and `resolved`, which are exception lists: a task attempted and not
    resolved appears in none of them. Those files are not wrong, they just cannot answer the question.
    """
    return 'generated' in results


def attempted(results):
    """Every task id the results file accounts for, with repeats kept."""
    return results['no_generation'] + results['generated']


def check(results, official):
    """What the results file says about coverage of the official task list."""
    seen, ids = attempted(results), set(official)
    counts = {i: seen.count(i) for i in set(seen)}
    return {
        'entries': len(seen),
        'distinct': len(set(seen)),
        'repeated': sorted(i for i, c in counts.items() if c > 1),
        'missing': sorted(ids - set(seen)),
        'unknown': sorted(set(seen) - ids),
        'resolved': len(set(results['resolved'])),
        'official': len(ids),
    }


def rates(c):
    """The score over the official count, and over what was actually attempted."""
    return c['resolved'] / c['official'] * 100, c['resolved'] / c['distinct'] * 100


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
        sys.exit()
    d = sys.argv[1]
    official = json.load(open('%s/official.json' % d))
    c = check(json.load(open('%s/results.json' % d)), official)
    print('%d entries covering %d of %d tasks' % (c['entries'], c['distinct'], c['official']))
    print('repeated:', ', '.join(c['repeated']) or 'none')
    print('never attempted:', ', '.join(c['missing']) or 'none')
    print('resolved %d: %.2f%% of the official %d, %.2f%% of the %d attempted'
          % (c['resolved'], rates(c)[0], c['official'], rates(c)[1], c['distinct']))
    try:
        every = json.load(open('%s/all.json' % d))
    except OSError:
        sys.exit()
    clean, flagged, opaque, absent = survey(every, official)
    print('\nAcross %d submissions: %d list every task, of which %d are short or repeat one; '
          '%d list only exceptions, so coverage cannot be read off them; %d have no results file'
          % (len(every), len(clean) + len(flagged), len(flagged), len(opaque), len(absent)))
    for name, c in flagged.items():
        print('  %-44s distinct %3d  repeated %d  missing %d' % (name, c['distinct'], len(c['repeated']), len(c['missing'])))
