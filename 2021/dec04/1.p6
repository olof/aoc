#!/usr/bin/raku
my @nums = $*IN.lines(1).split(",");

my @boards = $*IN.slurp
  .split("\n\n")
  .map(*.split("\n").grep({ $_ }).map(*.words.list))
  .map(-> @_ {
    my @cols = [Z] @_;
    |@_, |@cols
  });

for @nums -> $n {
  @boards = @boards.map(
    *.map(*.grep({ $_ != $n })).list
  );
  my @winner = @boards.grep(*.grep({ $_ == 0 }));
  if @winner {
    (@winner.head.map({ [+] $_ }).sum / 2 * $n).say;
    exit 0;
  }
}
