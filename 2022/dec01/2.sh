#!/bin/sh
perl -MList::Util=sum -nE 'BEGIN { $/ = "\n\n"; $, = " " } say sum(split), $.' |
	sort -n |
	tail -n 3 |
	cut -f1 -d ' ' | { n=0; while read line; do n=$((n+$line)); done; echo $n; }
