#!/usr/bin/perl
use 5.020;
use threads;
use List::Util qw(sum none any uniq);

$_ = do { $/ = undef; <> };
my $width = length s/\n.*//sr;
my $ofs = $width - 1;
s/\^/G/;
s/\s//g;
my $dir = 'k';

my %rotate = qw(h k
                j h
                k l
                l j);

my %done = (
	h => qr/^(?:.{$width})*G/,
	j => qr/(?<=G).{0,$width}$/,
	k => qr/^.{0,$width}(?=G)/,
	l => qr/G(?:.{$width})*$/,
);
my %blocked = (
	h => qr/#G/,
	j => qr/G.{$ofs}#/,
	k => qr/#.{$ofs}G/,
	l => qr/G#/,
);
my %actions = (
	h => sub { shift =~ s/\.G/G./r },
	j => sub { shift =~ s/G(.{$ofs})\./.$1G/r },
	k => sub { shift =~ s/\.(.{$ofs})G/G$1./r },
	l => sub { shift =~ s/G\./.G/r },
);
my %gen_done = (
	h => qr/^(?:.{$width})*O/,
	j => qr/O.{0,$ofs}$/,
	k => qr/^.{0,$ofs}O/,
	l => qr/O(?:.{$width})*$/,
);
my %gen_blocked = (
	h => qr/#O/,
	j => qr/O.{$ofs}#/,
	k => qr/#.{$ofs}O/,
	l => qr/O#/,
);
my %gen_actions = (
	h => sub { shift =~ s/\.(G)?O/O$1./r },
	j => sub { shift =~ s/O(.{$ofs})(G.{$ofs})?\./.$1$2O/r },
	k => sub { shift =~ s/\.(.{$ofs})(G.{$ofs})?O/O$1$2./r },
	l => sub { shift =~ s/O(G)?\./.$1O/r },
);

sub gen {
	my $dir = shift;
	local $_ = shift;

	return if /$gen_done{$dir}/;

	$dir = $rotate{$dir} if /$gen_blocked{$dir}/;
	$_ = $gen_actions{$dir}->($_);
	$_, gen($dir, $_);
}

sub f {
	my $states = shift;
	my $dir = shift;
	local $_ = shift;

	$states->{"$dir$_"} = 1;
	$_ = $actions{$dir}->($_) until /$blocked{$dir}/ or /$done{$dir}/;
	return 0 if /$done{$dir}/;
	$dir = $rotate{$dir} if /$blocked{$dir}/;
	return 1 if $states->{"$dir$_"};

	@_ = ($states, $dir, $_);
	goto &f;
}

s/\.(.{$ofs})G/O$1G/;
say int grep { f({}, 'k', s/O/#/r) } uniq $_, gen($dir, $_);
