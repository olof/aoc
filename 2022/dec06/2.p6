#!/usr/bin/raku
$*IN.lines.map({
  (14 + .ords.rotor(14 => -13).map({.Set}).first({.elems == 14}, :k)).say
})
