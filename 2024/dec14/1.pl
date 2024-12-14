#!/usr/bin/perl
use 5.020;
use List::Util qw(product);
sub counts { my %c; ++$c{$_} for @_; values %c }
my ($x, $y) = split /x/, shift || '101x104';
my $it = shift // 100;

say product
    counts
    map { ($_->[0] > 0 || 0) * 2 + ($_->[1] > 0 || 0) }
    grep { $_->[0] and $_->[1] }
    map { [$_->[0] - int($x / 2), $_->[1] - int($y / 2)] }
    map { [($_->[0]->[0] + $it * $_->[1]->[0]) % $x,
	   ($_->[0]->[1] + $it * $_->[1]->[1]) % $y] }
    map { [map {[/([0-9-]+)/g]} split / /] }
    <>;
