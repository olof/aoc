import Text.Regex.PCRE2 ((=~))

expand :: [String] -> [Int]
expand [a, b] = [(read a :: Int) .. (read b :: Int)]

parse :: String -> [[String]]
parse x =
  map (\(_:tail) -> tail)
      $ x =~ "([0-9]+)-([0-9]+)" :: [[String]]

invalid_id :: Int -> Bool
invalid_id n = (show n) =~ "^([0-9]+)\\1$" :: Bool

main = do
  input <- readFile "input"
  print $ sum
        $ filter invalid_id
        $ concat
        $ map (expand)
        $ parse input
