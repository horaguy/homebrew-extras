#!/usr/bin/env bash

# Usage: bump-cask.sh <package> [latest_version]

if [ -z "$2" ]; then
  .github/scripts/_bump-pr-livecheck.sh "$1" --cask
else
  .github/scripts/_bump-pr.sh "$1" "$2" --cask
fi