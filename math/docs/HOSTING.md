# Hosting

Noema math is served from the merged site at https://noema.jaybulb.com/math/. The root `../deploy.sh` tests both labs, assembles `dist/` (hub, `/math`, `/biology`) and runs `wrangler deploy`. Git pushes alone do not deploy.

The earlier Sites-plugin deployment (`.openai/hosting.json`, a DNS-only `noema` CNAME in the jaybulb.com zone with TXT ownership records) is superseded. Before the first wrangler deploy, remove that CNAME so the custom domain can attach. Never save tokens in this repository.
