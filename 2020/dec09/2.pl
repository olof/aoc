#!/usr/bin/perl
use 5.020;
my $w = 25;
my @ints = map { int } <>;

my ($n, %sums) = 0;
while (++$n < @ints) {
	my $i = $n < $w ? 0 : $n - $w;
	$sums{$ints[$n]}->{$ints[$i++] + $ints[$n]} = 1 while $i < $n;
}

my @preamble = @ints[0..($w-1)];
my ($invalid) = grep {
	my $n = $_;
	my $res = not grep { exists $sums{$_}->{$n} } @preamble;
	shift @preamble;
	push @preamble, $n;
	$res;
} @ints[$w..$#ints];

my ($p, $s, @s) = -1;
do {
	($s, @s) = 0;
	do {
		$s += $ints[$_];
		push @s, $ints[$_];
		last if $s >= $invalid;
	} for $p..@ints;
} while ++$p < @ints and $s != $invalid;

my ($min, $max);
do {
	$max = ($max//$_) <= $_ ? $_ : $max;
	$min = ($min//$_) >= $_ ? $_ : $min;
} for @s;

say $max+$min;
