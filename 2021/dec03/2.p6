#!/usr/bin/raku

sub f (@in, &cond, @prefix=()) {
  my @cand = @in.grep(*.starts-with(@prefix));
  return @cand.head if @cand == 1;
  given ([Z] |@cand.map(*.head(@prefix + 1).tail)).head
        .map(-> $_ { $_ * 2 - 1 }).sum {
    f(@cand, &cond, (|@prefix, $_.abs == @in.head
      ?? ($_> 0).Int
      !! &cond($_).Int
    ))
  }
}

say [*] :2(f($_, -> $_ { $_ >= 0 }).join("")),
        :2(f($_, -> $_ { $_ <  0 }).join(""))
  given $*IN.lines.map(*.split("", :skip-empty)).list;
