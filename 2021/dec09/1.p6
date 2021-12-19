#!/usr/bin/raku
my @in = $*IN.lines.map(*.split('', :skip-empty).list);
my $rows = @in.elems;
my $cols = @in[0].elems;
my @cells = @in.map({ |$_ });

sub value(($row, $col)) { @in[$row][$col] }
sub is-lowpoint($row, $col) {
  my $v = value(($row, $col));
  ([
                      ($row-1, $col),
    ($row  , $col-1),                 ($row,   $col+1),
                      ($row+1, $col),
  ].map(&value).grep(&defined).all > $v).Bool;
}

my $res = 0;
for @in.kv -> $line, $row {
  for $row.kv -> $col, $v {
    $res += is-lowpoint($line, $col) ?? $v + 1 !! 0;
  }
}

$res.say;
