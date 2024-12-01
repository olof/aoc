#!/bin/sh
in="$(cat)"
eval $(printf "%.0s%s\n" $in | sort | uniq -c | while read c m; do
	echo m$m=$c
done) && s=0 printf "%s%.0s\n" $in | while read n; do
	eval echo '$((' $n \* \${m$n:-0} '))'
done | { while read n; do s=$((s+n)); done; echo $s; }
