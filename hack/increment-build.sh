#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BUILD_NUMBER=$(grep buildNumber "$__dir/../src/pdxinfo" | sed 's/buildNumber=//')
NEW_BUILD_NUMBER=$((BUILD_NUMBER+1))

sed -i '' "s/buildNumber=.*$/buildNumber=$NEW_BUILD_NUMBER/" "$__dir/../src/pdxinfo" 