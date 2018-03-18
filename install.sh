#!/usr/bin/env bash
set -e

workdir=/tmp/dotfiles
repo=dotfiles
branch=master

mkdir -p $workdir && pushd $workdir &>/dev/null

curl -LSfs -o dots.zip https://github.com/ericbriffa/$repo/archive/$branch.zip
unzip -qo dots.zip && cd $repo-$branch

find . -name ".*" -type f -print -exec cp {} $HOME \;

popd &>/dev/null