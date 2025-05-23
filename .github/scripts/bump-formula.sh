#!/usr/bin/env bash

# Usage: bump-formula.sh <package> [latest_version]

if [ -z "$2" ]; then
  .github/scripts/_bump-pr-livecheck.sh "$1"
else
  .github/scripts/_bump-pr.sh "$1" "$2"
fi