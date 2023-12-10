#!/bin/sh
sum() { n=0; while read line; do n=$((n+line)); done; echo $n; }

join() {
	local delim="$1"
	shift
	[ "$#" -ge 1 ] || return 0
	printf "%s" "$1"
	shift
	for arg in "$@"; do
		printf "%s%s" "$delim" "$arg"
	done
	printf "\n"
}

count() {
	echo $#;
}

while read p p2 line; do
	needles=${line% |*}
	haystack=${line#*| }
	match=$(echo "$needles" | grep -Eo "$(join '|' $(printf '\\b%s\\b ' $haystack))")
	count=$(count $match)
	[ "$count" -gt 0 ] || continue
	echo $(( 1 << (count-1) ))
done | sum
