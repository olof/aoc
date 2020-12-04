SCRIPT = perl <input $@.pl
sh = /bin/sh
all: 1 2

-include aoc.mk

1 2:
	[ -e input ] || exit 0; \
	echo -n "$(day)/$@: "; \
	$(sh) -c "$(timecmd) $(SCRIPT) $(ARGS)"

.PHONY: all 1 2
