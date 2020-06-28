myLast :: [a] -> a
myLast [] = error "No last in empty list"
myLast [x] = x
myLast (_:xs) = myLast xs

myButLast :: [a] -> a
myButLast [x, y] = x
myButLast (_:xs) = myButLast xs

elementAt :: [a] -> Int -> a
elementAt [] _ = error "no elem"
elementAt (x:_) 0 = x
elementAt (_:xs) n = elementAt xs (n-1)