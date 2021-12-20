#!/usr/bin/raku
my @in = $*IN.lines;
my @corr = @in.head.comb.map({ ($_ eq '#').Int });
my @img = @in[2..*-1].map(*.comb.map({ ($_ eq '#').Int }).list);

sub pixel-out(@in, $row, $col, $def=0) {
  @corr[pixel-key(@in, $row, $col, $def)]
}

sub pixel-key(@in, $row, $col, $def=0) { :2([
    ($row-1, $col-1), ($row-1, $col), ($row-1, $col+1),
    ($row  , $col-1), ($row,   $col), ($row,   $col+1),
    ($row+1, $col-1), ($row+1, $col), ($row+1, $col+1),
  ].map(-> ($x, $y) {
    ($x >= 0 and $y >= 0 and $x < @in.elems and $y < @in[0].elems)
      ?? @in[$x][$y]
      !! $def
  }).join(""))
}

for ^(@*ARGS[0] // 1) -> $i {
  @img = (-1 .. @img.elems).map(-> $row {
    (-1 .. @img[0].elems).map(-> $col {
      pixel-out(@img, $row, $col, $i % 2 ?? @corr[0] !! 0)
    }).Array
  })
}

@img.map(*.grep({ $_ == 1 }).elems).sum.say;
