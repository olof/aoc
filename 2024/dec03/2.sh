#!/bin/sh
{ printf 'do()'; paste -s -d '฿'; } |
	sed -re "s/don't\(\)/\n/g" |
	perl -pe 's/^.*?do\(\)// or $_ = ""' |
	grep -Po 'mul\(\K[[0-9]{1,3},[0-9]{1,3}(?=\))' |
		tr , '*' | {
			n=0
			while read line; do n=$((n+$line)); done
			echo $n
		}
