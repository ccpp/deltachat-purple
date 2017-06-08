CFLAGS=-g -Wall $(shell pkg-config --cflags purple glib-2.0)
LDFLAGS=-lldap -llber $(shell pkg-config --libs purple glib-2.0)
DELTACHAT_CORE=~/src-pub/deltachat-core/bin/Debug/deltachat-core

default: purple-deltachat.so

purple-deltachat.so: purple-deltachat.o
	$(CC) -shared $(LDFLAGS) $< -o $@

purple-deltachat.o: purple-deltachat.c
	$(CC) -fPIC $(CFLAGS) -c -o $@ $<

install: purple-deltachat.so
	install -vm 664 $< $(DESTDIR)/usr/lib/purple-2/

uninstall:
	rm -fv $(DESTDIR)/usr/lib/purple-2/purple-deltachat.so

install-user: purple-deltachat.so
	install -vm 664 $< $(HOME)/.purple/plugins/

uninstall-user:
	rm -fv $(HOME)/.purple/plugins/purple-deltachat.so
