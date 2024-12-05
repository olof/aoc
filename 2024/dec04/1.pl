#!/usr/bin/perl
use 5.020;
sub parse { map { [grep { /[A-Z0-9_.]/i } split //] } @_ }

sub render {
	# by rendering with " " instead of \n, we can use | sort | uniq
	# to see if multiple transformations lead to the same state.
	map { print @$_, " "; } @_;
	print "\n";
}

sub rotate {
	my $c = shift;
	return @_ if $c == 0;
	rotate($c-1, map { my $i = $_;
                           [reverse map {$_[$_]->[$i]} 0..$#_] } 0..$#{$_[0]});
}

sub offset {
	my @items = @_;
	map { [('_') x $_, @{$items[$_]}, ('_') x ($#items - $_)] } keys @items;
}

my @in =  parse(<>);
map { render($_->(@in)) }
	sub { @_ },
	sub { rotate(1, @_) },
	sub { rotate(2, @_) },
	sub { rotate(3, @_) },
	sub { rotate(1, offset(@_)) },
	sub { rotate(3, offset(@_)) },
	sub { rotate(1, offset(rotate(1, @_))) },
	sub { rotate(3, offset(rotate(1, @_))) }
