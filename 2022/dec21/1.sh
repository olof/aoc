#!/bin/sh
tmpd=$(mktemp -d /tmp/aoc-dec21-XXXXXX)
trap 'rm -rf "$tmpd"' EXIT
while read target recipe; do
	t=${target%:}
	case $recipe in
		????\ [+/*-]\ ????)
			d1=${recipe%% *}
			d2=${recipe##* }
			op=${recipe#* }
			op=${op% *}
			printf '%s: %s %s\n\techo $$(( $$( sed 1a%s $^ ) )) > $@\n\n' \
				"$t" "$d1" "$d2" "$op"
			;;
		[0-9]|[0-9][0-9]|[0-9][0-9][0-9])
			printf "$t:\n\techo $recipe > $t\n\n"
			;;
	esac
done | make -C$tmpd -f- root && cat $tmpd/root
