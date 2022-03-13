#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

git diff --quiet || (echo '!!! Repo contains uncommitted changes, can not release. !!!' && exit 1)

BUILD_NUMBER=$(grep buildNumber "$__dir/../src/pdxinfo" | sed 's/buildNumber=//')
VERSION=$(grep version "$__dir/../src/pdxinfo" | sed 's/version=//')

# Increment the build
NEW_BUILD_NUMBER=$((BUILD_NUMBER+1))
sed -i '' "s/buildNumber=.*$/buildNumber=$NEW_BUILD_NUMBER/" "$__dir/../src/pdxinfo" 

# Make the release
pdc src/ "ThreeDee-${VERSION}_${NEW_BUILD_NUMBER}.pdx"
zip -r "$__dir/../ThreeDee-${VERSION}_${NEW_BUILD_NUMBER}.zip" "$__dir/../ThreeDee-${VERSION}_${NEW_BUILD_NUMBER}.pdx"

git add src/pdxinfo
git commit -m "Release v${VERSION} Build ${NEW_BUILD_NUMBER}"
git tag "v$VERSION"