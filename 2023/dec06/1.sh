#!/bin/sh
. utils.sh
start=0

read times
read dists

times=${times#Time: }
dists=${dists#Distance: }

for race in $(zip "$times" "$dists"); do
	t=${race%:*} d=${race#*:} n=1

	while [ $n -lt $t ]; do
		res=$(( ($t-$n) * $n ))
		[ $res -le $d ] || echo $n
		n=$((n+1))
	done | wc -l
done | mul
