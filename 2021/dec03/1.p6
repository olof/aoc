#!/usr/bin/raku
my $str = join "", map -> $_ { (.sum >= 0).Int },
    [Z] map -> $_ {
      .split("", :skip-empty).map(-> $x { $x*2-1 })
    },
  $*IN.lines;
my $γ = :2($str);
my $ε = :2(TR/10/01/ with $str);
say $γ * $ε;
