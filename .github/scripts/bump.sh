#!/usr/bin/env bash

# Usage: bump.sh <package> [--cask]

PACKAGE=$1
FULL_PKG_NAME="$(brew tap)/$1"
CASK_FLAG=$2

# Get current and latest version from livecheck
brew livecheck "$FULL_PKG_NAME" # To remove extra log from json, pre-run same command.
JSON=$(brew livecheck --quiet --json "$FULL_PKG_NAME")
CURRENT_VERSION=$(echo "$JSON" | jq -r '.[0].version.current')
LATEST_VERSION=$(echo "$JSON" | jq -r '.[0].version.latest')
# if livecheck skipped, CURRENT_VERSION and LATEST_VERSION is "null"
[ -z "$CURRENT_VERSION" ] && echo "Current version is not found" && exit 1
[ -z "$LATEST_VERSION" ] && echo "Latest version is not found" && exit 1
if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
  echo "$FULL_PKG_NAME is already up to date (or livecheck is skipped)"
  exit 0
fi

# Create PR
if [ "$CASK_FLAG" = "--cask" ]; then
  brew bump-cask-pr "$FULL_PKG_NAME" --no-browse --no-fork --version "$LATEST_VERSION" > tmp.log 2>&1; ret=$?; cat tmp.log
else
  brew bump-formula-pr "$FULL_PKG_NAME" --no-browse --no-fork --version "$LATEST_VERSION" > tmp.log 2>&1; ret=$?; cat tmp.log
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
