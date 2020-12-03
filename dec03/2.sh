#!/bin/sh
echo $(( `printf '%s*' $(
	for args in '1 3' '1 1' '1 5' '1 7' '2 1'; do
		perl 1.pl <input $args;
	done
); echo 1` ))
