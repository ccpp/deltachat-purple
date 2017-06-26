CFLAGS=-g -Wall $(shell pkg-config --cflags purple glib-2.0)
LDFLAGS=$(shell pkg-config --libs purple glib-2.0)
DELTACHAT_CORE=contrib/deltachat-core/bin/Debug/deltachat-core
PREFIX=/usr/local

default: bin/deltachat-purple.so $(DELTACHAT_CORE)

bin/deltachat-purple.so: bin/deltachat-purple.o bin/deltachat-protocol.o
	$(CC) -shared $(LDFLAGS) $^ -o $@

bin/%.o: src/%.c
	mkdir -p -v bin
	$(CC) -fPIC $(CFLAGS) -c -o $@ $<

.ONESHELL: contrib/deltachat-core/bin/Debug/deltachat-core
contrib/deltachat-core/bin/Debug/deltachat-core: contrib/deltachat-core/
	@codeblocks --no-splash-screen --debug-log --file=$</deltachat-core.cbp --build --verbose
	if [ $$? != 0 ]
	then
		echo "COMPILATION OF DELTACHAT-CORE FAILED!"
		echo "Please compile it using codeblocks by hand..."
		echo "Do this by importing file $</deltachat-core.cbp"
		false
	fi

contrib/deltachat-core/deltachat-core.cbp:
	git submodule update --init contrib/deltachat-core
	(cd contrib/deltachat-core && git apply ../../deltachat-core-c99.patch) || true

install: bin/deltachat-purple.so $(DELTACHAT_CORE)
	mkdir -pv $(DESTDIR)$(PREFIX)/share/purple/deltachat
	install -vm 664 $< $(DESTDIR)$(PREFIX)/lib/purple-2/
	install -vm 755 $(DELTACHAT_CORE) $(DESTDIR)$(PREFIX)/share/purple/deltachat/deltachat-core

uninstall:
	rm -fv $(DESTDIR)/usr/lib/purple-2/deltachat-purple.so

install-user: bin/deltachat-purple.so
	mkdir -pv $(HOME)/.purple/deltachat/
	install -vm 664 $< $(HOME)/.purple/plugins/
	install -vm 755 $(DELTACHAT_CORE) $(HOME)/.purple/deltachat/deltachat-core

uninstall-user:
	rm -fv $(HOME)/.purple/plugins/deltachat-purple.so
