# GitHub installation

Repository used for the Db2/CICS development labs:

```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/mainframe-cobol-db2-cics-devops-lab

ZIP="$HOME/Downloads/04-db2-spufi-racf-opercmds-incident.zip"
TMP="/tmp/04-db2-spufi-racf-opercmds-incident"
LAB="labs/04-db2-spufi-racf-opercmds-incident"

rm -rf "$TMP"
rm -rf "$LAB"

mkdir -p "$TMP"
unzip -o "$ZIP" -d "$TMP"
cp -R "$TMP/04-db2-spufi-racf-opercmds-incident" "$LAB"

echo "===== LAB TREE ====="
find "$LAB" -maxdepth 4 -type f | sort

echo
echo "===== SECURITY CHECK ====="
grep -RInE \
'192\.168\.[0-9]{1,3}\.[0-9]{1,3}|10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' \
"$LAB" || echo "OK - no private IP/MAC patterns found"

echo
echo "===== GIT ====="
git status
git add "$LAB"
git commit -m "Add Lab 04 Db2 SPUFI RACF OPERCMDS incident analysis"
git push -u origin main

echo
echo "===== VERIFICATION ====="
git status
git log -3 --oneline
git ls-remote origin refs/heads/main
```
