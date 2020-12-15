#!/usr/bin/perl
use 5.020;
my $lim = shift // 2020;
my @init = <> =~ /(\d+)/g;
my %mem = map { $init[$_-1] => $_ } 1..$#init;
my ($n, $s) = ($#init, $init[$#init]);
($s, $mem{$s}) = ($mem{$s} ? $n - $mem{$s} : 0, $n) while ++$n < $lim;
say $s;
