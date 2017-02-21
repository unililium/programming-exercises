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
