# Noema

One lab for all of STEM. Live lanes: `math/`, `cs/`, `physics/`, `chemistry/`, `medicine/`, `statistics/`, `biology/`, `astronomy/`, `earth/`, `information/`, `ai/`. New fields are listed in `roadmap.md` under Fields and get a folder only when a tick starts their first study. Each has its own short CLAUDE.md; read the side you touch.

- Claim levels, never blurred: observed, written, machine-checked, literature.
- `./deploy.sh` tests every lane, builds `dist/` (hub, `/math`, `/biology`) and deploys with wrangler. CI is `noema-<lane>.yml` at the labs root.
- `macos/` is the Mac app over `discoveries.json` (see `macos/CLAUDE.md`); add a row there when a result is new or reported.
- Commit and push only `noema/` paths; other sessions share this repo. No daemons, no automatic model calls.

## The loop

The live `/loop` is documented in `docs/LOOP-HANDOFF.md`: what it is, where things stand, what is next, and the restart prompt. Every tick follows its protocol and discovery gate and logs a row in `ledger.md`.
