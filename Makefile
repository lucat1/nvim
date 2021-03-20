all: clone bootstrap template build sign

clone:
	bash scripts/clone.sh

bootstrap:
	./void-packages/xbps-src binary-bootstrap

template:
	bash scripts/template.sh

build:
	./void-packages/xbps-src pkg nvim

sign:
	xbps-rindex --privkey private.pem --sign --signedby "Luca Tagliavini" ./void-packages/hostdir/binpkgs
	xbps-rindex --privkey private.pem --sign-pkg ./void-packages/hostdir/binpkgs/*.xbps

tree:
	bash scripts/tree.sh $$PWD/void-packages/hostdir/binpkgs $$PWD/void-packages/hostdir/binpkgs/ https://lucat1.github.io/nvim

clean:
	rm -rf tmp void-packages/tmp void-packages/srcpkgs/nvim
	./void-packages/xbps-src clean
	rm void-packages/hostdir/**/*.html
