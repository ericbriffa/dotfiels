#!/usr/bin/env bash
set -e

workdir=$(mktemp -d)
repo=dotfiles
branch=${BRANCH:-master}
url=https://github.com/ericbriffa/$repo/archive/$branch.zip

echo "Getting files from ${url}"

pushd ${workdir} &>/dev/null

curl -LSfs -o dots.zip "$url" 
unzip -qo dots.zip && cd $repo-$branch

find . -name ".*" -type f -print -exec cp -f {} $HOME \;

popd &>/dev/null
rm -rf $workdir
