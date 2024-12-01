#!/bin/sh
sum() { s=0; while read n; do s=$((s+n)); done; echo $s; }
count() { sort | uniq -c; }
in="$(cat)"
eval $(printf "%.0s%s\n" $in | count |
       while read c m; do echo export m$m=$c; done)
printf "echo \$((%s*\${m%s:-0}));%.0s%.0s\n" \
       $(for i in $in; do echo $i $i; done) | sh | sum
