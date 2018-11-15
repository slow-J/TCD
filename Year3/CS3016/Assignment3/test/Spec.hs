{-# LANGUAGE StandaloneDeriving #-}

module Main where

import Test.HUnit
import Test.Framework as TF (defaultMain, testGroup, Test)
import Test.Framework.Providers.HUnit (testCase)
-- import Test.Framework.Providers.QuickCheck2 (testProperty)

import Ex02

main = defaultMain tests -- runs the tests

tests :: [TF.Test]
tests = [ testGroup "\n\nExercise 02 Tests (120 marks)\n"
            [ insertTests
            , lookupTests
            , numTests
            ]
        ]


-- tests for Part 1 (insert) -----------------------------------------------------


insertTests :: TF.Test
insertTests
 = testGroup "\nPart 1 - insert (40 marks)\n"
    [ testCase "1 -> 100 into Nil {5 marks}"
      ( ins 1 100 Nil @?= Leaf 1 100 )
    , testCase "3->300 into Leaf 5 500 {5 marks}"
      ( ins 3 300 (Leaf 5 500) @?= Br (Leaf 3 300) Nil 5 500 )
    , testCase "5->5000 into Leaf 5 500 {5 marks}"
      ( ins 5 5000 (Leaf 5 500) @?= Leaf 5 5000 )
    , testCase "7->700 into Leaf 5 500 {5 marks}"
      ( ins 7 700 (Leaf 5 500) @?= Br Nil (Leaf 7 700) 5 500 )
    , testCase "3->300 into Br Nil (Leaf 7 700) 5 500 {4 marks}"
      ( ins 3 300 (Br Nil (Leaf 7 700) 5 500)
       @?= Br (Leaf 3 300) (Leaf 7 700) 5 500 )
    , testCase "7->700 into Br (Leaf 3 300) Nil 5 500 {4 marks}"
      ( ins 7 700 (Br (Leaf 3 300) Nil 5 500)
        @?= Br (Leaf 3 300) (Leaf 7 700) 5 500 )
    , testCase "4->400 into Br (Leaf 3 300) (Leaf 7 700) 5 500 {4 marks}"
       ( ins 4 400 (Br (Leaf 3 300) (Leaf 7 700) 5 500) @?=
           Br (Br Nil (Leaf 4 400) 3 300) (Leaf 7 700) 5 500 )
    , testCase "6->600 into Br (Leaf 3 300) (Leaf 7 700) 5 500 {4 marks}"
       ( ins 6 600 (Br (Leaf 3 300) (Leaf 7 700) 5 500) @?=
           Br (Leaf 3 300) (Br (Leaf 6 600) Nil 7 700) 5 500 )
    , testCase "7->49 into Br (Leaf 3 300) (Leaf 7 700) 5 500 {4 marks}"
       ( ins 7 49 (Br (Leaf 3 300) (Leaf 7 700) 5 500) @?=
           Br (Leaf 3 300) (Leaf 7 49) 5 500 )
    ]


-- Tests for Part 2 (lookup) -----------------------------------------------------

c :: IntFun
c = Nil

lookupTests :: TF.Test
lookupTests
 = testGroup "\nPart 2 - lookup (40 marks)\n"
    [ testCase "3 in Nil ? (Maybe){3 marks}"
        (lkp c 3 @?= Nothing )
    , testCase "3 in Nil ? ([]){3 marks}"
        (lkp c 3 @?= [] )
    , testCase "3 in Leaf 5 500 (Maybe)){3 marks}"
        (lkp (Leaf 5 500) 3 @?= Nothing )
    , testCase "3 in Leaf 5 500 ([])){3 marks}"
        (lkp (Leaf 5 500) 3 @?= [] )
    , testCase "3 in Leaf 3 300 (Maybe)){3 marks}"
        (lkp (Leaf 3 300) 3 @?= Just 300 )
    , testCase "3 in Leaf 3 300 ([])){3 marks}"
        (lkp (Leaf 3 300) 3 @?= [300] )
    , testCase "3 in Br (Leaf 3 300) (Leaf 7 700) 5 500 ([])){4 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 3 @?= [300] )
    , testCase "7 in Br (Leaf 3 300) (Leaf 7 700) 5 500 (Maybe)){3 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 7 @?= Just 700 )
    , testCase "5 in Br (Leaf 3 300) (Leaf 7 700) 5 500 ([])){3 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 5 @?= [500] )
    , testCase "1 in Br (Leaf 3 300) (Leaf 7 700) 5 500 (Maybe)){3 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 1 @?= Nothing )
    , testCase "4 in Br (Leaf 3 300) (Leaf 7 700) 5 500 ([])){3 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 4 @?= [] )
    , testCase "6 in Br (Leaf 3 300) (Leaf 7 700) 5 500 (Maybe)){3 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 6 @?= Nothing )
    , testCase "8 in Br (Leaf 3 300) (Leaf 7 700) 5 500 ([])){3 marks}"
        (lkp (Br (Leaf 3 300) (Leaf 7 700) 5 500) 8 @?= [] )
    ]


-- Tests for Part 3 (Num instance) -----------------------------------------------------

numTests :: TF.Test

v = Var "v"
x = Var "x"
y = Var "y"

numTests
 = testGroup "\nPart 3 - Number instances (40 marks)\n"
    [
      testCase "fromInteger 42 {2 marks}"
        ( fromInteger 42 @?= Val 42.0 )
    , testCase "0  {2 marks}"
        (0 @?= Val 00 )

    , testCase "1+1 {1 mark}"
        (1+1 @?= Val 2.0)
    , testCase "1+v {2 marks}"
        (1+v @?= Add 1 v)
    , testCase "v+1 {2 marks}"
        (v+1 @?= Add v 1)
    , testCase "x+y {1 mark}"
        (x+y @?= Add x y)

    , testCase "2-1 {1 mark}"
        (2-1 @?= Val 1.0)
    , testCase "2-v {2 marks}"
        (2-v @?= Sub 2 v)
    , testCase "v-1 {2 marks}"
        (v-1 @?= Sub v 1)
    , testCase "x-y {1 mark}"
        (x-y @?= Sub x y)


    , testCase "2*2 {1 mark}"
        (2*2 @?= Val 4.0)
    , testCase "2*v {2 marks}"
        (2*v @?= Mul 2 v)
    , testCase "v*2 {2 marks}"
        (v*2 @?= Mul v 2)
    , testCase "x*y {1 mark}"
        (x*y @?= Mul x y)

    , testCase "negate 1 {3 marks}"
        (negate 1 @?= Val (-1.0))
    , testCase "negate v {3 marks}"
        (negate v @?= Sub 0 v)

    , testCase "abs (-1) {2 mark}"
        (abs (-1) @?= Val 1.0)
    , testCase "abs 1 {2 mark}"
        (abs 1 @?= Val 1.0)
    , testCase "abs v {2 marks}"
        (abs v @?= Abs v)

    , testCase "signum (-42) {2 mark}"
        (signum (-42) @?= Val (-1.0))
    , testCase "signum 42 {1 mark}"
        (signum 42 @?= Val 1.0)
    , testCase "signum 0 {1 mark}"
        (signum 0 @?= Val 0.0)
    , testCase "signum v {2 mark}"
        (signum v @?= Sign v)
    ]
