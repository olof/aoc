#!/usr/bin/elixir
import Enum, only: [map: 2, filter: 2, uniq: 1]
import List, only: [flatten: 1, first: 1]
import String, only: [split: 3, to_integer: 1]

ints = File.read("input")
|> fn {:ok, x} -> x end.()
|> split("\n", trim: true)
|> map(&to_integer/1)

for n <- ints do
  filter(ints, fn x -> x + n < 2020 end)
  |> map(fn x -> {x+n - 2020, x*n} end)
  |> map(fn {s, p} -> ints
    |> filter(fn x -> s + x == 0 end)
    |> map(fn x -> p * x end)
  end)
end |> flatten |> uniq |> first |> IO.inspect
