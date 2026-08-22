#!/usr/bin/env bash
set -euo pipefail
ZIP="$HOME/Downloads/DB2_LAB02_PART2.zip"
REPO="/c/Carrera_Ciberseguridad/06_Portfolio_GitHub/DB2"
REMOTE="https://github.com/P-dot/DB2-.git"
LAB="labs/02-db2-catalog-introspection-objects-indexes-part2"

test -f "$ZIP" || { echo "ERROR: no encuentro $ZIP"; exit 1; }
mkdir -p "$REPO"
unzip -o "$ZIP" -d "$REPO"
cd "$REPO"

[ -d .git ] || git init
git branch -M main
if git remote get-url origin >/dev/null 2>&1; then git remote set-url origin "$REMOTE"; else git remote add origin "$REMOTE"; fi

echo "===== SCREENSHOTS ====="
find "$LAB/evidence/screenshots" -maxdepth 1 -type f | sort
git add .
if ! git diff --cached --quiet; then git commit -m "Close DB2 Lab 02 catalog introspection and indexes"; fi
git push -u origin main
echo "===== FINAL CHECK ====="
git status
git log -2 --oneline
