.PHONY: all pkgtools kerneltools install clean clean-pkgtools clean-kerneltools install-pkgtools install-kerneltools gen-source-package gen-sbo-artifacts

VERSION := $(file < VERSION)

all: pkgtools kerneltools

pkgtools:

kerneltools:

clean: clean-pkgtools clean-kerneltools
	rm -rf dist

gen-source-package: dist/pkgtools-extras-$(VERSION).tar.gz

dist/pkgtools-extras-$(VERSION).tar.gz:
	mkdir -p dist
	git archive --format=tar --prefix=pkgtools-extras-$(VERSION)/ v$(VERSION) |gzip > dist/pkgtools-extras-$(VERSION).tar.gz

gen-sbo-artifacts: package-building/pkgtools-extras.info package-building/pkgtools-extras.SlackBuild package-building/slack-desc package-building/README.SBO dist/pkgtools-extras-$(VERSION).tar.gz
	$(eval MD5SUM = $(firstword $(shell md5sum dist/pkgtools-extras-$(VERSION).tar.gz)))
	mkdir -p dist
	cp package-building/README.SBO dist/README
	cp package-building/slack-desc dist/slack-desc
	sed -e 's/^TAG=.*$$/TAG=$${TAG:-_SBo}/; s/^VERSION=.*$$/VERSION=$${VERSION:-$(VERSION)}/;' package-building/pkgtools-extras.SlackBuild > dist/pkgtools-extras.SlackBuild
	sed -e 's/{VERSION}/$(VERSION)/g; s/{MD5SUM}/$(MD5SUM)/' package-building/pkgtools-extras.info > dist/pkgtools-extras.info



clean-pkgtools:

clean-kerneltools:

install: install-pkgtools install-kerneltools

install-pkgtools: pkgtools



install-kerneltools: kerneltools


