#!/usr/bin/perl
use 5.020;
use List::Util qw(sum);
$/ = "";
$_ = <>;
my $w = length s/\n.*//sr;
s/\n//g;
my $ofs = $w - 1;
my @cmds = <> =~ /(\S)/g;

for my $cmd (@cmds) {
	({
		'>' => sub { s/\@(O*)\./.\@$1/ },
		'<' => sub { s/\.(O*)@/$1@./ },
		'^' => sub {
			s/\.(.{$ofs})((?:O.{$ofs})*)O(.{$ofs})\@/O$1$2\@$3./ or
			s/\.(.{$ofs})\@/\@$1./
		},
		'v' => sub {
			s/\@(.{$ofs})O(.{$ofs})((?:O.{$ofs})*)\./.$1\@$2$3O/ or
			s/\@(.{$ofs})\./.$1\@/
		},
	}->{$cmd} // sub {})->();
}

my ($sum, $y) = (0, 0);
for my $row (unpack "(a$w)*") {
	my @chars = unpack "(a)*", $row;
	$sum += sum map { $vy + $_ } grep { $chars[$_] eq 'O' } keys @chars;
	$vy += 100;
}
say $sum;
