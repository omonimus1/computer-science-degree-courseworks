{-
REPLACE the function definitions for each of the questions. 
The names of the functions correspond to the names given in the document cwk19handout.pdf. 
-}

-- QUESTION 1: Sets

{-
givenOccurences xs [] = []
givenOccurences xs (y:ys) = elemCounter y xs : givenOccurences (xs) ys

toMultiset :: (Eq a) => [a] -> [(a,Int)]
toMultiset [] = []
toMultiset xs = zip (y:ys) (givenOccurences xs (y:ys))
    where(y:ys) = uniqueList xs
	
-}

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
--DONE
transClosure xs = [(a,d) | (a,b) <- xs, (c,d) <- xs, b==c] ++ xs


-- TEST SET FOR Q2
{-
Your functions should have the following behaviour:
transClosure [(1,2),(2,3)] = [(1,2),(2,3),(1,3)]
transClosure [(1,1),(3,5), (5,3)] = [(1,1),(3,5),(5,3),(3,3),(5,5)]

DO NOT WORRY ABOUT THE ORDER IN WHICH PAIRS APPEAR IN YOUR LIST
-}




-- QUESTION 3: Combinatorics
--Missing2 does not work
{-
missing2 :: Int -> [a] -> [[a]]
missing2 0 _ = [[]]
missing2 _ [] = []
missing2' n (x:xs) = (map (x:) (missing2 (n-1) xs)) ++ (missing2 n xs)
-}
-- TEST SET FOR Q3
{-
Your functions should have the following behaviour:
missing2 [1,2,3] = [[1],[2],[3]]
missing2 [2,6,9,12] = [[9,12],[6,12],[6,9],[2,12],[2,9],[2,6]]
NOTE THAT THE SMALLER LISTS ARE SORTED. THE ORDERING OF THE LISTS IN THE BIG LIST DOES NOT MATTER.
-}




-- QUESTION 4: Primes

--Done
nextPrimes :: Int -> [Int]
nextPrimes n = let sq    = fromIntegral . ceiling . sqrt $ fromIntegral n
                   pri k = (k,and [ k`mod`x/=0 | x <- [2..sq]])
               in  take 3 . map fst . filter snd $ map pri [n..]


--DONE 
primeFactorisation :: Int -> [Int]
primeFactorisation n = primeFactorisation' n 2
  where
    primeFactorisation' 1 _ = []
    primeFactorisation' n f
      | n `mod` f == 0 = f : primeFactorisation' (n `div` f) f
      | otherwise      = primeFactorisation' n (f + 1)

{-
	Be sure that primeFactorisation will accept value just under 9999999999 or we will run out of time. 
-}

{- 
Leave the error messages in place if you do not want to attempt the parts for the input size. You should remove the guards up to the point you want to attempt. For example, if you were confident of anything up to five digits, the function would look like:

primeFactorisation n
    | n <= 99999 = whatever_your_calculation_is
    | n <= 999999 = error "..."
    | otherwise = error "..."

 -}




-- TEST SET FOR Q4
{-
Your functions should have the following behaviour:
nextPrimes 75 = [79,83,89]
nextPrimes 64 = [67,71,73]
primeFactorisation 75 = [3,5,5]
primeFactorisation 64 = [2,2,2,2,2,2]
-}


-- QUESTION 5: RSA


--DONE
eTotient :: Int -> Int
eTotient 1 = 1
eTotient a = length $ filter (coprime a) [1..a-1]
 where coprime a b = gcd a b == 1


--TO DO
--encode :: Int -> Int -> Int -> Int -> Maybe Int


-- TEST SET FOR Q5
{-
Your functions should have the following behaviour:
eTotient 54 = 18
eTotient 73 = 72
encode 37 23 29 5 = Just 347
encode 99 18 108 45 = Nothing
encode 37 17 23 48 = Nothing
-}


