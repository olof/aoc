#!/usr/bin/raku
my $max = 0;
my @lines = $*IN.lines.map({.split("", :skip-empty).map({.Int}).List});

for 0..^@lines.elems -> $line {
  my @line = |@lines[$line];
  for 0..^@line.elems -> $col {
    my $v = @lines[$line][$col];
    my @col = @lines>>[$col];

    $max = max $max, [*] (
      @line[0..^$col].reverse,
      @line[$col^..^@col.elems],
      @col[0..^$line].reverse,
      @col[$line^..^@line.elems]
    ).map(-> @dir {
      my $score = 0;
      for 0..^@dir.elems {
        ++$score;
        last if @dir[$_] >= $v;
      }
      $score
    });
  }
}

say $max;
