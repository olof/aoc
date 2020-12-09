#!/usr/bin/perl
use 5.020;
my $w = 25;

sub cycle { my $b = shift; shift @$b; push @$b, @_; $b }

my @ints = map { int } <>;
my %sums;
my $n = 0;
while (++$n < @ints) {
	my $i = $n < $w ? 0 : $n - $w;
	$sums{$ints[$n]}->{$ints[$i++] + $ints[$n]} = 1 while $i < $n;
}

my @preamble = splice @ints, 0, $w;

$, = ", ";
say grep {
	my $n = $_;
	my $res = not grep { exists $sums{$_}->{$n} } @preamble;
	cycle \@preamble, $n;
	$res;
} @ints;
