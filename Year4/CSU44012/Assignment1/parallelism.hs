module Main
where
import System.Time
import Control.Parallel
import System.Random

-- Starter code, nothing really done yet

-- A sequential quicksort
quicksort :: Ord a => [a] −> [a]
quicksort [] = []
quicksort (x:xs) = losort ++ x : hisort
                     where
                     losort = quicksort [y | y <− xs, y < x]
                     hisort = quicksort [y | y <− xs, y >= x]

mergesort :: Ord a => [a] −> [a]
mergesort [] = []

secDiff :: ClockTime −> ClockTime −> Float
secDiff (TOD secs1 psecs1) (TOD secs2 psecs2)
    = fromInteger (psecs2 −psecs1) / 1e12 + fromInteger (secs2 −secs1)

main :: IO()
main
    = do t0 <− getClockTime
        let input = (take 20000 (randomRs (0,100) (mkStdGen 42)))::[Int]
        seq (forceList input) (return ())
        t1 <− getClockTime
        let r = sum (quicksortF input)
        seq r (return ()) -- Force evaluation of sum
        t2 <− getClockTime