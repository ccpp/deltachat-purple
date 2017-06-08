CFLAGS=-g -Wall $(shell pkg-config --cflags purple glib-2.0)
LDFLAGS=-lldap -llber $(shell pkg-config --libs purple glib-2.0)
DELTACHAT_CORE=~/src-pub/deltachat-core/bin/Debug/deltachat-core

default: deltachat-purple.so

deltachat-purple.so: deltachat-purple.o
	$(CC) -shared $(LDFLAGS) $< -o $@

deltachat-purple.o: deltachat-purple.c
	$(CC) -fPIC $(CFLAGS) -c -o $@ $<

install: deltachat-purple.so
	install -vm 664 $< $(DESTDIR)/usr/lib/purple-2/

uninstall:
	rm -fv $(DESTDIR)/usr/lib/purple-2/deltachat-purple.so

install-user: deltachat-purple.so
	install -vm 664 $< $(HOME)/.purple/plugins/

uninstall-user:
	rm -fv $(HOME)/.purple/plugins/deltachat-purple.so
