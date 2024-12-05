LANGUAGE=perl
SCRIPT=perl 1.pl <$(INPUT) | grep -o XMAS | wc -l
