#!/bin/sh
perl -MList::Util=sum -nE 'BEGIN { $/ = "\n\n"; $, = " " } say sum(split), $.' |
	sort -n |
	sed -ne '$s/ .*//p'
