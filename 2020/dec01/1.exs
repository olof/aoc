#!/usr/bin/elixir
import Enum, only: [map: 2, filter: 2]
import String, only: [split: 3, to_integer: 1]

ints = File.read("input")
|> fn {:ok, x} -> x end.()
|> split("\n", trim: true)
|> map(&to_integer/1)

d = for n <- ints,
  do: filter(ints, fn x -> x + n == 2020 end)
      |> map(fn x -> x*n end)

[res, res] = d
|> filter(fn v -> length(v) == 1 end)
|> map(fn [x] -> x end)

IO.inspect(res)
