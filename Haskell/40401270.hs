{-
Author: Davide Pollicino 
-}

-- QUESTION 1: Sets

subSet :: (Eq a) => [a] -> [a] -> Bool
subSet [] ys = True
subSet (x:xs) ys
        |  elem x ys = subSet xs ys
        |  otherwise = False

complement :: (Eq a) => [a] -> [a] -> Maybe[a]
complement [] [] = Nothing
complement xs ys 
         | subSet xs ys = Just (theIntersection xs ys)
         | otherwise = Nothing

uniqueList :: (Eq a) => [a] -> [a]
uniqueList [] = []
uniqueList (x:xs)
        | elem x xs = uniqueList xs
        | otherwise = x : uniqueList xs
 


setEquality :: (Eq a) => [a] -> [a] -> Bool -- Takes in 2 lists and returns a boolean
setEquality ys xs = subSet ys xs && subSet xs ys -- Function works on a list of ys and xs and calls subSet to get the subset of ys and xs

theIntersection :: (Eq a) => [a] -> [a] -> [a] -- Takes in three lists
theIntersection[] ys = [] -- List of ys returns an empty list
theIntersection (x:xs) ys
      | elem x ys = x: theIntersection xs ys

     
mIntersect :: (Eq a) => [(a,Int)] -> [(a,Int)] -> [(a,Int)]
mIntersect xs ys = [(n,min x y) | (n,x) <- xs , (m,y) <- ys, n==m]


-- TEST SET FOR Q1
{-
Your functions should have the following behaviour:
complement [1,2,3] [1..5] = Just [4,5]
complement [1,2,3] [2..5] = Nothing
toMultiset [1,1,1,2,4,1,2] = [(1,4),(2,2),(4,1)]
toMultiset "from each according to his ability, to each according to his needs" = [('f',1),('m',1),('b',1),('l',1),('y',1),(',',1),('a',5),('c',6),('r',3),('g',2),('t',4),('o',6),('h',4),('i',6),(' ',11),('n',3),('e',4),('d',3),('s',3)]
mIntersect [(1,6),(2,3)] [(1,2),(2,5),(3,1)] = [(1,2),(2,3)]
mIntersect [(1,2),(4,1)] [(1,1),(4,2)] = [(1,1),(4,1)]
 
THE ORDER OF ELEMENTS IN THE RESULTS OF
 mUnion IS NOT IMPORTANT.
-}



-- QUESTION 2: Functions and relations

transClosure xs = [(a,d) | (a,b) <- xs, (c,d) <- xs, b==c] ++ xs


-- TEST SET FOR Q2
{-
Your functions should have the following behaviour:
transClosure [(1,2),(2,3)] = [(1,2),(2,3),(1,3)]
transClosure [(1,1),(3,5), (5,3)] = [(1,1),(3,5),(5,3),(3,3),(5,5)]

DO NOT WORRY ABOUT THE ORDER IN WHICH PAIRS APPEAR IN YOUR LIST
-}




-- QUESTION 4: Primes

nextPrimes :: Int -> [Int]
nextPrimes n = let sq    = fromIntegral . ceiling . sqrt $ fromIntegral n
                   pri k = (k,and [ k`mod`x/=0 | x <- [2..sq]])
               in  take 3 . map fst . filter snd $ map pri [n..]
 
primeFactorisation :: Int -> [Int]
primeFactorisation n = primeFactorisation' n 2
  where
    primeFactorisation' 1 _ = []
    primeFactorisation' n f
      | n `mod` f == 0 = f : primeFactorisation' (n `div` f) f
      | otherwise      = primeFactorisation' n (f + 1)


-- TEST SET FOR Q4
{-
Your functions should have the following behaviour:
nextPrimes 75 = [79,83,89]
nextPrimes 64 = [67,71,73]
primeFactorisation 75 = [3,5,5]
primeFactorisation 64 = [2,2,2,2,2,2]
-}


-- QUESTION 5: 


eTotient :: Int -> Int
eTotient 1 = 1
eTotient a = length $ filter (coprime a) [1..a-1]
 where coprime a b = gcd a b == 1

-- TEST SET FOR Q5
{-
Your functions should have the following behaviour:
eTotient 54 = 18
eTotient 73 = 7
-}


