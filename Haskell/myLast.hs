myLast :: [a] -> a
myLast [] = error "No end of empty lists!"
myLast [x] = x
myLast (_:xs) = myLast xs
