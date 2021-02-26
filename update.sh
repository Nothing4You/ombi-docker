#!/usr/bin/env bash

v="$1"

sed -r -i "" -e 's|OMBI_PACKAGE=.+|OMBI_PACKAGE=https://github.com/Ombi-app/Ombi/releases/download/'"$v"'/linux-x64.tar.gz|' Dockerfile
git add Dockerfile
git commit -m update to $v"
git tag "$v"
git push --tags
git push
