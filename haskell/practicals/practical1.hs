--
-- Expression tree (no support for variables version)
--

-- types
type Assoc a = [(String, a)] -- for later
type V = String
type N = Int

-- Expression datatype
data E = Get N
        | Hyped V
        | Add E E
        | Sub E E
        | Times E E
        | Up E E
        deriving Eq -- for simplifications

-- Custom show
instance Show E where
        show (Get n)     = show n
        show (Hyped v)   = v
        show (Add a b)   = "(" ++ show a ++ " + " ++ show b ++ ")"
        show (Sub a b)   = "(" ++ show a ++ " - " ++ show b ++ ")"
        show (Times a b) = "(" ++ show a ++ " * " ++ show b ++ ")"
        show (Up a b)    = "(" ++ show a ++ " / " ++ show b ++ ")"

-- Evaluate expression
eval :: E -> Int
eval (Get n)     = n
eval (Hyped s)   = error ("no" ++ s)
eval (Add a b)   = eval a + eval b
eval (Sub a b)   = eval a - eval b
eval (Times a b) = eval a * eval b
eval (Up a b)    = eval a `div` eval b 


-- Simplify multiplication
simplify :: E -> E
simplify (Times a b) 
            | a == Get 0 || b == Get 0 = Get 0
            | a == Get 1 = simplify b
            | b == Get 1 = simplify a
            | otherwise = Times (simplify a) (simplify b)
simplify e = e 


--
--  List practice
--

-- Initiate some association list
test :: Assoc Int
test = [("a", 1),("b", 2),("c", 3)]

-- Get keys
-- type signatures are for nerds
names [] = []
names (x:xs) = fst x : names xs

-- Does value exist?
inAssoc _ [] = False
inAssoc n (x:xs) 
            | n == snd x = True
            | otherwise = inAssoc n xs

-- Find value via key
fetch n (x:xs)
        | n == fst x = snd x
        | otherwise = fetch n xs

-- Update list
update :: String  -> a -> Assoc a -> Assoc a
update s n [] = [(s,n)]
update s n (x:xs)
            | s == fst x = (s, n) : xs
            | otherwise = x : update s n xs

--
-- Expression trees with variables
--

data Operator = Addition | Deduct | Multiply -- | Divide
data Expression = Var V 
                | Val N 
                | Math Expression Operator Expression 

evalOP Addition = (+)
evalOP Deduct = (-)
evalOP Multiply = (*)
-- evalOP Divide = (+)


eval2 :: Assoc Int -> Expression -> Int
eval2 vars (Var v) = fetch v vars
eval2 vars (Val n) = n
eval2 vars (Math a op b) =  (evalOP op) (eval2 vars a) (eval2 vars b)


main = do print "only love for my girls"
