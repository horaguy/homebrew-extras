#!/usr/bin/env bash

# Usage: bump-pr.sh <package> <latest_version> [--cask]

PACKAGE=$1
FULL_PKG_NAME="$(brew tap)/$1"
LATEST_VERSION=$2
CASK_FLAG=$3

brew doctor # Fetch API json data, before running livecheck. Otherwise, unnecessary fetch-logs are included in the output of livecheck.
JSON=$(brew info --quiet --json=v2 "$CASK_FLAG" "$FULL_PKG_NAME")
echo "JSON: $JSON"
CURRENT_VERSION=$(echo "$JSON" | jq -r '(.formulae[]?.versions.stable, .casks[]?.version) // empty | select(. != "")')
echo "CURRENT_VERSION: $CURRENT_VERSION"
echo "LATEST_VERSION: $LATEST_VERSION"
[ -z "$CURRENT_VERSION" ] && echo "Current version is not found" && exit 1
[ -z "$LATEST_VERSION" ] && echo "Latest version is required" && exit 1
if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
  echo "$FULL_PKG_NAME is already up to date"
  exit 0
fi

.github/scripts/_create_and_merge_pr.sh "$FULL_PKG_NAME" "$LATEST_VERSION" "$CASK_FLAG"
