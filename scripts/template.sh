#!/bin/bash -e

dir=$(pwd)/void-packages
mkdir -p $dir/srcpkgs/nvim
ndir=$dir/srcpkgs/nvim
mkdir -p $dir/tmp
tmp=$dir/tmp

curl \
  -H "Accept: application/vnd.github.v3+json" \
  -s -o $tmp/release.json \
  https://api.github.com/repos/neovim/neovim/releases/tags/nightly
version=$(jq -r '.name' $tmp/release.json | sed 's/[^ ]* //')
version=${version##*-}
url=$(jq -r '.tarball_url' $tmp/release.json)
long_commit=$(jq -r '.target_commitish' $tmp/release.json)

echo "version: $version"
echo "url: $url" echo "long_commit: $url"

builddir=$tmp/build
tarfile=$builddir/nvim-$version.tar.gz 
mkdir -p $builddir
echo "tarfile: $tarfile"

wget $url -O $tarfile
sha=$(sha256sum $tarfile | awk '{print $1;}')
tar xfz $tarfile -C $builddir
ls $builddir
wrksrc=$(ls $builddir | grep -v '\.')

echo "sha: $sha"
echo "wrksrc: $wrksrc"

cat << EOF > $ndir/template
# Template file for 'nvim', the nightly build of 'neovim'
pkgname=nvim
version="$version"
revision=0
build_style=cmake
build_helper="qemu"
hostmakedepends="pkg-config gettext gperf LuaJIT lua51-lpeg lua51-mpack"
makedepends="libtermkey-devel libuv-devel libvterm-devel msgpack-devel LuaJIT-devel
 libluv-devel tree-sitter-devel"
depends="libvterm>=0.1.0"
short_desc="Fork of Vim aiming to improve user experience, plugins and GUIs. Nightly version"
maintainer="Luca Tagliavini <fromzeroluke1@gmail.com>"
license="Apache-2.0, custom:Vim"
homepage="https://neovim.io"
distfiles="$url>nvim-$version.tar.gz"
checksum=$sha
wrksrc=$wrksrc

alternatives="
 vi:vi:/usr/bin/nvim
 vi:vi.1:/usr/share/man/man1/nvim.1
 vi:view:/usr/bin/nvim
 vi:view.1:/usr/share/man/man1/nvim.1
 vim:vim:/usr/bin/nvim
 vim:vim.1:/usr/share/man/man1/nvim.1"

pre_configure() {
	vsed -i runtime/CMakeLists.txt \
		-e "s|\".*/bin/nvim|\${CMAKE_CROSSCOMPILING_EMULATOR} &|g"
}

post_install() {
	vlicense LICENSE
}
EOF
