#!/usr/bin/env bash
set -euo pipefail

ZIP="$HOME/Downloads/DB2_LAB01_PART1.zip"
REPO="/c/Carrera_Ciberseguridad/06_Portfolio_GitHub/DB2"
REMOTE="https://github.com/P-dot/DB2-.git"

test -f "$ZIP" || { echo "ERROR: no encuentro $ZIP"; exit 1; }
mkdir -p "$REPO"
unzip -o "$ZIP" -d "$REPO"
cd "$REPO"

[ -d .git ] || git init
git branch -M main

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE"
else
  git remote add origin "$REMOTE"
fi

git add .
git status --short

if ! git diff --cached --quiet; then
  git commit -m "Close DB2 Lab 01 Part 1 subsystem and catalog foundations"
fi

git push -u origin main

echo
echo "===== FINAL CHECK ====="
git status
git log -1 --oneline
git remote -v
