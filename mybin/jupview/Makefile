PROG ?= jupview
PREFIX ?= /usr/local
DESTDIR ?=
MANDIR ?= $(PREFIX)/share/man

all:
	@echo "$(PROG) is a shell script and does not need compilation, it can be simply executed."
	@echo ""
	@echo "To install it try \"make install\" instead."
	@echo
	@echo "To run $(PROG) one needs to have some tools installed on the system:"
	@echo "     jupyter nbconvert"
	@echo "     bat"
	@echo "     w3m"

install:
	@install -vd "$(DESTDIR)/$(MANDIR)/man1"
	@install -vm644 jupview.1 "$(DESTDIR)/$(MANDIR)/man1/$(PROG).1"
	@install -vm755 jupview "$(PREFIX)/bin/$(PROG)"
	@echo
	@echo "$(PROG) is installed succesfully"
	@echo

uninstall:
	@rm -vrf \
		"$(PREFIX)/bin/$(PROG)" \
		"$(DESTDIR)$(MANDIR)/man1/$(PROG).1" \

lint:
	shellcheck -s bash $(PROG)
