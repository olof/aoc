#!/usr/bin/perl
use 5.020;
my @instr = map { [split] } <>;
my $state = 0;
my $pc = 0;
my %tbl = (
	'acc' => sub { $state += shift },
	'jmp' => sub { $pc += shift() - 1 },
	'nop' => sub { }
);

my %seen;

while ($pc < @instr) {
	my ($op, $arg) = @{$instr[$pc]};
	$seen{$pc} = 1;
	$tbl{$op}->($arg);
	last if $seen{++$pc};
}

say $state;
