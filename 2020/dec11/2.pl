#!/usr/bin/perl
use 5.020;
use List::Util qw(sum);
my $linewidth = 0;
my @cells = map { {'#' => -1, '.' => 0, 'L' => 1}->{$_} }
            map { chomp; $linewidth ||= length; split // }
	    <>;
my $rows = @cells / $linewidth;
sub check {
	my ($r, $c, $f) = @_;
	while (
		($r, $c) = $f->($r, $c) and
		$r >= 0 and $c >= 0 and $r < $rows and $c < $linewidth
	) {
		my $cell = $cells[$r * $linewidth + $c];
		return $cell < 0 if $cell;
	}
	0;
}

my @funcs = (
	sub { $_[0] - 1, $_[1] - 1 }, sub { $_[0] + 1, $_[1] + 1 },
	sub { $_[0] - 1, $_[1] + 0 }, sub { $_[0] + 1, $_[1] - 1 },
	sub { $_[0] - 1, $_[1] + 1 }, sub { $_[0] + 0, $_[1] - 1 },
	sub { $_[0] + 1, $_[1] + 0 }, sub { $_[0] + 0, $_[1] + 1 },
);

sub neighbors { sum map { check(@_, $_) } @funcs }

my @flips = 1;
while (@flips) {
	undef @flips;
	for my $idx (keys @cells) {
		my $row = int($idx / $linewidth);
		my $col = $idx % $linewidth;
		my $seat = $cells[$idx] or next;
		my $n = neighbors($row, $col);
		push @flips, $idx if $seat > 0 and not $n or
				     $seat < 0 and $n >= 5
	}
	$cells[$_] = -$cells[$_] for @flips;
}

say int grep { $_ < 0 } @cells;
