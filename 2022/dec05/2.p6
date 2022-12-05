#!/usr/bin/raku
sub pick($_, $c) {
  S/^^ [ "[" . "] " | "    " ] ** {$c-1} <( \[ $<id>=. \] )>/   /, $<id>;
}

sub put($towers, $id, $c) {
  $_ = ((" " x $towers.lines.head.chars ~ "\n") ~ $towers);
  s/.* ^^ [ "[" . "] " | "    " ] ** {$c-1} <("   ")>/\[$id\]/;
  S/^ " "+ \n //;
}

sub move($t1, $count, $from, $to) {
  # pick, push, pop and put
  my $t = $t1;
  my @stack;
  for 1..$count {
    ($t, my $id) = pick($t, $from);
    @stack.push($id);
  }
  $t = put($t, @stack.pop, $to) for 1..$count;
  $t;
}

sub run($towers, $_) {
  m:s/^move (<[0..9]>+) from (<[0..9]>+) to (<[0..9]>+)$/;
  move($towers, $0, $1, $2);
}

my ($towers, $moves) = $*IN.split("\n\n");
$towers = run($towers, $_) for $moves.lines;
(1..$towers.lines.tail.words.tail).map({ pick($towers, $_).tail }).join("").say
