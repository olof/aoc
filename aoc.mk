LANGUAGE-2020 = perl
LANGUAGE-2021 = raku
LANGUAGE = $(LANGUAGE-$(year))

LANGUAGE_EXT-perl := pl
LANGUAGE_EXT-raku := p6
LANGUAGE_EXT = $(LANGUAGE_EXT-$(LANGUAGE))

SCRIPT = $(LANGUAGE) <input $@.$(LANGUAGE_EXT)

sh = /bin/sh
all: 1 2
count = 1
loop = while [ $${n:=0} -lt $(count) ]; do
loop_end = ; n=$$((n+1)); done

-include aoc.mk

1 2:
	[ -e input ] || exit 0; \
	echo -n "$(day)/$@: "; \
	$(sh) -c '$(timecmd) ( $(loop) $(SCRIPT) $(output) $(ARGS) $(loop_end) )'

.PHONY: all 1 2
