#!/usr/bin/perl
use 5.020;
($/, $") = ("", ",");
my %R = <> =~ /^Register ([A-Z]+): ([0-9]+)$/gm, PC => 0;
my @P = map { int } <> =~ /([0-9]+)/g;
my @out;

sub literal { $P[$R{PC}+1] }
sub instruction { $P[$R{PC}] }
sub combo {
	my $n = literal;
	$n < 4 ? $n : $R{chr($n + ord "=")}
}

my %IS = (
	1 => sub { $R{B} ^= literal },
	2 => sub { $R{B} = combo() % 8 },
	3 => sub { $R{PC} = $R{A} ? -2 + literal : $R{PC} },
	4 => sub { $R{B} = int $R{B} ^ int $R{C} },
	5 => sub { push @out, combo() % 8 },
	0 => sub { $R{A} = int $R{A} / 2**combo },
	6 => sub { $R{B} = int $R{A} / 2**combo },
	7 => sub { $R{C} = int $R{A} / 2**combo },
);

sub step {
	$IS{instruction()}->();
	$R{PC} += 2
}

step while $R{PC} < @P;

say "@out";
