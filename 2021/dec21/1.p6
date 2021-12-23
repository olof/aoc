#!/usr/bin/raku
my @p = $*IN.lines.map(*.comb.tail).map({ [$_-1, 0] });
my $C = 0;

-> $c, ($p, $_) {
  last when @p.map(*.tail).any >= 1000;
  $C = ($c + 1) * 3;
  @p[$p][0] = (@p[$p][0] + $_) % 10;
  @p[$p][1] += @p[$p][0] + 1
} for (^Inf).map(
  { ( $_ div 3) % 2, $_ % 100 + 1 }
).batch(3).map(
  { .head.head, .map(*.tail).sum  }
).kv;

($C * @p.map(*.tail).min).say
