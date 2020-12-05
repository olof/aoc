#!/usr/bin/perl
use 5.020;
sub bin { eval("0b$_[0]") }
my @ids = sort { $a <=> $b }
          map { bin(tr/FLBR/0011/r) } <>;
my $a = $ids[0];
for (@ids) {
	last if $_ > $a;
	++$a;
}
say $a;
