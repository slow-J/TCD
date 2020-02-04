module Main where
import System.Time
import Control.Parallel
import System.Random

import Functions


main :: IO()
main = do
    --  nCores = number of cores
    let nCores = 7

    t0 <- getClockTime
    let input = (take 20000 (randomRs (0,100) (mkStdGen 42)))::[Int]
    seq (forceList input) (return ())

    t1 <- getClockTime
    let r = sum (squicksort input)
    seq r (return ()) -- Force evaluation of sum
    t2 <- getClockTime

-- Write out the sum of the result.
    putStrLn("Sum of quicksort: " ++ show r)
-- Write out the time taken to perform the sort.
    putStrLn("Time to quicksort: " ++ show (secDiff t1 t2))


    t1 <- getClockTime
    let r = sum (quicksortPar nCores input)
    seq r (return ()) -- Force evaluation of sum
    t2 <- getClockTime

    putStrLn("Sum of quicksort w/ parallelism: " ++ show r)
    putStrLn("Time to quicksort w/ parallelism: " ++ show (secDiff t1 t2))

    t1 <- getClockTime
    let r = sum (smergesort input)
    seq r (return ()) -- Force evaluation of sum
    t2 <- getClockTime

    putStrLn("Sum of merge sort: " ++ show r)
    putStrLn("Time to merge sort: " ++ show (secDiff t1 t2))

    t1 <- getClockTime
    let r = sum (mergesortPar nCores input)
    seq r (return ()) -- Force evaluation of sum
    t2 <- getClockTime

    putStrLn("Sum of merge sort w/ parallelism: " ++ show r)
    putStrLn("Time to merge sort w/ parallelism: " ++ show (secDiff t1 t2))