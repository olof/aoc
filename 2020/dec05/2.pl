#!/usr/bin/perl
use 5.020;
sub bin { eval("0b$_[0]") }
my @ids = sort { $a <=> $b } map {
	bin($_->[0] =~ tr/FB/01/r) * 8 + bin($_->[1] =~ tr/LR/01/r)
} map { [/([FB]+)([LR]+)/] } <>;
my $a = $ids[0];
for (@ids) {
	last if $_ > $a;
	++$a;
}
say $a;
