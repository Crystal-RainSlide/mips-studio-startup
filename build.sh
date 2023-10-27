#!/bin/bash

DIR="$(pwd)"

wget https://mirrors.bfsu.edu.cn/github-release/VSCodium/vscodium/LatestRelease/VSCodium-linux-x64-1.83.1.23285.tar.gz \
	-O vscodium.tar.gz

mkdir -pv "$DIR"/dist_electron/vscodium && pushd "$_"
tar xvf "$DIR"/vscodium.tar.gz
mkdir -v data
popd

npm run electron:build
