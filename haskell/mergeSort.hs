mergeSort :: [Int] -> [Int]
mergeSort [x] = [x]
mergeSort l = merge (mergeSort xs) (mergeSort ys) 
              where (xs, ys) = splitAt ((length l + 1) `div` 2) l

merge :: [Int] -> [Int] -> [Int]
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys) = if x <= y then x : merge xs (y:ys)
                      else y : merge (x:xs) ys