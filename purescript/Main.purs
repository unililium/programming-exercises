module Main where

import Prelude

greet :: String -> String
greet name = "Hello, " <> name <> "!"

sourceList :: [Int]
sourceList = [1..100]

allTriples :: [(Int, Int, Int)]
allTriples = [(a, b, c) | a <- sourceList, b <- sourceList, c <- sourceList]