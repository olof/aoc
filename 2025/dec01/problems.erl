-module(problems).
-export([part/1]).

parse([$L|N]) -> -list_to_integer(N);
parse([$R|N]) -> list_to_integer(N).

part(N) ->
  {ok, BIn} = file:read_file("input.sample"),
  part(N, lists:map(
    fun(X) -> parse(X) end,
    lists:filter(
      fun(X) -> X =/= [] end,
      string:split(binary_to_list(BIn), "\n", all)
    )
  )).

part(1, Input) ->
  length(lists:filter(
    fun (X) -> X =:= 0 end,
    lists:foldl(
      fun (Op, Xs = [Cur|_]) ->
        [(Op + Cur) rem 100 | Xs]
      end,
      [50],
      Input
    )
  )).
