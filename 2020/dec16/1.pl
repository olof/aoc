#!/usr/bin/perl
use 5.020;
use List::Util qw(sum);
local $/ = "\n\n";

my %rules = map { my ($k, @v) = @$_;
	          $k => sub { $_[0] >= $v[0] and $_[0] <= $v[1] or
		              $_[0] >= $v[2] and $_[0] <= $v[3] }
} map { [/([^:]+):\s*([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$/] }
  split /\n/, scalar <>;
my @my = map { split /,/ } scalar(<>) =~ /^your ticket:\n(.*)\n*$/;
my @near = map { [split/,/] } map { split/\n/ }
	   scalar(<>) =~ /^nearby tickets:\n(.*)\n*$/s;

say sum grep { my $v = $_; not grep { $_->($v) } values %rules }
        map { @$_ } @near;
