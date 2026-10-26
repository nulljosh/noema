<img src="icon.svg" width="80" alt="Evidna icon">

# Evidna

![Version](https://img.shields.io/badge/version-0.1.0-9e4f36) ![License](https://img.shields.io/badge/license-MIT-53694b) ![Tests](https://github.com/nulljosh/labs/actions/workflows/noema-biology.yml/badge.svg)

[Explore the lab](https://noema.jaybulb.com/biology/)

An open-source biology lab. Real DNA, reproducible analysis, and AI questions grounded in evidence.

Evidna means evidence + DNA. Originally conceived as `wet-lab`. Inspired by Anthropic's approach to careful AI research; independent and unaffiliated.

## Features

Analyze an annotated coding sequence with Python and Biopython. Trace a single-base substitution into a codon and amino-acid change. Inspect coding length, GC content, reference protein, and reference molecular weight.

A researcher AI proposes a testable computational hypothesis. A second, sequential skeptic pass challenges it. Both use Claude Haiku through your signed-in Claude CLI, with tools and MCP servers disabled. Predictions stay marked unvalidated.

A SQLite notebook keeps hypotheses, source-labelled observations, and revisions. Recorded observations inform the next proposal. This is evidence in model context, not model training or autonomous discovery.

## Start on your Mac

Install [uv](https://docs.astral.sh/uv/getting-started/installation/) and Git. The pinned public reference is already included, so analysis works without a model, account, or network after dependency installation.

```sh
git clone https://github.com/nulljosh/labs
cd labs/noema/biology
uv sync --locked
uv run evidna.py analyze
uv run evidna.py analyze --variant 'c.21G>A'
uv run evidna.py fetch
```

For AI reasoning, install and sign in to [Claude Code](https://code.claude.com/docs/en/setup). Each hypothesis makes two sequential Haiku calls against your account. The sequence analysis and, on revision, the parent hypothesis and its observations are sent to Claude. Do not attach private human genomic data to this public-data workflow.

```sh
uv run evidna.py hypothesize
uv run evidna.py history
# Substitute the hypothesis ID printed by the previous command.
uv run evidna.py record 1 --observation 'Describe an actual result here' --source '/absolute/path/to/result.json'
uv run evidna.py hypothesize --parent 1
```

`record` stores a user-reported observation, not an independently verified fact. Use real results, never the example placeholder. A revision requires an observation and the same sequence fingerprint and variant. Failed AI calls do not save a partial hypothesis. Local notebooks are ignored by Git. `--db /path/to/notebook.sqlite3` goes before the command.

## Your first biology lesson

DNA uses four letters: A, C, G, T. A coding sequence is read in groups of three, called codons. Each specifies an amino acid or a stop signal. A protein is a chain of amino acids.

The included [NCBI HBB transcript NM_000518.5](https://www.ncbi.nlm.nih.gov/nuccore/NM_000518.5/) contains a 444-base coding sequence, including its stop codon. It encodes 147 residues before processing. We extract the annotated CDS rather than translating the entire transcript, which also contains untranslated regions.

`c.20A>T` changes GAG to GTG: glutamate becomes valine at encoded residue 7. Traditional mature beta-globin numbering calls it residue 6 because the initiator methionine is removed. This is a known teaching example, not a discovery. `c.21G>A` changes GAG to GAA; both encode glutamate. A synonymous change does not prove that every biological effect is absent.

Sequence translation tells us what a codon encodes. It does not measure folding, oxygen binding, expression, or clinical outcomes. The mutant codon translation includes the stop symbol and is not a confirmed expressed protein.

## Data and reproducibility

`data/hbb.gb` is a real public NCBI GenBank record downloaded October 13, 2026. [Exact retrieval endpoint](https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=NM_000518.5&rettype=gb&retmode=text). Reports retain the accession and SHA-256 of the input file. Refreshing a record can change annotation and its file hash even when the accession is unchanged. Keep old inputs to reproduce old runs.

`--sequence file.gb` accepts GenBank files with exactly one annotated CDS and unambiguous A/C/G/T coding DNA that passes the standard genetic code's full-CDS translation rules. Positions are 1-based along the extracted coding strand. This first version supports single-base substitutions and the standard genetic code only. It does not infer a CDS from FASTA, predict structures, or analyze whole genomes. Start/stop changes are labelled with their limits.

## Development

```sh
uv run python -m unittest discover -s tests -v
uv run evidna.py export-demo
python3 -m http.server 8080 --directory landing --bind 127.0.0.1
../deploy.sh
```

The browser workbench uses three precomputed variants from the Python engine. Switching variants and downloading reports run in the browser; the landing page does not execute Python or AI. It makes no paid model calls. Deployment uses your Cloudflare Wrangler login and the declared custom domain. Tests cover known biology, invalid variants, start/stop changes, evidence persistence, and revision boundaries. AI calls are mocked in unit tests; generated biology still requires human review.

See [roadmap.md](roadmap.md), [WHITEPAPER.md](WHITEPAPER.md), and [SECURITY.md](SECURITY.md). Contributions welcome: include a reproducible example and a test for any changed biological calculation. Software is MIT; public source data remains subject to its provider's terms.

A [real first researcher and skeptic run](examples/hypothesis.json) is included for inspection. It is model output, not verified biology. The skeptic's criticism is part of the record, not a guarantee that every error was caught.

## First computational study

```sh
uv run evidna.py study
```

This cross-checks the translated reference against NCBI's protein annotation and a separately downloaded [UniProt P68871 sequence](https://rest.uniprot.org/uniprotkb/P68871.fasta). The bundled UniProt snapshot was downloaded October 13, 2026; reports include both input fingerprints. Agreement between databases is a source check, not independent experimental validation.

The calculation compares unprocessed chains, including initiator methionine. It uses average molecular masses and Biopython's estimated charge at pH 7. It excludes heme, tetramer formation, and post-translational modifications. See [Biopython's method documentation](https://biopython.org/docs/latest/api/Bio.SeqUtils.ProtParam.html) and [ProtParam's assumptions](https://web.expasy.org/protparam/protparam-doc.html).

For c.20A>T, calculated mass falls by 29.983 Da and estimated charge rises by 0.997190. The synonymous c.21G>A control leaves the protein sequence and both estimates unchanged. These results are consistent with the first AI proposal's arithmetic. They do not establish protein function. The complete reproducible output is in [examples/hbb-study.json](examples/hbb-study.json).

Landing typography uses self-hosted DM Sans and Newsreader under their included SIL Open Font Licenses. [Design review and remaining QA limits](design/README.md).

## Research loop and benchmarks

```sh
uv run evidna.py research --minutes 15
uv run evidna.py benchmark
```

The foreground queue cross-checks the reference, scans every single-base CDS substitution, compares protein consequences with a pinned UniProt annotation snapshot, and evaluates a versioned regression baseline. It stops early when finished and makes no AI calls. A maximum runtime from greater than zero through 60 minutes is accepted; checks happen between scan items and stages, rather than forcibly killing a running operation.

Each run saves JSON/JSONL files under ignored `runs/`, adds a summary to the local notebook, and updates the marked research section of the whitepaper. Ctrl-C saves an interrupted summary. Complete runs also update [benchmark history](benchmarks/history.jsonl). There is no timer service, daemon, cron job, or automatic Git push.

The first three scored cycles agree: 1,332 substitutions, 256 protein annotations reproduced, two outside a single-base explanation, and three complex annotations excluded. Repetition measures reproducibility, not new biological evidence. [Benchmark definitions and limits](benchmarks/README.md).

## Held-out benchmark

`uv run heldout.py` scores a rule declared in advance (`benchmarks/heldout-spec.json`) against the newest 30 percent of pinned ClinVar HBB records. Version 0 reaches 0.67 balanced accuracy on 28 held-out records, against 0.50 for both baselines. The set is small, so this is a baseline, not a finding. `uv run heldout.py fetch` refreshes the pinned data by hand; tests never use the network.
