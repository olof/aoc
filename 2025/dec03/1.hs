proc m1 m2 [x]    | x >  m2   = [m1, x]
                  | otherwise = [m1, m2]
proc m1 m2 (x:xs) | x >  m1   = proc x '0' xs
                  | x >  m2   = proc m1 x xs
                  | x <= m2   = proc m1 m2 xs

main = do
  input <- readFile "input"
  print $ sum
        $ map (read :: String -> Integer)
        $ map (proc '0' '0')
        $ lines input
