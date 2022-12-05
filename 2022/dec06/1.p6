#!/usr/bin/raku
$*IN.lines.map({
  (4 + .ords.rotor(4 => -3).map({.say;.Set}).first({.elems == 4}, :k)).say
})
