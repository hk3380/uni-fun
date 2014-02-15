import qualified Data.Map as Map

-- New data type to tell the status of a house
data HouseState = Taken | Free deriving (Show, Eq)

-- Type synonym for readability 
type Number = String

-- Type synonym for int -> pair mapping
type HouseMap = Map.Map Int (HouseState, Number)

houseSearch :: Int -> HouseMap -> Either String Number
houseSearch houseNo map = 
      case Map.lookup houseNo map of
        Nothing -> Left $ "House number" ++ show houseNo ++ " doesn't exist."
        Just (state, number) -> if state /= Taken
                                then Right number
                                else Left $ "House " ++ show number ++ " is taken, pal."


houses :: HouseMap
houses = Map.fromList
    [(100, (Taken,"Z1"))
    ,(101, (Free,"Z2"))
    ,(102, (Free,"Z3"))]
