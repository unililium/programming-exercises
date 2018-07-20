myLast :: [a] -> a
myLast [x] = x
myLast (_:xs) = myLast xs

myButLast :: [a] -> a
myButLast [x,_] = x
myButLast (_:xs) = myButLast xs

elementAt :: [a] -> Int -> a
elementAt (x:_) 0 = x
elementAt (_:xs) n = elementAt xs (n - 1)

data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List x) = concatMap flatten x
