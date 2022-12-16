#!/usr/bin/raku
my %monkeys = ($*IN.slurp ~~ m:g/
  "Monkey " $<id>=\d+ ":" \n
  "  Starting items: " $<items>=( [ \d+ ", " ]* \d+ ) \n
  "  Operation: new = old " $<op>=. " " $<operand>=\S+ \n
  "  Test: divisible by " $<divisor>=\d+ \n
  "    If true: throw to monkey " $<true>=\d+ \n
  "    If false: throw to monkey " $<false>=\d+ \n
/).map(-> $/ {
  $/<id> => %{
    items => $/<items>.split(', ').Array,
    op => $/<op> eq '*' ?? (&infix:<*>) !! (&infix:<+>),
    hits => 0,
    $/<operand divisor true false>:kv,
  };
});

for |%monkeys.keys.sort xx 20 -> $id {
  my %m = %monkeys{$id};
  my @items = %m{'items'}.flat;
  my $operand = %m<operand>;
  %monkeys{$id}{'hits'} += @items.elems;
  %monkeys{$id}{'items'} = [];
  for @items -> $worry {
    my $nv = %m<op>.($worry, $operand eq 'old' ?? $worry !! $operand) div 3;
    %monkeys{$nv % %m<divisor> ?? %m<false> !! %m<true>}<items>.append($nv);
  }
}

%monkeys.values.map(*<hits>).sort.reverse[0..1].reduce(&infix:<*>).say;
