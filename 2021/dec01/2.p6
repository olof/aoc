#!/usr/bin/raku
(
  reduce -> ($c, @w), $i {
    $c + (@w.sum < @w.tail(2).sum + $i), (|@w.tail(2), $i)
  },
  (-3, (0,)), |"input".IO.lines
).head.say
