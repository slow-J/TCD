{-# LANGUAGE StandaloneDeriving #-}

module Main where

import Test.HUnit
import Test.Framework as TF (defaultMain, testGroup, Test)
import Test.Framework.Providers.HUnit (testCase)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Ex00

{- HUnit Tests -}

test_nice_hello =  hello @?= "Hello World :-)"

{- QuickCheck Tests -}


main = defaultMain tests

tests :: [TF.Test]
tests = [ testGroup "\nExercise 00 Tests" [
            testCase "Say Hello Nicely [20 marks]" test_nice_hello
          ]
        ]
