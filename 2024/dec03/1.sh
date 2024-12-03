#!/bin/sh
n=0
grep -Po 'mul\(\K[[0-9]{1,3},[0-9]{1,3}(?=\))' |
	tr , '*' | {
		while read line; do n=$((n+$line)); done
		echo $n
	}
