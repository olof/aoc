#!/usr/bin/perl
use 5.020;
$/="\n\n";
my ($a, $b) = map { [/^(\d+)/gm] } <>;

while (@$a and @$b) {
	my ($va, $vb) = (shift(@$a), shift(@$b));
	my ($w, @p) = $va > $vb ? ($a, $va, $vb) : ($b, $vb, $va);
	push @$w, @p
}

my ($s, $m);
$s += $_ * ++$m for reverse(@$a ? @$a : @$b);
say $s;
