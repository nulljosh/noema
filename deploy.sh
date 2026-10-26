#!/bin/sh
# Test both labs, rebuild the shared site into dist/, deploy. Git pushes do not deploy.
set -eu
cd "$(dirname "$0")"
(cd math && python3 -m unittest discover -s tests)
(cd biology && uv run python -m unittest discover -s tests && uv run evidna.py export-demo >/dev/null)
rm -rf dist && mkdir -p dist/math dist/biology
cp -R landing/. dist/ && cp -R math/landing/. dist/math/ && cp -R biology/landing/. dist/biology/
env -u CLOUDFLARE_API_TOKEN npx --yes wrangler deploy
