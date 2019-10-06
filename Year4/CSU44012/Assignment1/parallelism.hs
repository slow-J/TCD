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
  = fromInteger (psecs2
−
psecs1) / 1e12 +
fromInteger
(secs2
−
secs1)
18
19
main ::
IO
()
20
main
21
=
do
t0
<
−
getClockTime
22
let
input = (
take
20000 (
randomRs
(0,100) (
mkStdGen
42)))::[
Int
]
23
seq
(forceList input) (
return
())
24
t1
<
−
getClockTime
25
let
r =
sum
(quicksortF input)
26
seq
r (
return
())
−−
Force evaluation of sum
27
t2
<
−
getClockTime