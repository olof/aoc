#!/usr/bin/raku
my %len-maps =
  2 => 1,
  3 => 7,
  4 => 4,
  5 => 2 | 3 | 5,
  6 => 0 | 6 | 9,
  7 => 8,
;

sub f ($v) {
  my %reg;
  my ($in, $out) = $v.split(' | ', :skip-empty).map(
    *.words.map(*.split("", :skip-empty).sort.list).list
  );
  for (|$in, |$out).map({ ($_, %len-maps{$_.elems}) }) -> ($k, $_) {
    %reg{ .tail.^name ne 'Junction' }{$k.join(' ')} = $_;
  }

  my %sigkey = %reg{True}.invert;
  sub sig ($n) { set %sigkey{$n}.words }

  for %reg{False}.keys.grep({ .words.elems == 5 }) {
    %reg{True}{$_} = (sig(1) ⊂ .words)
                     ??  3
                     !! ((sig(4) ∩ .words).elems == 3)
		        ?? 5
			!! 2
  }

  %sigkey = %reg{True}.invert;

  for %reg{False}.keys.grep({ .words.elems == 6 }) {
    %reg{True}{$_} = (sig(1) ⊂ .words)
                     ?? (sig(5) ⊂ .words)
		        ?? 9
			!! 0
                     !! 6;
  }

  $out.map(-> @_ { %reg{True}{@_.join(" ")} // '?' }).join().Int
}

$*IN.lines.map(&f).sum.say;

#`{
use Test;

sub t ($in, $out) {
  is f($in), $out, "f($in) is $out"
}

t "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf", 5353;
t "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe", 8394;
t "edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc", 9781;
t "fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg", 1197;
t "fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb", 9361;
t "aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea", 4873;
t "fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb", 8418;
t "dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe", 4548;
t "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef", 1625;
t "egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb", 8717;
t "gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce", 4315;
t "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cagedb cagedb cagedb cagedb", 0;

done-testing;
#}
