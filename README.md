# ITTs SOP Demo V3

V3 is an isolated copy of the V2 demo. The app source and the generated demo live in this repository.

## Entry points

- Employee portal: `cong-nhan-vien/`
- Student portal: `cong-hoc-vien/`
- Portal chooser: `index.html`

## Source of truth

- Generator: `_src/gen_v5.py`
- Demo data: `_src/demo_data_big.json`
- Generated data: `ITTs_data.js`
- Icon and Montserrat assets: `_src/tabler_inline.css`, `_src/montserrat_inline.css`

Do not edit the generated HTML or `ITTs_data.js` by hand. Edit `_src/`, rebuild, then verify.

## Build

```bash
./update.sh
```

The script builds into this repository, copies the two generated portals into their public folders, and runs the focused syntax/render checks. It does not read from `~/Claude`, another repository, or the V2 checkout.

The full `verify.sh` suite needs Bash 4+. The default macOS Bash 3.2 is rejected with a clear message; use a Homebrew Bash for the full suite.

V2 remains at `mittomap/itts-sop-demo-v2` and is not changed by this repository.
