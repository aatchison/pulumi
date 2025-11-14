#!/usr/bin/env bash
# GHA does `set -e` for us, but we expect the grep below to fail. Thus, we must `set +e` here.
set +e
pip install .[dev]
cd docs
make clean html |& tee make.log
grep '\(ERROR\|WARNING\)' make.log
if [ $? -eq 0 ]; then
  echo "Problems found in docs build"
  exit 1
else
  exit 0
fi
