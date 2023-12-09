#!/bin/sh
sum() { n=0; while read line; do n=$((n+line)); done; echo $n; }
red=12 green=13 blue=14
while read line; do
	id=${line#Game\ } id=${id%%:*}
	echo "${line#*:}" | sed -e 's/[,;]/\n/g' | while read rec; do
		eval test "\$${rec#*\ }" -ge "\${rec%\ *}" || echo no
	done | grep -q no || echo $id
done | sum
