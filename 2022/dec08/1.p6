#!/usr/bin/raku
my @lines = $*IN.lines.map({.split("", :skip-empty).map({.Int}).List});

my $count = 0;
for 0..^@lines.elems -> $line {
  my @line = |@lines[$line];
  for 0..^@line.elems -> $col {
    my $v = @lines[$line][$col];
    my @col = @lines>>[$col];

    my @cbefore = @line[0..^$col];
    my @cafter = @line[$col^..^@col.elems];
    my @lbefore = @col[0..^$line];
    my @lafter = @col[$line^..^@line.elems];

    $count += (any (
      @lbefore,
      @lafter,
      @cbefore,
      @cafter
    ).map({ $v > all |$_ })).Bool.Int;
  }
}

say $count;
