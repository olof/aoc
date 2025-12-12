parse ('L':n) = -(read n)
parse ('R':n) = read n
step (s, acc) n = (s+n, (abs $ (div s 100) - (div (s + n) 100)):acc)

main = do
  input <- readFile "input"
  print $ sum
        $ snd
        $ foldl (step) (50, [])
        $ map parse
        $ words input
