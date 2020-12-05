#!/usr/bin/perl
use 5.020;
sub bin { eval("0b$_[0]") }
my @ids = sort { $b <=> $a } map {
	bin($_->[0] =~ tr/FB/01/r) * 8 + bin($_->[1] =~ tr/LR/01/r)
} map { [/([FB]+)([LR]+)/] } <>;
say $ids[0];
