sourceList :: [Int]
sourceList = [1..100]

allTriples :: [(Int, Int, Int)]
allTriples = [(a, b, c) | a <- sourceList, b <- sourceList, c <- sourceList]