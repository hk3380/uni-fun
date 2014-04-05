import Data.Maybe

-- input -> (Matched pattern, Rest of the pattern)
type RegExp a = [a] -> (Maybe [a], [a])

-- Checks if first letter is 'a' (test)
recogniseA :: [Char] -> (Maybe [Char], [Char])
recogniseA [] = (Nothing, [])
recogniseA s@(x:xs)
                | x == 'a' = (Just [x], xs) --found 'a'
                | otherwise = (Nothing, s)  --found something else

-- Empty string is always found
nil :: RegExp a
nil s = (Just [], s)

-- Applies a function and returns the match
range :: (a -> Bool) -> RegExp a
range f (x:xs) = if f x then (Just [x], xs) else (Nothing, xs)

-- Checks for one specific character
one :: Eq a => a -> RegExp a
one a = range (== a)

-- Matches any arbitrary character
arb :: RegExp a
arb = range (const True)

-- Union
alt :: Eq a => RegExp a -> RegExp a -> RegExp a
alt r1 r2 s | isJust(fst (r1 s)) = r1 s
            | otherwise = r2 s

-- Sequence of regex
sqn :: Eq a => RegExp a -> RegExp a -> RegExp a
sqn r1 r2 s | isJust(fst (r1 s)) && isJust (fst(r2 s)) = 
                (Just (fromJust(fst (r1 s)) ++ fromJust(fst (r2 s)))
                     , snd(r1 s)) -- Sorry for this ;_; 
            | otherwise = (Nothing ,s) 

-- Sequence of strings
sqns :: Eq a => [a] -> RegExp a
sqns s = foldl sqn nil $ map one s

-- Kleene star
itr :: Eq a => RegExp a -> RegExp a
itr r = alt (sqn r (itr r)) nil


-- Check for lexems 
lexemes :: Show a => RegExp a -> RegExp a -> [a] -> [[a]]
lexemes regexp wspace = lrw
  where
    lrw [] = []
    lrw s  = (maybe (error ("Not a lexeme: "++show s)) id m) : lrw t
      where (m, t) = regexp (snd (wspace s))
     

-- Lexer 
scanner :: Show a => RegExp a -> RegExp a -> ([a]->b) -> [a] -> [b]
scanner regexp wspace trans = (map trans) . (lexemes regexp wspace)

main = do print "sup"
