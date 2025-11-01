#!/usr/bin/env bash

# Usage: _create_and_merge_pr.sh <package> <version> [--cask]

PACKAGE=$1
VERSION=$2

if [ "$3" = "--cask" ]; then
  brew bump-cask-pr "$PACKAGE" --no-browse --no-fork --version "$VERSION" > tmp.log 2>&1; ret=$?; cat tmp.log
else
  brew bump-formula-pr "$PACKAGE" --no-browse --no-fork --version "$VERSION" > tmp.log 2>&1; ret=$?; cat tmp.log
fi

# If the command-log includes specific message, return 0. Otherwise, return the error code
if [ "$ret" -ne 0 ]; then
  if grep -q "Duplicate PRs must not be opened." tmp.log \
    || grep -q "pull requests are duplicates" tmp.log \
    || grep -q "nothing to commit, working tree clean" tmp.log; then
    exit 0
  fi
  exit "$ret"
fi
# Find branch & PR from log, and merge it
BRANCH=$(grep -oE "branch '[^']+" -m 1 tmp.log | sed "s/branch '//")
PR=$(gh pr list --head "$BRANCH" --json number --jq ".[0].number")
gh pr merge "$PR" --merge --delete-branch
