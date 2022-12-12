export TOPDIR := $(PWD)
export EDITOR ?= vim
export LANG=C.utf-8
export TIMEFORMAT=%Rs

framework := $(TOPDIR)/aoc.mk
today := dec$(shell TZ=EST date +%d)
day ?= $(today)
year = $(shell date +%Y)
targets = $(sort $(notdir $(patsubst %/,%,$(dir \
    $(wildcard $(year)/dec*/input) \
  ))))
problem = all
timecmd-y = time
timesh- = /bin/sh
count- = 1
count-y = 1
count = $(count-$(time))
output-y = >/dev/null
timesh-y = /bin/bash

-include env.mk

today: $(today)
all: $(targets)

dec%:
	@make -s -f $(framework) -C $(year)/$@ \
		timecmd=$(timecmd-$(time)) \
		sh=$(timesh-$(time)) \
		year=$(year) \
		day=$@ \
		problem=$(problem) \
		count=$(count) \
		output="$(output-$(time))" \
		$(problem)

init-day: $(year)/$(day)
	@make -s -f $(framework) -C $(year)/$(day) \
		year=$(year) \
		day=$(day) \
		init

language: $(year)/$(day)
	@make -s -f $(framework) -C $(year)/$(day) \
		year=$(year) \
		day=$(day) \
		problem=$(problem) \
		LANGUAGE=$(LANGUAGE) \
		language

$(year)/$(day):
	mkdir -p $(year)/$(day)

edit: init-day
	@make -s -f $(framework) -C $(year)/$(day) \
		year=$(year) \
		day=$(day) \
		problem=$(problem) \
		$@

.PHONY: init-day all today dec%
