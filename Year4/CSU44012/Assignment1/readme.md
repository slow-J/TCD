## Parallelism report  
Write two implementations of two sorting algorithms in Haskell (I suggest Merge Sort and Quicksort), and a testing framework to generate pseudo-random data.  
Benchmark both, and then (try to) use parallelism (you can either use direct par/seq directly, or the Eval monad) to speed each one up.  
Do some systematic benchmarking of your implementations, and use ThreadScope to get some insight into why they perform the way they do.