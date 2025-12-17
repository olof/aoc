import Data.List

solve ("*", probs) = product $ map (read :: String -> Integer) probs
solve ("+", probs) = sum $ map (read :: String -> Integer) probs

main = do
  raw <- readFile "input"
  let input = map words $ lines raw
  print $ sum $ map solve $ zip (last input) (transpose $ init input)
