#!/usr/bin/elixir
import Enum, only: [map: 2, reduce: 3]
import String, only: [split: 3, to_integer: 1]
import Integer, only: [mod: 2]

File.read("input")
|> fn {:ok, x} -> x end.()
|> split("\n", trim: true)
|> map(fn <<cmd::binary-size(1), arg::binary>> -> {cmd, to_integer(arg)} end)
|> reduce({0, 2}, fn
  {"F", arg}, {d, face} when face <= 1 -> {d - arg, face}
  {"F", arg}, {d, face} when face >= 2 -> {d + arg, face}
  {"R", arg}, {d, n} -> {d, mod(n+div(arg, 90), 4)}
  {"L", arg}, {d, n} -> {d, mod(n-div(arg, 90), 4)}
  {c, arg}, {d, face} when c in ["W", "N"] -> {d - arg, face}
  {c, arg}, {d, face} when c in ["E", "S"] -> {d + arg, face}
end)
|> fn {distance, _} -> abs(distance) end.()
|> IO.inspect
