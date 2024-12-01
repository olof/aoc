#!/bin/sh
input="$(cat)"
zipmap() {
	fun=$1 && shift
	while read b; do
		echo $($fun $1 $b) && shift
	done
}

abs() { [ $1 -lt 0 ] && echo $((-$1)) || echo $1; }
diff() { abs $(($1-$2)); }
sum() { s=0; while read n; do s=$((s+n)); done; echo $s; }
a=$(printf "%s%.0s\n" $input | sort)
b=$(printf "%.0s%s\n" $input | sort)
echo "$b" | zipmap diff $a | sum
