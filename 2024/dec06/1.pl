#!/usr/bin/perl
use 5.020;
use Data::Dumper;

$_ = do { $/ = undef; <> };
my $width = length s/\n.*//sr;
my $ofs = $width - 1;
s/\s//g;
my $seen = {$_ => 1};
my $dir = 'k';

my %done = (
	h => qr/^\^/m,
	j => qr/(?<=\^).{0,$width}$/,
	k => qr/^.{0,$width}(?=\^)/,
	l => qr/\^$/m,
);
my %blocked = (
	h => qr/#\^/,
	j => qr/(?=\^).{$width}#/,
	k => qr/(?=#).{$width}\^/,
	l => qr/\^#/,
);
my %actions = (
	h => sub { shift =~ s/\.\^/^./r },
	j => sub { shift =~ s/\^(.{$ofs})\./.$1^/r },
	k => sub { shift =~ s/\.(.{$ofs})\^/^$1./r },
	l => sub { shift =~ s/\^\./.^/r },
);
my %rotate = qw(h k
                j h
                k l
                l j);

($seen, $dir, $_) = sub {
	my $seen = { %{shift()} };
	my $dir = shift;
	local $_ = shift;
	if (/$blocked{$dir}/) {
		$dir = $rotate{$dir};
	} else {
		$_ = $actions{$dir}->($_);
	}
	return {%$seen, $_ => 1}, $dir, $_;
}->($seen, $dir, $_) while not /$done{$dir}/;

say int keys %$seen;
