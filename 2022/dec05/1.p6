#!/usr/bin/raku
sub pick($_, $c) {
  S/^^ [ "[" . "] " | "    " ] ** {$c-1} <( \[ $<id>=. \] )>/   /, $<id>;
}

sub put($towers, $id, $c) {
  $_ = ((" " x $towers.lines.head.chars ~ "\n") ~ $towers);
  s/.* ^^ [ "[" . "] " | "    " ] ** {$c-1} <("   ")>/\[$id\]/;
  S/^ " "+ \n //;
}

sub move($t1, $from, $to) {
  put(|pick($t1, $from), $to);
}

sub run($towers, $_) {
  m:s/^move (<[0..9]>+) from (<[0..9]>+) to (<[0..9]>+)$/;
  my $t = $towers;
  $t = move($t, $1, $2) for 1 .. $0;
  $t;
}

my ($towers, $moves) = $*IN.split("\n\n");
$towers = run($towers, $_) for $moves.lines;
(1..$towers.lines.tail.words.tail).map({ pick($towers, $_).tail }).join("").say
