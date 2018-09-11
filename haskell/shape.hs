data Shape = Circle Float Float Float | Square Float deriving (Show)

surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Square l) = l ^ 2
