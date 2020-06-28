pow2 n = pow2loop n 1 0
pow2loop n x i =
    if i < n
    then pow2loop n (x * 2) (i + 1)
    else x

pow2' n
    | n == 0    = 1
    | otherwise = 2 * (pow2' (n - 1))

double [] = []
double (x:xs) = (2 * x) : (double xs)

double' nums = case nums of
    []     -> []
    (x:xs) -> (2 * x) : (double' xs)

double'' = map (2*)

removeOdd [] = []
removeOdd (x:xs)
    | mod x 2 == 0 = x : (removeOdd xs)
    | otherwise    = removeOdd xs

fancyNine =
    let x = 4
        y = 5
    in  x + y

intsFrom n = n : (intsFrom (n + 1))
ints = intsFrom 1

(a,b) .+ (c,d) = (a + c, b + d)