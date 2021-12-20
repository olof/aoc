#!/usr/bin/raku
my @in = $*IN.lines;
my $template = @in.head;
my %transforms = @in[2..Inf].map(*.split(' -> ')).map(
  -> ($a, $b) {
    my ($aa, $ab) = $a.comb;
    $a => "$aa$b"
  }
);

my $tail = $template.substr(*-1);

for ^10 {
  $template = ($template.match(/../, :overlap).map({ %transforms{$_} }).join("") ~ $tail);
}

my %h;
%h{$_} += 1 for $template.comb;
(%h.values.max - %h.values.min).say;
