CC?=gcc
CFLAGS?=-O2
CFLAGS+=-std=gnu99 -Wall -Werror -fpic
LDFLAGS?=
LIBNL=-lnl-tiny
DESTDIR?=
PREFIX?=/usr
INCLUDE_DIR=$(DESTDIR)$(PREFIX)/include/libubox
LIBDIR=$(DESTDIR)$(PREFIX)/lib
CPPFLAGS=
 
OS=$(shell uname)
FILES=blob.c blobmsg.c usock.c uloop.c avl.c utils.c avl.c avl-cmp.c kvlist.c md5.c runqueue.c safe_list.c ulog.c ustream.c ustream-fd.c vlist.c
ifeq ($(OS),Linux)
  LDFLAGS_SHARED=-shared -Wl,-soname,$@
  SHLIB_EXT=so
endif
ifeq ($(OS),Darwin)
  LDFLAGS_SHARED=-dynamiclib
  SHLIB_EXT=dylib
endif
 
all: libubox.$(SHLIB_EXT)

libubox.$(SHLIB_EXT): $(FILES)
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS) $(LDFLAGS_SHARED)

install-headers:
	mkdir -p $(INCLUDE_DIR)
	cp blob.h $(INCLUDE_DIR)/
	cp blobmsg.h $(INCLUDE_DIR)/
	cp usock.h $(INCLUDE_DIR)/
	cp uloop.h $(INCLUDE_DIR)/
	cp avl.h $(INCLUDE_DIR)/
	cp utils.h $(INCLUDE_DIR)/
	cp avl-cmp.h $(INCLUDE_DIR)/
	cp kvlist.h $(INCLUDE_DIR)/
	cp md5.h $(INCLUDE_DIR)/
	cp runqueue.h $(INCLUDE_DIR)/
	cp safe_list.h $(INCLUDE_DIR)/
	cp ulog.h $(INCLUDE_DIR)/
	cp ustream.h $(INCLUDE_DIR)/
	cp vlist.h $(INCLUDE_DIR)/
	cp assert.h $(INCLUDE_DIR)/
	cp list.h $(INCLUDE_DIR)/


install-lib:
	mkdir -p $(LIBDIR)
	cp libubox.$(SHLIB_EXT) $(LIBDIR)/

install: install-lib install-headers

clean:
	rm -f *.$(SHLIB_EXT)