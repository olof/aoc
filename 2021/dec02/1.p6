#!/usr/bin/raku
say [*] |reduce
  -> $state, $change { ($state Z<<+>> $change).head },
  (0, 0),
  |map -> ($_, $v) {
    when 'forward' { <<0 "$v">> }
    when 'up'      { <<"-$v" 0>> }
    when 'down'    { <<"$v" 0>> }
  },
  map -> $_ {.words}, $*IN.lines;
