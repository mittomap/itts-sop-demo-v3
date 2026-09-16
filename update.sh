#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

ITTS_OUT="$ROOT" python3 "$ROOT/_src/gen_v5.py"
cp "$ROOT/_src/trangchu_demo.html" "$ROOT/index.html"
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
