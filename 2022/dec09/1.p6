#!/usr/bin/raku
my ($t, $h) = 0i, 0i;
my $locs = ($h).SetHash;
my %moves = R => 1, L => -1, U => 1i, D => -1i;
my @moves = $*IN.lines.map({[xx] .words}).flat.map({%moves{$_}});

for @moves {
  $h += $_;
  my $delta = ($t - $h);

  if $delta.re.abs > 1 and $delta.im.abs > 0 or
     $delta.re.abs > 0 and $delta.im.abs > 1 {
    $t += (-1 * $delta.re.sign * 1) + (-1 * $delta.im.sign * 1i);
  } elsif $delta.re.abs > 1 {
    $t += -1 * $delta.re.sign * 1;
  } elsif $delta.im.abs > 1 {
    $t += -1 * $delta.im.sign * 1i;
  }

  $locs.set($t);
}

say $locs.keys.elems;
