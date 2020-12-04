#!/usr/bin/perl
use 5.020;
my %mand = (
	byr => qr/^(?:19[2-9][0-9]|200[0-2])$/,
	iyr => qr/^(?:201[0-9]|2020)$/,
	eyr => qr/^(?:202[0-9]|2030)$/,
	hgt => qr/^(?:(?:1(?:[5-8][0-9]|9[0-3]))cm|(?:59|6[0-9]|7[0-6])in)$/,
	hcl => qr/^#[0-9a-fA-F]{6}$/,
	ecl => qr/^(?:amb|blu|brn|gry|grn|hzl|oth)$/,
	pid => qr/^[0-9]{9}$/,
);
sub valid {
	my %args = %{shift()};
	for (keys %mand) {
		return if not exists $args{$_} or $args{$_} !~ /$mand{$_}/;
	}
	return 1;
}
say int grep { valid($_) }
        map { { map { split /:/ } split /\s+/ } }
	do { local $/="\n\n"; <> };
