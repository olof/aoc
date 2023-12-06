#!/bin/sh
echo $(( `(
  sed -nre 's/^[^0-9]*([0-9]).*/\10/p' $1
  sed -nre 's/^.*([0-9])[^0-9]*/\1/p' $1
) | paste -s -d+` ))
