#!/usr/bin/env sh
set -e

# == would end up with: scripts/release.sh: 5: [: v3.8.1: unexpected operator
if [ "$1" = "" ]; then
  echo usage: "$0 VERSION"
fi

# git tag $1
# git push origin $1
# gh release create $1 --draft --generate-notes --title "$1" release/*.tgz

user=hexcsl
repo=helm-diff
tag=$1
commit=$2

bin/github-release release -u $user -r $repo -t $tag -c $commit -n $tag

for f in $(ls release); do
  bin/github-release upload -u $user -r $repo -t $tag -n $f -f release/$f
done
