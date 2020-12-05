#!/usr/bin/perl
use 5.020;
sub bin { eval("0b$_[0]") }
my @ids = sort { $b <=> $a }
          map { bin(tr/FLBR/0011/r) } <>;
say $ids[0];
