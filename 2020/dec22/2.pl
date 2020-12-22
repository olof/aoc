#!/usr/bin/perl
use 5.020;
$/="\n\n";
$;=",";
my ($a, $b) = map { [/^(\d+)/gm] } <>;

sub game {
	my ($a, $b) = @_;
	my %cfgs;

	while (@$a and @$b) {
		return $a if $cfgs{join " ", join(",", @$a), join(",", @$b)}++;
		my ($va, $vb, $w) = (shift(@$a), shift(@$b));

		if ($va <= @$a and $vb <= @$b) {
			my ($sa, $sb) = ([@{$a}[0..$va-1]], [@{$b}[0..$vb-1]]);
			$w = game($sa, $sb) == $sa ? $a: $b;
		} else {
			$w = $va > $vb ? $a : $b;
		}

		push @$w, $w == $a ? ($va, $vb) : ($vb, $va);
	}

	@$a ? $a : $b
}

my ($s, $m);
$s += $_ * ++$m for reverse @{game($a, $b)};
say $s;
