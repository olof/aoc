#!/usr/bin/perl
use 5.020;
my $incr_rows = shift;
my $incr_cols = shift;
my @lines = map { chomp; [split //] } <>;

my $trees = 0;
my $col = 0;
my $row = 0;

while ($row < @lines) {
	local $_ = $lines[$row];
	++$trees if $_->[$col % int @$_] eq '#';
	$row += $incr_rows;
	$col += $incr_cols;
}

say $trees;
