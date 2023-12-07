#!/bin/sh

digitize() {
  echo "$1" | sed -r \
    -e 's/(one|two|three|four|five|six|seven|eight|nine)/[\1]/g' \
    -e s/one/1/g -e s/two/2/g -e s/three/3/g \
    -e s/four/4/g -e s/five/5/g -e s/six/6/g \
    -e s/seven/7/g -e s/eight/8/g -e s/nine/9/g
}

rdigitize() {
  echo "$1" | rev | sed -r \
    -e 's/(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno)/[\1]/g' \
    -e s/eno/1/g -e s/owt/2/g -e s/eerht/3/g \
    -e s/ruof/4/g -e s/evif/5/g -e s/xis/6/g \
    -e s/neves/7/g -e s/thgie/8/g -e s/enin/9/g
}

echo $(( `while read line; do
  printf "+%s%s\n" \
    $(digitize "$line" | sed -re 's/^[^1-9]*([1-9]).*/\1/') \
    $(rdigitize "$line" | sed -re 's/^[^1-9]*([1-9]).*/\1/')
done` ))
