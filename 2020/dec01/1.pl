#!/usr/bin/perl
use 5.020;
my @ints = map { int } <>;
while (my $a = shift @ints) {
	for (@ints) {
		next if $a + $_ - 2020;
		say $a*$_;
		exit 0;
	}
}
exit 1;
