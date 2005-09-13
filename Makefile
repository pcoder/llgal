NAME	=	llgal
VERSION	=	0.11

.PHONY: llgal clean install uninstall tarball

DESTDIR	=	
PREFIX	=	/usr/local
EXEC_PREFIX	=	$(PREFIX)
BINDIR	=	$(EXEC_PREFIX)/bin
DATADIR	=	$(PREFIX)/share
SYSCONFDIR	=	$(PREFIX)/etc
MANDIR	=	$(PREFIX)/man

TARBALL	=	$(NAME)-$(VERSION)
DEBIAN_TARBALL	=	$(NAME)_$(VERSION).orig

llgal::
	sed -e 's!@DATADIR@!$(DESTDIR)$(DATADIR)!g' -e 's!@SYSCONFDIR@!$(DESTDIR)$(SYSCONFDIR)!g' -e 's!@VERSION@!$(VERSION)!g' < llgal.in > llgal

clean::
	rm -f llgal

install::
	install -d -m 0755 $(DESTDIR)$(BINDIR)/ $(DESTDIR)$(DATADIR)/llgal/ $(DESTDIR)$(MANDIR)/man1/ $(DESTDIR)$(SYSCONFDIR)/llgal/
	install -m 0755 llgal $(DESTDIR)$(BINDIR)/llgal
	install -m 0644 captions.header llgal.css indextemplate.html slidetemplate.html $(DESTDIR)$(DATADIR)/llgal/
	install -m 0644 tile.png index.png prev.png next.png $(DESTDIR)$(DATADIR)/llgal/
	install -m 0644 llgalrc $(DESTDIR)$(SYSCONFDIR)/llgal/
	install -m 0644 llgal.1 $(DESTDIR)$(MANDIR)/man1/

uninstall::
	rm $(DESTDIR)$(BINDIR)/llgal
	rm -rf $(DESTDIR)$(DATADIR)/llgal/
	rm -rf $(DESTDIR)$(SYSCONFDIR)/llgal/
	rm $(DESTDIR)$(MANDIR)/man1/llgal.1

tarball::
	mkdir /tmp/$(TARBALL)
	cp llgal.in /tmp/$(TARBALL)
	cp captions.header llgal.css indextemplate.html slidetemplate.html /tmp/$(TARBALL)
	cp tile.png index.png prev.png next.png /tmp/$(TARBALL)
	cp llgalrc /tmp/$(TARBALL)
	cp llgal.1 /tmp/$(TARBALL)
	cp Makefile /tmp/$(TARBALL)
	cp README /tmp/$(TARBALL)
	cp COPYING /tmp/$(TARBALL)
	cp Changes /tmp/$(TARBALL)
	cp UPGRADE /tmp/$(TARBALL)
	cd /tmp && tar cfz $(DEBIAN_TARBALL).tar.gz $(TARBALL)
	cd /tmp && tar cfj $(TARBALL).tar.bz2 $(TARBALL)
	mv /tmp/$(DEBIAN_TARBALL).tar.gz /tmp/$(TARBALL).tar.bz2 ..
	rm -rf /tmp/$(TARBALL)
