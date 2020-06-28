myLast :: [a] -> a
myLast [] = error "empty list"
myLast [x] = x
myLast (_:xs) = myLast xs

myButLast :: [a] -> a
myButLast [_] = error "at least 2 elem"
myButLast [x,_] = x
myButLast (_:xs) = myButLast xs

elementAt :: [a] -> Int -> a
elementAt [] _ = error "empty list"
elementAt (x:_) 0 = x
elementAt (_:xs) k = elementAt xs $ k - 1

myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myReverse:: [a] -> [a]
myReverse [x] = [x]
myReverse (x:xs) = myReverse xs ++ [x]

isPalindrome [] = True
isPalindrome [_] = True
isPalindrome (x:xs)
    | x == myLast xs = isPalindrome (init xs)
    | otherwise      = False

pack [] = []
pack (x:xs) =
    let (first, rest) = span (== x) xs
        in (x:first) : pack rest

encode [] = []
encode (x:xs) = (length $ x : takeWhile (== x) xs, x) : encode (dropWhile (== x) xs)

data ListItem a = Single a | Multiple Int a
    deriving (Show)
encodeModified :: Eq a => [a] -> [ListItem a]
encodeModified = map encodeHelper . encode
    where
        encodeHelper (1, x) = Single x
        encodeHelper (n, x) = Multiple n x

-- Problem 31
-- determine wheter a given integer number is prime
isPrime 1 = False
isPrime 2 = True
isPrime n = isPrime' n 2
isPrime' n k
    | k > (floor $ sqrt $ fromIntegral n) = True
    | n `mod` k == 0                      = False
    | otherwise                           = isPrime' n (k + 1)

dupli [] = []
dupli (x:xs) = x : x : dupli xs

repli [] _ = []
repli x 0 = []
repli x 1 = x
repli (x:xs) n = x : repli [x] (n - 1) ++ repli xs n

split :: [a] -> Int -> ([a], [a])
split x 0 = ([], x)
split (x:xs) 1 = ([x], xs)
split (x:xs) n =
    let r = (split xs (n-1))
    in (x : fst r, snd r)