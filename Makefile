topdir := $(PWD)
framework := $(topdir)/aoc.mk
today = dec$(shell TZ=EST date +%d)
year = $(shell date +%Y)
targets = $(sort $(notdir $(patsubst %/,%,$(dir \
    $(wildcard $(year)/dec*/input) \
  ))))
problem = all
timecmd-y = time
timesh- = /bin/sh
timesh-y = /bin/bash

export LANG=C
export TIMEFORMAT=walltime: %Rs

today: $(today)
all: $(targets)

dec%:
	@make -s -f $(framework) -C $(year)/$@ \
		timecmd=$(timecmd-$(time)) \
		sh=$(timesh-$(time)) \
		day=$@ \
		$(problem)

.PHONY: all today dec%
