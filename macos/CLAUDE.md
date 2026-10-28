# Noema for Mac

SwiftUI, macOS 14+, xcodegen. The app lists the lab's discoveries from `../discoveries.json` (bundled, and refreshed from GitHub on launch) and checks each report live: OEIS edits read in review or accepted, ClinicalTrials.gov cells read still wrong or fixed. It only reads; sending a report stays a manual step.

- Build and test: `xcodegen generate && xcodebuild -project Noema.xcodeproj -scheme Noema -derivedDataPath build test`. The xcodeproj is generated, never committed.
- Screenshot without launching: `TEST_RUNNER_SHOT=<png> TEST_RUNNER_CATALOG=$PWD/../discoveries.json TEST_RUNNER_PICK=<id>` on the same test command renders the window.
- A new discovery is a new row in `../discoveries.json`; its `level` uses the ledger's words. Checks run on launch and on Check now, never on a timer.
