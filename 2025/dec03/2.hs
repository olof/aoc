import Data.List

drop_last :: Int -> [a] -> [a]
drop_last count list = take ((length list) - count) list

max_index :: Ord a => Int -> [a] -> Int
max_index len list =
  maybe 0 (\x -> x) $ elemIndex (maximum $ drop_last (len-1) list) list

largest :: Int -> String -> String -> String
largest 0 xs _ = reverse xs
largest len acc xs =
  let idx = (maxIndex len xs) in
    largest (len-1) ((xs !! idx):acc) (drop (idx+1) xs)

main = do
  input <- readFile "input.sample"
  print $ sum
        $ map (read :: String -> Int)
        $ map (largest 12 [])
        $ lines input
