#!/bin/sh
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
done | perl -n -e 'print while s/ (\/.*)\/.+$/ $1/; print s/ \/.+/ \//r' |
       sort -rk 2 |
       uniq -f 1 --group=append |
       {
       	sum=0
	ddir=
       	while read size dir; do
       		case $size in
       			"") echo $ddir $sum; sum=0 ;;
       			*) ddir=$dir;
			   sum=$((sum+size)) ;;
       		esac
       	done
       } | perl -MList::Util=sum,min -E '
	my %sections = map { chomp; split / /, $_ } <>;
	my $total = delete $sections{"/"};
	my $target = 70000000 - $total - 30000000;
	say min grep { abs($target) < $_ } values %sections
'
