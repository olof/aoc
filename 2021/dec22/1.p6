#!/usr/bin/raku
my %op = on =>  -> $a, $b { $a ∪ $b },
         off => -> $a, $b { $a (-) $b };
sub d($r) { set ([X,] $r).map(*.join(",")) }

(
  (),
  |$*IN.lines.map(*.words).map(
    -> ($op, $ranges) { $op, $ranges.split(',').map(*.split('=')) }
  ).map(
    -> ($op, @ranges) {
      $op, d @ranges.map(-> ($name, $range) {
        $name, ($range).EVAL
      }).sort.map(*.tail).grep({ -50 <= .all <= 50 })
    }
  )
).reduce(
  -> $state, ($op, $change) { %op{$op}.($state, $change) }
).list.elems.say
