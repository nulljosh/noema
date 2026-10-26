# Noema

One lab for all of STEM. Live lanes: `math/`, `cs/`, `physics/`, `chemistry/`, `biology/`. New fields are listed in `roadmap.md` under Fields and get a folder only when a tick starts their first study. Each has its own short CLAUDE.md; read the side you touch.

- Every loop tick follows the protocol and discovery gate in `docs/LOOP-HANDOFF.md`, and logs a row in the ledger in `roadmap.md`.
- Claim levels, never blurred: observed, written, machine-checked, literature.
- `./deploy.sh` tests both sides, builds `dist/` (hub, `/math`, `/biology`) and deploys with wrangler. CI is `noema-<lane>.yml` at the labs root.
- Commit and push only `noema/` paths; other sessions share this repo. No daemons, no automatic model calls.
