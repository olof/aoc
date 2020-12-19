#!/usr/bin/perl
use 5.020;
my (%atoms, %rules, @input);

while (<>) {
	chomp;
	$atoms{$1} = $2 if /^([^:]+): "([^"]+)"$/;
	$rules{$1} = $2 if /^([^:]+): ((?:\d+\s*)+(?:\|\s*(?:\d+\s*)+)*)$/;
	push @input, $1 if /^([^:\s]+)$/;
}

@rules{qw(8 11)} = ('42+', '(42 (?-1)? 31)');

sub resolve {
	local $_ = shift;
	return $atoms{$_} if exists $atoms{$_};
	return resolve($rules{$_}) if exists $rules{$_};
	s/\s*((?<!\?-)\d+)\s*/resolve($1)/ge;
	qr/$_/
}

my $re = resolve(0);
say int grep { /^$re$/ } @input;
