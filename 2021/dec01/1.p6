#!/usr/bin/raku
(
  reduce -> ($prev, $c), $i { $i, $c + Int($i > $prev) },
            <0 -1>, |"input".IO.lines
).tail.say
