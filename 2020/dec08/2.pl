#!/usr/bin/perl
use 5.020;
my $instr = [map { [split] } <>];
my $state = 0;
my $pc = 0;
my %tbl = (
	'acc' => sub { $state += shift },
	'jmp' => sub { $pc += shift() - 1 },
	'nop' => sub { }
);

my %seen;
my @hist;
my $changed = 0;

while ($pc < @$instr) {
	my ($op, $arg) = @{$instr->[$pc]};
	push @hist, [$pc, $state, $op, [@$instr]]
		if not $changed and ($op eq 'jmp' or $op eq 'nop');
	$seen{$pc} = $pc;
	$tbl{$op}->($arg);
	++$pc;
	next unless $seen{$pc};

	$changed = 1;
	($pc, $state, $op, $instr) = @{pop @hist};
	$op = $op eq 'jmp' ? 'nop' : 'jmp';
	$instr->[$pc]->[0] = $op;
}

say $state;
