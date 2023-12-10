#!/bin/sh
. utils.sh

resolve_line() {
	line_id=${1#Card } line_id=$(echo ${line_id%%:*})
	haystack=${1#*| }
	needles=${1#*: } needles=${needles%|*}
	match=$(echo "$needles" |
	        grep -Eo "$(join '|' $(printf '\\b%s\\b ' $haystack))")
	count=$(count $match)

	acc=1 reward=
	[ "$count" -eq 0 ] ||
		reward="$(seq $((line_id+1)) $((line_id+count)))"

	for r in $reward; do
		eval 'acc=$(( acc + count_'"$r"' ))'
	done

	eval count_$line_id=\$acc
	echo $acc
}

tac | while read line; do resolve_line "$line"; done | sum
