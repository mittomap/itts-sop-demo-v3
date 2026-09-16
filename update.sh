#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

BUILD_TS=$(date +"%d/%m/%Y %H:%M")
BUILD_ID=$(python3 - "$ROOT/_src/trangchu_demo.html" <<'PY'
import hashlib, pathlib, sys
p = pathlib.Path(sys.argv[1])
text = p.read_text(encoding='utf-8')
print(hashlib.sha1(text.encode('utf-8')).hexdigest()[:6])
PY
)

BUILD_TS="$BUILD_TS" BUILD_ID="$BUILD_ID" ITTS_OUT="$ROOT" python3 "$ROOT/_src/gen_v5.py"
python3 - "$ROOT/_src/trangchu_demo.html" "$ROOT/index.html" "$BUILD_TS" "$BUILD_ID" <<'PY'
import pathlib, sys
src = pathlib.Path(sys.argv[1])
dst = pathlib.Path(sys.argv[2])
ts = sys.argv[3]
bid = sys.argv[4]
text = src.read_text(encoding='utf-8').replace('__GEN_STAMP__', ts).replace('__BUILD_ID__', bid)
dst.write_text(text, encoding='utf-8')
PY

sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$ROOT/ITTs_WebApp_v5_demo.html" > "$ROOT/cong-nhan-vien/index.html"
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$ROOT/ITTs_TrangHocVien_demo.html" > "$ROOT/cong-hoc-vien/index.html"

python3 "$ROOT/_src/extract_js.py" "$ROOT"
node --check "$ROOT/_src/_APP.js"
node --check "$ROOT/_src/_HV.js"
rm -f "$ROOT/ITTs_WebApp_v5_demo.html" "$ROOT/ITTs_TrangHocVien_demo.html"

printf 'V3 build verified.\n'
printf 'Build id: '
grep -o 'id="navver"[^<]*<b>[a-f0-9]\{6\}' "$ROOT/cong-nhan-vien/index.html" | grep -o '[a-f0-9]\{6\}$' | head -1
printf 'Git changes:\n'
git status --short
