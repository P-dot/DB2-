# Git Bash

```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/DB2 || exit 1

ZIP="$HOME/Downloads/07-db2-null-not-null-default-constraints.zip"
TMP="$HOME/Downloads/db2-lab07-tmp"
LAB="labs/07-db2-null-not-null-default-constraints"

test -f "$ZIP" || { echo "ERROR: ZIP no encontrado: $ZIP"; exit 1; }

rm -rf "$TMP"
mkdir -p "$TMP"
unzip -q "$ZIP" -d "$TMP" || exit 1

SRC="$TMP/07-db2-null-not-null-default-constraints"
test -d "$SRC" || { echo "ERROR: estructura ZIP inesperada"; exit 1; }

COUNT=$(find "$SRC/evidence/screenshots" -type f | wc -l)
echo "Evidencias en ZIP: $COUNT"
test "$COUNT" -gt 0 || { echo "ERROR: ZIP sin evidencias"; exit 1; }

echo "Posibles Lab 07 existentes:"
find labs -maxdepth 1 -type d -iname '*07*' -print

mkdir -p labs
rm -rf "$LAB"
cp -r "$SRC" "$LAB" || exit 1
rm -rf "$TMP"

find "$LAB" -type f | sort

echo "===== SECURITY CHECK ====="
grep -RInE '192\.168\.[0-9]{1,3}\.[0-9]{1,3}|10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' "$LAB" || echo "OK - no private IP/MAC patterns found"

git status --short
git add "$LAB"
git status
git commit -m "Add Lab 07 Db2 NULL NOT NULL and default constraints"
git push origin main

git status
git log -3 --oneline
git ls-remote origin refs/heads/main
git ls-files "$LAB/evidence/screenshots" | wc -l
```
