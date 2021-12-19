#!/usr/bin/raku
my %score-map =
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137,
;

grammar Chunks {
  token TOP     { [ <chunk>* <partial>? ] }
  token chunk   { [ <a> | <b> | <c> | <d> ] }
  token a       { [ \{ <chunk>* \} ] }
  token b       { [ \[ <chunk>* \] ] }
  token c       { [ \< <chunk>* \> ] }
  token d       { [ \( <chunk>* \) ] }
  token partial { [ (\{ | \[ | \( | \<) <chunk>* <partial>? ] }
}

my %score;
%score{$_} += 1 for $*IN.lines.map({
  Chunks.subparse($_).postmatch.substr(0, 1)
}).grep({ $_ }).map({ %score-map{$_} });
%score.kv.map(-> $a, $b { $a * $b }).sum.say;
