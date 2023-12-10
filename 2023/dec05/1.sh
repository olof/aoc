#!/bin/sh
. utils.sh
TAB2="$TAB$TAB"
fun_end="${TAB}echo \$1$NL}$NL"
{
	while read line; do
		case $line in
			seeds:\ *) seeds=${line#seeds: } ;;
			*\ map:) map=$(echo ${line% map:} | sed -re 's/-/_/g')
				 fun="$map() {$NL" ;;
			[0-9]*)
				to=${line%% *}
				len=${line##* }
				from=${line#* }
				from=${from% *}
				target=$((from+len))

				fun="$fun$TAB[ \"\$1\" -ge $from ] &&$NL"
				fun="$fun$TAB[ \"\$1\" -lt $target ] &&$NL"
				fun="$fun${TAB2}echo \$((\$1-$from+$to)) &&"
				fun="$fun return 0$NL" ;;
			'')
				[ -z "$fun" ] || echo "$fun$fun_end"
				map= fun= ;;
		esac

	done
	[ -z "$fun" ] || echo "$fun$fun_end"
	for seed in $seeds; do
		printf 'echo %s)))))))\n' "$(printf '$(%s ' \
			humidity_to_location \
			temperature_to_humidity \
			light_to_temperature \
			water_to_light \
			fertilizer_to_water \
			soil_to_fertilizer \
			'seed_to_soil '$seed
		)"
	done
} | sh | sort -n | head -1
