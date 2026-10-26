#!/bin/sh
set -eu
cd "$(dirname "$0")"
uv run python -m unittest discover -s tests
uv run evidna.py export-demo >/dev/null
npx --yes wrangler deploy
