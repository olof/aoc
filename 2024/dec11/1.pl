#!/usr/bin/perl
use 5.020;
my $target = shift() // 25;

sub f {
	local $_ = shift;
	return 1 unless $_;
	return $_ * 2024 if 1 & length;
	(
	  substr($_, 0, 0.5*length),
	  substr($_, 0.5*length) =~ s/^0*([1-9][0-9]*|0)$/$1/r
	)
}

sub rec {
	my $it = shift;
	return @_ unless $it;
	return f(@_) unless $it > 1;
	return map { rec($it-1, $_) } f(@_);
}

say int map { rec($target, $_) } <> =~ /(\d+)/g;
