----------------------------
-- Higher Order functions --
----------------------------

-- User defined zipWith
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

-- User defined flip
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f x y = f y x

-- User defined map
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- Largest number divisible by x and smaller than y
largestDivisor :: (Integral a) => a -> a -> a
largestDivisor x y = head (filter p [y, y-1..])
              where p z = z `mod` x == 0

-- Sum of all odd squares smaller than n
oddSquares :: (Enum a, Integral a) => a -> a
oddSquares n = sum (filter odd (map (^2) [1..n]))

oddSquares2 :: (Integral a) => a -> a
oddSquares2 n = sum [x^2 | x <- [1..n], odd (x^2)]

-- Using fold for implementing sum
sum' :: (Num a) => [a] -> a
sum' xs = foldl(\acc x -> acc + x) 0 xs -- haskell is so qt
sum2' = foldl (+) 0                     -- this is nuts

-- Using fold for implementing elem
elem' :: (Eq a) => a -> [a] -> Bool
elem' x xs = foldl (\acc y -> if x == y then True else acc) False xs


-- Using foldr1 to define max
max' :: (Ord a) => [a] -> a
max' = foldr1(\x acc -> if x > acc then x else acc)
