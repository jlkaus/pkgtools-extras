.PHONY: all pkgtools kerneltools install installdirs distclean clean clean-pkgtools clean-kerneltools install-pkgtools install-kerneltools dist sbo

# Defined in here for my makefile use, and as a reminder.
prefix ?= /usr/local
exec_prefix ?= $(prefix)
bindir ?= $(exec_prefix)/bin
sbindir ?= $(exec_prefix)/sbin
libexecdir ?= $(exec_prefix)/libexec
datarootdir ?= $(prefix)/share
datadir ?= $(datarootdir)
# Here to remind myself of it (and its normal default, $(prefix)/etc) but cannot be usefully changed
# for these scripts, since they are not actually built, and have to find their config file somewhere by default...
sysconfdir ?= /etc
#sharedstatedir ?= $(prefix)/com
# Another one that changing at make time isn't useful.
# Our own local state directory is defined in the config file to allow changes, or use of slackpkg, etc.
# The local state directory of the normal pkgtools is also set in the config file for uniformity, but on
# Slackware systems, can't usefully be changed.
#localstatedir ?= /var/local
#runstatedir ?= /run
#includedir ?= $(prefix)/include
# Used by the SlackBuild, but not the makefile
#docdir ?= $(datarootdir)/doc/pkgtools-extras
#infodir ?= $(datarootdir)/info
#libdir ?= $(exec_prefix)/lib
#localedir ?= $(datarootdir)/locale
mandir ?= $(datarootdir)/man
man5dir ?= $(mandir)/man5
man8dir ?= $(mandir)/man8

VERSION := $(file < VERSION)


all: pkgtools kerneltools

pkgtools:

kerneltools:

clean: clean-pkgtools clean-kerneltools

distclean:
	rm -rf dist

dist: dist/pkgtools-extras-$(VERSION).tar.gz

dist/pkgtools-extras-$(VERSION).tar.gz:
	mkdir -p dist
	git archive --format=tar --prefix=pkgtools-extras-$(VERSION)/ v$(VERSION) |gzip > dist/pkgtools-extras-$(VERSION).tar.gz

sbo: sbo/pkgtools-extras.info sbo/pkgtools-extras.SlackBuild sbo/slack-desc sbo/README.SBO dist/pkgtools-extras-$(VERSION).tar.gz
	$(eval MD5SUM = $(firstword $(shell md5sum dist/pkgtools-extras-$(VERSION).tar.gz)))
	mkdir -p dist
	cp sbo/README.SBO dist/README
	cp sbo/slack-desc dist/slack-desc
	sed -e 's/^TAG=.*$$/TAG=$${TAG:-_SBo}/; s/^VERSION=.*$$/VERSION=$${VERSION:-$(VERSION)}/;' sbo/pkgtools-extras.SlackBuild > dist/pkgtools-extras.SlackBuild
	sed -e 's/{VERSION}/$(VERSION)/g; s/{MD5SUM}/$(MD5SUM)/' sbo/pkgtools-extras.info > dist/pkgtools-extras.info

clean-pkgtools:

clean-kerneltools:

install: install-pkgtools install-kerneltools

installdirs:
	install -d -o root -g root -m 0755 $(DESTDIR)$(sbindir) $(DESTDIR)$(man5dir) $(DESTDIR)$(man8dir) $(DESTDIR)$(sysconfdir)

install-pkgtools: pkgtools installdirs
	install -t $(DESTDIR)$(sysconfdir) -o root -g root -m 0644 config/pkgtools-extras.conf.new
	install -t $(DESTDIR)$(sbindir) -o root -g root -m 0755 scripts/{fetchpkg,findpkg,updatepkglists}
	install -t $(DESTDIR)$(man5dir) -o root -g root -m 0644 man-pages/pkgtools-extras.conf.5
	install -t $(DESTDIR)$(man8dir) -o root -g root -m 0644 man-pages/{fetchpkg,findpkg,updatepkglists}.8

install-kerneltools: kerneltools installdirs

