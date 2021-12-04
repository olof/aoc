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
count-y = 1
count = $(count-$(time))
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
		year=$(year) \
		day=$@ \
		count=$(count) \
		output="$(output-$(time))" \
		$(problem)

.PHONY: all today dec%
