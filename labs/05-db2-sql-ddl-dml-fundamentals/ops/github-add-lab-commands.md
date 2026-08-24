```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/DB2
ZIP="$HOME/Downloads/05-db2-sql-ddl-dml-fundamentals.zip"
TMP="$HOME/Downloads/lab05-tmp"
test -f "$ZIP" || exit 1
rm -rf "$TMP"; mkdir -p "$TMP"
unzip -o "$ZIP" -d "$TMP" || exit 1
test -d "$TMP/05-db2-sql-ddl-dml-fundamentals" || exit 1
rm -rf labs/05-db2-sql-ddl-dml-fundamentals
cp -r "$TMP/05-db2-sql-ddl-dml-fundamentals" labs/
rm -rf "$TMP"
git add labs/05-db2-sql-ddl-dml-fundamentals
git status
git commit -m "Add Lab 05 Db2 SQL DDL and DML fundamentals"
git push origin main
```
