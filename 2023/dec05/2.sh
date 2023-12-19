#!/bin/sh
. utils.sh
TAB2="$TAB$TAB"
fun_end="${TAB}RES=\$1$NL}$NL"
{
	while read line; do
		case $line in
			seeds:\ *)
			  seeds=$(echo ${line#seeds: } | sed -re 's/(^| )([0-9]+) ([0-9]+)/\1\2:\3/g') ;;

			*\ map:) map=$(echo ${line% map:} | sed -re 's/-/_/g')
				 fun="$map() {$NL" ;;

			[0-9]*) to=${line%% *}
				len=${line##* }
				from=${line#* }
				from=${from% *}
				target=$((from+len))

				fun="$fun$TAB[ \"\$1\" -ge $from ] &&$NL"
				fun="$fun$TAB[ \"\$1\" -lt $target ] &&$NL"
				fun="$fun${TAB2}RES=\$((\$1-$from+$to)) &&"
				fun="$fun return 0$NL" ;;

			'') [ -z "$fun" ] || echo "$fun$fun_end"
			    map= fun= ;;
		esac

	done
	[ -z "$fun" ] || echo "$fun$fun_end"
	echo $seeds >&2

	n_seeds=$(count $seeds)
	for seed in $seeds; do
		from=${seed%:*}
		count=${seed#*:}
		target=$((from+count))
		#seeds=$seeds${seeds:+ }$(perl -e '$,=" "; print ($ARGV[0] .. ($ARGV[1]-1))' $from $target)
		#seeds=$seeds${seeds:+ }$(
		#       while [ "$from" -lt $target ]; do
		#       	echo "$from"
		#       	from=$((from+1))
		#       done
		#)
		#seeds="$seeds${seeds:+ }$(seq "$from" "$target")"
		echo 'round=$((round+1))'
		printf '(echo seed range $round/%d >&2\n' $n_seeds
		echo 'printf aoc-round=%d $round >/proc/self/comm'
		printf "n=%d\n" "$from"
		printf 'while [ $n -lt %d ]; do\n' "$target"
			#echo '	printf seed=%d\  $n >&2'
			echo '	seed_to_soil $n'
			#echo '	printf -- '\''-> soil=%d '\'' $RES >&2'
			echo '	soil_to_fertilizer $RES'
			#echo '	printf -- '\''-> fertilizer=%d '\'' $RES >&2'
			echo '	fertilizer_to_water $RES'
			#echo '	printf -- '\''-> water=%d '\'' $RES >&2'
			echo '	water_to_light $RES'
			#echo '	printf -- '\''-> light=%d '\'' $RES >&2'
			echo '	light_to_temperature $RES'
			#echo '	printf -- '\''-> temperature=%d '\'' $RES >&2'
			echo '	temperature_to_humidity $RES'
			#echo '	printf -- '\''-> humidity=%d '\'' $RES >&2'
			echo '	humidity_to_location $RES'
			#echo '	printf -- '\''-> location=%d\n'\'' $RES >&2'
			echo '	echo $RES'
			echo '	n=$((n+1))'
		echo done
		echo ') &'
	done
	echo wait
} | sh | min
