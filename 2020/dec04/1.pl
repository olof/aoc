#!/usr/bin/perl
use 5.020;
my @mand = qw(byr iyr eyr hgt hcl ecl pid);
sub valid {
	my %args = %{shift()};
	#>>> use List::Util qw(all);
	#>>> all { exists $args{$_} } @mand;
	#but it takes longer, including the import!
	for (@mand) {
		return if not exists $args{$_};
	}
	return 1;
}
say int grep { valid($_) }
        map { { map { split /:/ } split /\s+/ } }
	do { local $/="\n\n"; <> };
