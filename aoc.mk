LANGUAGE-2020 = perl
LANGUAGE-2021 = raku
LANGUAGE-2022 = sh
LANGUAGE-2023 = sh
LANGUAGE-2024 = python3
LANGUAGE = $(LANGUAGE-$(year))

LANGUAGE_EXT-perl := pl
LANGUAGE_EXT-raku := p6
LANGUAGE_EXT-sh := sh
LANGUAGE_EXT-python3 := py
LANGUAGE_EXT = $(LANGUAGE_EXT-$(LANGUAGE))

problem ?= all
PROBLEM_SOLUTION = $(problem).$(LANGUAGE_EXT)

export PATH := $(TOPDIR)/utils:$(PATH)
INPUT ?= input
ifeq ($(EXEC-$(LANGUAGE)),y)
SCRIPT = <$(INPUT) ./$@.$(LANGUAGE_EXT)
else
SCRIPT = $(LANGUAGE) <$(INPUT) $@.$(LANGUAGE_EXT)
endif
EDIT = $(EDITOR) $(PROBLEM_SOLUTION)

day_num := $(subst dec,,$(subst dec0,,$(day)))

sh = /bin/sh
all: 1 2
count = 1
loop = while [ $${n:=0} -lt $(count) ]; do
loop_end = ; n=$$((n+1)); done

-include aoc.mk
-include $(TOPDIR)/env.mk

1 2:
	[ -e input ] || exit 0; \
	echo -n "$(day)/$@: "; \
	$(sh) -c '$(timecmd) ( $(loop) $(SCRIPT) $(output) $(ARGS) $(loop_end) )'

init: input

input:
	curl -O 'https://adventofcode.com/$(year)/day/$(day_num)/input' -H 'Accept: text/plain' -H '@$(TOPDIR)/session.cookie'

edit:
	@[ "$(problem)" = all ] || $(EDIT)
	@[ "$(problem)" != all ] || { \
		echo Error: to edit, specify problem=1 or problem=2 >&2; \
		exit 1; \
	}

language: language-$(problem)
language-all:
	echo LANGUAGE = $(LANGUAGE) >> aoc.mk
language-1:
	echo 1: LANGUAGE = $(LANGUAGE) >> aoc.mk
language-2:
	echo 1: LANGUAGE = $(LANGUAGE) >> aoc.mk

.PHONY: all 1 2
