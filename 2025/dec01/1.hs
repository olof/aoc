parse ('L':n) = -(read n)
parse ('R':n) = read n
step (x:acc) n = (mod (x+n) 100):x:acc
is n = \x -> n == x

main = do
  input <- readFile "input"
  print $ length
        $ filter (is 0)
        $ foldl (step) [50]
        $ map parse
        $ words input
