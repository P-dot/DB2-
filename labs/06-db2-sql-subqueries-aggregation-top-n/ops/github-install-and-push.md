# Instalación y publicación

El ZIP debe estar en Descargas. La instalación reemplaza únicamente el directorio exacto de Lab 06 para evitar duplicados.

```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/DB2 || exit 1

ZIP="$HOME/Downloads/06-db2-sql-subqueries-aggregation-top-n.zip"
TMP="$HOME/Downloads/db2-lab06-tmp"
LAB="labs/06-db2-sql-subqueries-aggregation-top-n"

test -f "$ZIP" || { echo "ERROR: ZIP no encontrado: $ZIP"; exit 1; }

rm -rf "$TMP"
mkdir -p "$TMP"
unzip -q "$ZIP" -d "$TMP" || exit 1

SRC="$TMP/06-db2-sql-subqueries-aggregation-top-n"
test -d "$SRC" || { echo "ERROR: estructura ZIP inesperada"; exit 1; }

COUNT=$(find "$SRC/evidence/screenshots" -type f | wc -l)
echo "Capturas en paquete: $COUNT"
test "$COUNT" -gt 0 || { echo "ERROR: paquete sin evidencias"; exit 1; }

mkdir -p labs
rm -rf "$LAB"
cp -r "$SRC" "$LAB" || exit 1
rm -rf "$TMP"

echo "===== ARCHIVOS ====="
find "$LAB" -type f | sort

echo "===== EVIDENCIAS ====="
find "$LAB/evidence/screenshots" -type f | wc -l

echo "===== SECURITY CHECK ====="
grep -RInE '192\.168\.[0-9]{1,3}\.[0-9]{1,3}|10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' "$LAB" || echo "OK - no private IP/MAC patterns found"

git add "$LAB"
git status

# Revisa el status antes de continuar.
git commit -m "Add Lab 06 Db2 SQL subqueries aggregation and Top-N"
git push origin main

git status
git log -3 --oneline
git ls-remote origin refs/heads/main
```
