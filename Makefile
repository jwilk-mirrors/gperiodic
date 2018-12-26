CC := gcc
CFLAGS :=
LIBS :=
LDFLAGS :=
PKG_CONFIG := pkg-config
override CFLAGS += `$(PKG_CONFIG) --cflags gtk+-2.0` -I. $(RPM_OPT_FLAGS)
override LIBS += `$(PKG_CONFIG) --libs gtk+-2.0`
bindir ?= /usr/bin
datadir ?= /usr/share
mandir ?= /usr/share/man/man1
iconsdir ?= /usr/share/icons
enable_nls ?= 1

.c.o:
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $<

all: 
	$(MAKE) gperiodic
	$(MAKE) -C po/ all enable_nls=$(enable_nls)
	intltool-merge -d po gperiodic.desktop.in gperiodic.desktop

gperiodic: gperiodic.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o gperiodic gperiodic.o $(LIBS)
ifeq ($(strip),1)
	strip gperiodic
endif

gpdata.o: gpdata.c gperiodic.h

gperiodic.o: gperiodic.c gperiodic.h table_data.h

install:
	install -D -m 755 gperiodic $(DESTDIR)$(bindir)/gperiodic
	install -D -m 644 gperiodic.desktop $(DESTDIR)$(datadir)/applications/gperiodic.desktop
	install -D -m 644 icons/gperiodic.png $(DESTDIR)$(datadir)/pixmaps/gperiodic.png
	install -D -m 644 icons/gperiodic.xpm $(DESTDIR)$(datadir)/pixmaps/gperiodic.xpm
	install -D -m 644 gperiodic.1 $(DESTDIR)$(mandir)/gperiodic.1
	install -D -m 644 icons/hicolor/16x16/apps/gperiodic.png $(DESTDIR)$(iconsdir)/hicolor/16x16/apps/gperiodic.png
	install -D -m 644 icons/hicolor/32x32/apps/gperiodic.png $(DESTDIR)$(iconsdir)/hicolor/32x32/apps/gperiodic.png
	install -D -m 644 icons/hicolor/48x48/apps/gperiodic.png $(DESTDIR)$(iconsdir)/hicolor/48x48/apps/gperiodic.png
	install -D -m 644 icons/hicolor/64x64/apps/gperiodic.png $(DESTDIR)$(iconsdir)/hicolor/64x64/apps/gperiodic.png
	$(MAKE) -C po/ install enable_nls=$(enable_nls) datadir=$(datadir) DESTDIR=$(DESTDIR)

uninstall:
	rm -f $(bindir)/gperiodic \
	      $(datadir)/applications/gperiodic.desktop \
	      $(datadir)/pixmaps/gperiodic.png \
	      $(datadir)/pixmaps/gperiodic.xpm \
	      $(mandir)/gperiodic.1 \
	      $(iconsdir)/hicolor/16x16/apps/gperiodic.png \
	      $(iconsdir)/hicolor/32x32/apps/gperiodic.png \
	      $(iconsdir)/hicolor/48x48/apps/gperiodic.png \
	      $(iconsdir)/hicolor/64x64/apps/gperiodic.png
	$(MAKE) -C po/ uninstall enable_nls=$(enable_nls) datadir=$(datadir) DESTDIR=$(DESTDIR)

clean:
	rm -f *.o gperiodic gperiodic.desktop
	$(MAKE) -C po/ clean

.PHONY: install uninstall clean
