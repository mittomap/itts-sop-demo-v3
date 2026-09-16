# V3 project protocol

This repository is the isolated V3 demo. V2 is a separate repository and must not be changed by V3 work.

## Source of truth

- `_src/gen_v5.py` is the only source for the employee portal, student portal, and generated data artifact.
- `_src/demo_data_big.json` is the current demo-data input. Update it through the data pipeline, not by hand.
- `_src/trangchu_demo.html` is the source for the portal chooser.
- Generated files are `index.html`, `cong-nhan-vien/index.html`, `cong-hoc-vien/index.html`, and `ITTs_data.js`.

## Workflow

1. Read `00_DOC_TRUOC_TIEN.md`, `01_KIEN_TRUC_HE_THONG.md`, and `02_NHAT_KY_QUYET_DINH.md` before changing behavior.
2. Edit `_src/`, then run `./update.sh` from this repository.
3. Run the focused checks and the full `verify.sh` when available before delivery.
4. Keep V2 untouched. Do not read build input from another checkout.
5. Do not add Google Apps Script or retired HTML builds to V3 unless explicitly requested.

## Data pipeline

`gen_demo.py -> seed_giaoan.py -> mkdemo.py -> fixdata.py -> seed_giaoviec.py -> check_data.py -> check_logic.py -> gen_v5.py`

Business constants remain configuration-driven, enum labels follow the project data, and generated HTML/data must not be edited manually.

## Delivery

Commit V3 changes in this repository only. Configure the V3 remote explicitly before pushing; never push V3 changes to the V2 remote.
