#!/usr/bin/perl
use 5.020;
my @a = map { int } <>;
while (my $a = shift @a) {
	my @b = @a;
	while (my $b = shift @b) {
		next if (my $c = $a + $b - 2020) >= 0;
		for (@b) {
			next if $c + $_;
			say $a * $b * $_;
			exit 0;
		}
	}
}
exit 1;
