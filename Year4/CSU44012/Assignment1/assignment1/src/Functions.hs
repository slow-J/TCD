module Functions where
import System.Time
import Control.Parallel

forceList :: [a] -> ()
forceList [] = ()
forceList (x:xs) = x `pseq` forceList xs

secDiff :: ClockTime -> ClockTime -> Float
secDiff (TOD secs1 psecs1) (TOD secs2 psecs2)
    = fromInteger (psecs2 -psecs1) / 1e12 + fromInteger (secs2 - secs1)


-- Sequential quicksort
squicksort :: Ord a => [a] -> [a]
squicksort [] = []
squicksort [x] = [x]
squicksort (x:xs) = losort ++ x : hisort
                 where
                 losort = squicksort [y | y <- xs, y < x]
                 hisort = squicksort [y | y <- xs, y >= x]


-- Non-sequential quicksort
quicksortPar :: Ord a => Int -> [a] -> [a]
quicksortPar _ [] = []
quicksortPar _ [x] = [x]
quicksortPar 0 x = squicksort x
quicksortPar nCores (x:xs) = (forceList sortLow `par` forceList sortHi) `pseq` (sortLow ++ x:sortHi)
                      where
                      lo = [y | y <- xs, y < x]
                      hi = [y | y <- xs, y >= x]
                      sortLow = quicksortPar nminus lo
                      sortHi = quicksortPar nminus hi
                      nminus = nCores - 1

-- Sequential mergesort
smergesort :: Ord a => [a] -> [a]
smergesort [] = []
smergesort [x] = [x]
smergesort xs = merge (smergesort firstHalf) (smergesort secondHalf)
                  where
                  firstHalf = take ((length xs) `div` 2) xs
                  secondHalf = drop ((length xs) `div` 2) xs

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge x [] = x
merge [] x = x
merge (x:xs) (y:ys)
    | y < x = y : merge (x:xs) ys
    | otherwise = x : merge xs (y:ys)

-- Non-sequential mergesort
mergesortPar :: Ord a => Int -> [a] -> [a]
mergesortPar _ [] = []
mergesortPar _ [x] = [x]
mergesortPar 0 xs = smergesort xs
mergesortPar nCores xs = (forceList firstHalf `par` forceList secondHalf) `pseq` (merge firstHalf secondHalf)
                  where
                  (left, right) = splitAt ((length xs) `div` 2) xs
                  firstHalf = mergesortPar nminus left
                  secondHalf = mergesortPar nminus right
                  nminus = nCores - 1