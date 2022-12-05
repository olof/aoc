#!/bin/sh
# safest to parse shell output with shell
# ... obviously...
cwd=/
while read line; do
	case $line in
		'$ cd '*)
			reldir=${line#'$ cd '}
			reldir=${reldir%/}
			reldir=${reldir:-/}

			case $reldir in
				/*) cwd=${reldir%/} ;;
				..) cwd=${cwd%/*} ;;
				*) cwd=${cwd%/}/$reldir ;;
			esac
			;;
		[0-9]*)
			size=${line%% *}
			relfile=${line#* }
			absfile=$cwd/$relfile

			echo "$size $absfile"
	esac
done | perl -n -e 'print while s/ (\/.*)\/.+$/ $1/;' |
       sort -rk 2 |
       uniq -f 1 --group=append |
       cut -f 1 -d ' ' |
       {
       	sum=0
       	while read line; do
       		case $line in
       			"") [ $sum -gt 100000 ] || echo $sum; sum=0 ;;
       			*) sum=$((sum+line)) ;;
       		esac
       	done
       } |
       perl -MList::Util=sum -E 'say sum <>'
