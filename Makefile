
SHELL	:= /bin/sh
PACKAGE	:= pratt
VERSION	:= $(shell grep VERSION src/pratt.cr | cut -d\" -f2 )

EXE	:= bin/bantam

SOURCES	:= src/*.cr src/*/*.cr

.SUFFIXES:
.SUFFIXES: .html .txt

DESTDIR	:=
prefix		= /usr/local
exec_prefix	= $(prefix)
bindir		= $(exec_prefix)/bin
sbindir		= $(exec_prefix)/sbin
libexecdir	= $(exec_prefix)/libexec

datarootdir	= $(prefix)/share
datadir		= $(datarootdir)

sysconfdir	= $(prefix)/etc

sharedstatedir	= $(prefix)/com

localstatedir	= $(prefix)/var
runstatedir	= $(localstatedir)/run

includedir	= $(prefix)/include

oldincludedir	= /usr/include

docdir		= $(datarootdir)/doc/$(PACKAGE)

infodir		= $(datarootdir)/info

htmldir		= $(docdir)
dvidir		= $(docdir)
pdfdir		= $(docdir)
psdir		= $(docdir)

libdir		= $(exec_prefix)/lib

lispdir		= $(datarootdir)/emacs/site-lisp

localedir	= $(datarootdir)/locale

mandir		= $(datarootdir)/man
man1dir		= $(mandir)/man1
man2dir		= $(mandir)/man2

manext		= .1
man1ext		= .1.gz
man2ext		= .2.gz

srcdir		= $(shell pwd)

AMEBA	:= bin/ameba
AMEBAFLAGS	:= --except Style/RedundantReturn,Layout/TrailingBlankLines

INSTALL		= install
INSTALL_PROGRAM = $(INSTALL) -m 0755
INSTALL_DATA 	= $(INSTALL) -m 0644
INSTALL_DIR 	= $(INSTALL) -d -m 0755


%:	%.in src/pratt.cr
	m4 -D M4_VERSION=$(VERSION) $< > $@

all:	$(EXE)

clean:
	rm -rf $(EXE)

check:	check_spec

check_spec:
	crystal spec

info:
	@echo "$(PACKAGE) v$(VERSION)"

setup:
	shards install

.FORCE:


lint:
	$(AMEBA) $(AMEBAFLAGS)

doc:	$(DOCS)

TAGS:
	ctags -R .

$(EXE):	$(SOURCES) shard.yml
	shards build --error-trace
	rm -f shard.lock

dist:	$(EXE)

.PHONY:	all clean check check_cram chec_spec distclean lint .FORCE

