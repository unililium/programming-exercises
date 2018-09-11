myLast :: [a] -> a
myLast [] = error "No end of empty lists!"
myLast [x] = x
myLast (_:xs) = myLast xs

myButLast :: [a] -> a
myButLast = last . init

insertAt :: a -> [a] -> Int -> [a]
insertAt y xs n = take (n-1) xs ++ [y] ++ drop (n-1) xs

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == reverse xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

myLength :: [a] -> Int
myLength = foldl (\n _ -> n + 1) 0

myMin :: [Int] -> Int
myMin (x:xs) = myMin' x xs
myMin' :: Int -> [Int] -> Int
myMin' m [] = m
myMin' m (x:xs)
    | m < x = myMin' m xs
    | otherwise = myMin' x xs

range :: Int -> Int -> [Int]
range n m
    | n == m = [n]
    | n < m = n : range (n + 1) m
    | otherwise = m : range n (m + 1)
