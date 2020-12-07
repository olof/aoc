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
count- = 1
count-y = 100
output-y = >/dev/null
timesh-y = /bin/bash

export LANG=C
export TIMEFORMAT=%Rs

today: $(today)
all: $(targets)

dec%:
	@make -s -f $(framework) -C $(year)/$@ \
		timecmd=$(timecmd-$(time)) \
		sh=$(timesh-$(time)) \
		day=$@ \
		count=$(count-$(time)) \
		output="$(output-$(time))" \
		$(problem)

.PHONY: all today dec%
