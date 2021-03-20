all: bootstrap template build sign

bootstrap:
	bash scripts/clone.sh
	./void-packages/xbps-src binary-bootstrap

template:
	bash scripts/template.sh

build:
	./void-packages/xbps-src pkg nvim

sign:
	xbps-rindex --privkey private.pem --sign --signedby "Luca Tagliavini" ./void-packages/hostdir/binpkgs
	xbps-rindex --privkey private.pem --sign-pkg ./void-packages/hostdir/binpkgs/*.xbps

clean:
	rm -rf tmp void-packages/tmp void-packages/srcpkgs/nvim
	./void-packages/xbps-src clean
