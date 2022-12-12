#!/usr/bin/raku
my @snake = 0i xx 10;
my $locs = (@snake.tail).SetHash;
my %moves = R => 1, L => -1, U => 1i, D => -1i;
my @moves = $*IN.lines.map({[xx] .words}).flat.map({%moves{$_}});

for @moves {
  @snake.head += $_;
  for 1..^@snake.elems {
    my $a = @snake[$_-1];
    my $b = @snake[$_];
    my $delta = $a - $b;

    if $delta.re.abs > 1 and $delta.im.abs > 0 or
       $delta.re.abs > 0 and $delta.im.abs > 1 {
      @snake[$_] += ($delta.re.sign * 1) + ($delta.im.sign * 1i);
    } elsif $delta.re.abs > 1 {
      @snake[$_] += $delta.re.sign * 1;
    } elsif $delta.im.abs > 1 {
      @snake[$_] += $delta.im.sign * 1i;
    }
  }

  $locs.set(@snake.tail);
}

say $locs.elems;
