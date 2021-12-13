#!/usr/bin/raku
my %ridges;

%ridges{$_.join("x")} += 1 for $*IN.lines.map({
  my @x = ([Z] .split(' -> ').map(*.split(',').map(*.Int))).map({ [...] $_ });
  my %s is Set = @x.map(*.elems);
  | ((1 ⊂ %s or %s.elems == 1) ?? [<<,>>] @x !! []);
  #     ^ wide character!        # ^^ ^^   not wide :(
  # (...  and they say i don't comment my code  ...)
});

%ridges.values.grep({$_ > 1}).elems.say;
