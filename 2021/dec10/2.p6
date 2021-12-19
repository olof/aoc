#!/usr/bin/raku
my %score-map = ")" => 1,
                "]" => 2,
                "}" => 3,
                ">" => 4;
my %rotate = '(' => ')',
             '[' => ']',
             '{' => '}',
             '<' => '>',
             'd' => 'b',
             'q' => 'p';

grammar Chunks {
  token TOP     { [ <chunk>* <partial>? ] }
  token chunk   { [ <a> | <b> | <c> | <d> ] }
  token a       { [ \{ <chunk>* \} ] }
  token b       { [ \[ <chunk>* \] ] }
  token c       { [ \< <chunk>* \> ] }
  token d       { [ \( <chunk>* \) ] }
  token partial { [ (\{ | \[ | \( | \<) <chunk>* <partial>? ] }
}

my @partials = $*IN.lines.map({
  Chunks.parse($_)<partial>
}).grep({ $_ });

sub tree-dive ($node) {
  $node<partial>:exists
    ?? tree-dive($node<partial>) ~ %rotate{$node[0]}
    !! %rotate{$node[0]}
}

multi sub score ([], $score=0) { $score }
multi sub score (($head, *@tail), $score=0) {
  samewith(@tail, $score * 5 + %score-map{$head})
}

$_[$_.elems div 2].say with
  @partials.map(&tree-dive).map(
    *.split("", :skip-empty).list
  ).map({ $_ }).map(&score).sort;
