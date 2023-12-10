#!/bin/sh
. utils.sh
while read p p2 line; do
	needles=${line% |*}
	haystack=${line#*| }
	match=$(echo "$needles" | grep -Eo "$(join '|' $(printf '\\b%s\\b ' $haystack))")
	count=$(count $match)
	[ "$count" -gt 0 ] || continue
	echo $(( 1 << (count-1) ))
done | sum
