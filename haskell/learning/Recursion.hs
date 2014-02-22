--
-- Recursion
--

-- User defined maximum
maximum' :: (Ord a) => [a] -> a
maximum' []  = error "list is empty"
maximum' [x] = x
maximum' (x:xs) 
          | x > maxTail   = x
          | otherwise     = maxTail
            where maxTail = maximum' xs

-- User defined maximum using max built-in function
maximumx :: (Ord a) => [a] -> a
maximumx []     = error "list is empty"
maximumx [x]    = x
maximumx (x:xs) = max x (maximumx xs)

-- Replicates x n times
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
            | n == 0     = []
            | otherwise = x:replicate' (n-1) x

-- User defined take
take' :: (Ord i, Num i) => i -> [a] -> [a]
take' _ [] = []
take' n (x:xs)
            | n == 0    = []
            | n < 0     = error "positive numbers pls"
            | otherwise =  [x] ++ take' (n-1) xs

-- User defined reverse
reverse' :: [a] -> [a]
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]

-- User defined elem
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
            | x == a    = True
            | otherwise = elem' a xs

-- Quicksort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
          let smallerSorted = [a | a <- xs, a <= x]
              biggerSorted  = [a | a <- xs, a > x]
          in smallerSorted ++ [x] ++ biggerSorted
