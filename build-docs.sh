#!/usr/bin/env bash

if [ "$GITHUB_ACTIONS" = "true" ]; then
  echo "This is running in github actions."
  if [ "$GITHUB_REF_NAME" !== "main" ]; then
    # GHA does `set -e` for us, but we expect the grep below to fail. Thus, we must `set +e` here.
    echo "This is not main branch. set +e"
    set +e
  fi
fi

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
