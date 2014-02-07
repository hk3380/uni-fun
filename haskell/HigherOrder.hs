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
