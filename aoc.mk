LANGUAGE-2020 = perl
LANGUAGE-2021 = raku
LANGUAGE-2022 = sh
LANGUAGE = $(LANGUAGE-$(year))

LANGUAGE_EXT-perl := pl
LANGUAGE_EXT-raku := p6
LANGUAGE_EXT-sh := sh
LANGUAGE_EXT = $(LANGUAGE_EXT-$(LANGUAGE))

problem ?= all
PROBLEM_SOLUTION = $(problem).$(LANGUAGE_EXT)

SCRIPT = $(LANGUAGE) <input $@.$(LANGUAGE_EXT)
EDIT = $(EDITOR) $(PROBLEM_SOLUTION)

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

edit:
	@[ "$(problem)" = all ] || $(EDIT)
	@[ "$(problem)" != all ] || { \
		echo Error: to edit, specify problem=1 or problem=2 >&2; \
		exit 1; \
	}

.PHONY: all 1 2
