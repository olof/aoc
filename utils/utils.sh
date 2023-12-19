# Sourced shell utilities for aoc 2023
# Generic things, instead of having to copy from previous solutions.

NL='
'
TAB='	'

count() {
	echo $#
}

sum() {
	local n=0
	while read line; do
		n=$((n+line))
	done
	echo $n
}

_op_cmp() {
	x=
	while read line; do
		[ "${x:-$line}" -$1 $line ] || x=$line
	done
	echo $x
}

min() { _op_cmp lt; }
max() { _op_cmd gt; }

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
