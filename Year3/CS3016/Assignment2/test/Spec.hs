{-# LANGUAGE StandaloneDeriving #-}

module Main where

import Test.HUnit
import Test.Framework as TF (defaultMain, testGroup, Test)
import Test.Framework.Providers.HUnit (testCase)
-- import Test.Framework.Providers.QuickCheck2 (testProperty)

import Ex01

main = defaultMain tests -- runs the tests

tests :: [TF.Test]
tests = [ testGroup "\n\nExercise 01 Tests (120 marks)\n"
            [ teacherGotItRight
            , evalTests
            , simpTests
            ]
        ]

-- sanity checking for supplied code

x42 = ("x",42.0)
y99 = ("y",99.0)
emptyD   =  []         ::  EDict
dx42     =  [x42]      ::  EDict
dy99     =  [y99]      ::  EDict
dx42y99  =  [y99,x42]  ::  EDict

teacherGotItRight :: TF.Test
teacherGotItRight
 = testGroup "\nSupplied Code Tests (using x=42, y=99) SHOULD NEVER FAIL! "
    [ testCase "Neither in empty dict"
        ( x42 `elem` emptyD  || y99 `elem` emptyD @?= False )
    , testCase "defining x=42 works" ( define emptyD "x" 42 @?= dx42 )
    , testCase "defining y=99 works" ( define emptyD "y" 99 @?= dy99)
    , testCase "defining x=42 and y=99 works"
      ( define (define emptyD "x" 42) "y" 99 @?= dx42y99)
    , testCase "find in empty dict fails" ( find emptyD "x" @?= Nothing )
    , testCase "find x in dict with only y fails" ( find dy99 "x" @?= Nothing )
    , testCase "find x in dict with only x succeeds"
        ( find dx42 "x" @?= Just 42.0 )
    , testCase "find x in dict with both succeeds"
        ( find dx42y99 "x" @?= Just 42.0 )
    , testCase "find y in dict with both succeeds"
        ( find dx42y99 "y" @?= Just 99.0 )
    , testCase "find z in dict with x,y fails"
        ( find dx42y99 "z" @?= Nothing )
    , testCase "find z in dict after inserting it succeeds"
        ( find (define dx42y99 "z" 3.14159) "z" @?= Just 3.14159 )
    , testCase "find y in xy-dict after inserting z succeeds"
        ( find (define dx42y99 "z" 3.14159) "y" @?= Just 99.0 )
    ]

-- tests for Part 1 (eval) -----------------------------------------------------


d0 = Val 0.0
d1 = Val 1.0
d2 = Val 2.0
d42 = Val 42.0
d10 = Val 10.0
d99 = Val 99.0
d5 = Val 5.0
vx = Var "x"
vy = Var "y"
vz = Var "z"
dx42y7 = [("x",42.0),("y",7.0)]
n = "n"
va = Var "a"
vb = Var "b"
vc = Var "c"
vd = Var "d"


evalTests :: TF.Test
evalTests
 = testGroup "\nPart 1 - eval (63 marks)\n"
    [ testCase "Val with empty Dict {1 mark}"
        (eval emptyD (Val 42.0) @?= Just 42.0)
    , testCase "Val with xy Dict {1 mark}"
        (eval dx42y99 (Val 42.0) @?= Just 42.0)
    , testCase "Var x with empty Dict {1 mark}"
        (eval emptyD (Var "x") @?= Nothing)
    , testCase "Var x with y Dict {1 mark}"
        (eval dy99 (Var "x") @?= Nothing)
    , testCase "Var y with y Dict {1 mark}"
        (eval dy99 (Var "y") @?= Just 99.0)
                   --  5
    , evalAddTests -- 10
    , evalSubTests -- 12
    , evalMulTests -- 12
    , evalDvdTests -- 13
    , evalDefTests --  8
    , evalBigTests --  3
    ]

eBad = Dvd d1 d0

evalAddTests
 = testGroup "\nAdd tests (10 marks)\n"
    [ testCase "Add fail fail {1 mark}"
        (eval dx42y99 (Add eBad eBad) @?= Nothing)
    , testCase "Add fail Val {1 mark}"
        (eval dx42y99 (Add eBad d2) @?= Nothing)
    , testCase "Add Val fail  {1 mark}"
        (eval dx42y99 (Add d1 eBad) @?= Nothing)
    , testCase "Add Val Var (empty dict) {1 mark}"
        (eval emptyD (Add d2 vx) @?= Nothing)
    , testCase "Add Val Var (dict with x) {1 mark}"
        (eval dx42y99 (Add d2 vx) @?= Just 44.0)
    , testCase "Add Var Val (empty dict) {1 mark}"
        (eval emptyD (Add vx d2) @?= Nothing)
    , testCase "Add Var Val (dict with x) {1 mark}"
        (eval dx42y99 (Add vx d2) @?= Just 44.0)
    , testCase "Add Var Var (dict with x) {1 mark}"
        (eval dx42 (Add vx vy) @?= Nothing)
    , testCase "Add Var Var (dict with y) {1 mark}"
        (eval dy99 (Add vx vy) @?= Nothing)
    , testCase "Add Var Var (dict with xy) {1 mark}"
        (eval dx42y99 (Add vx vy) @?= Just 141.0)
    ]

evalSubTests
 = testGroup "\nSub tests  (12 marks)\n"
    [ testCase "Sub fail fail {1 mark}"
        (eval dx42y99 (Sub eBad eBad) @?= Nothing)
    , testCase "Sub fail Val {1 mark}"
        (eval dx42y99 (Sub eBad d2) @?= Nothing)
    , testCase "Sub Val fail  {1 mark}"
        (eval dx42y99 (Sub d1 eBad) @?= Nothing)
    , testCase "Sub Val Val (empty dict) {1 mark}"
        (eval emptyD (Sub d2 d1) @?= Just 1.0)
    , testCase "Sub Val Val (non-empty dict) {1 mark}"
        (eval dx42y99 (Sub d1 d2) @?= Just (-1.0))
    , testCase "Sub Val Var (empty dict) {1 mark}"
        (eval emptyD (Sub d2 vx) @?= Nothing)
    , testCase "Sub Val Var (dict with x) {1 mark}"
        (eval dx42y99 (Sub d2 vx) @?= Just (-40.0))
    , testCase "Sub Var Val (empty dict) {1 mark}"
        (eval emptyD (Sub vx d2) @?= Nothing)
    , testCase "Sub Var Val (dict with x) {1 mark}"
        (eval dx42y99 (Sub vx d2) @?= Just 40.0)
    , testCase "Sub Var Var (dict with x) {1 mark}"
        (eval dx42 (Sub vx vy) @?= Nothing)
    , testCase "Sub Var Var (dict with y) {1 mark}"
        (eval dy99 (Sub vx vy) @?= Nothing)
    , testCase "Sub Var Var (dict with xy) {1 mark}"
        (eval dx42y99 (Sub vx vy) @?= Just (-57.0))
    ]

evalMulTests
 = testGroup "\nMul tests (12 marks)\n"
    [ testCase "Mul fail fail {1 mark}"
        (eval dx42y99 (Mul eBad eBad) @?= Nothing)
    , testCase "Mul fail Val {1 mark}"
        (eval dx42y99 (Mul eBad d2) @?= Nothing)
    , testCase "Mul Val fail  {1 mark}"
        (eval dx42y99 (Mul d1 eBad) @?= Nothing)
    , testCase "Mul Val Val (empty dict) {1 mark}"
        (eval emptyD (Mul d2 d1) @?= Just 2.0)
    , testCase "Mul Val Val (non-empty dict) {1 mark}"
        (eval dx42y99 (Mul d1 d2) @?= Just 2.0)
    , testCase "Mul Val Var (empty dict) {1 mark}"
        (eval emptyD (Mul d2 vx) @?= Nothing)
    , testCase "Mul Val Var (dict with x) {1 mark}"
        (eval dx42y99 (Mul d2 vx) @?= Just 84.0)
    , testCase "Mul Var Val (empty dict) {1 mark}"
        (eval emptyD (Mul vx d2) @?= Nothing)
    , testCase "Mul Var Val (dict with x) {1 mark}"
        (eval dx42y99 (Mul vx d2) @?= Just 84.0)
    , testCase "Mul Var Var (dict with x) {1 mark}"
        (eval dx42 (Mul vx vy) @?= Nothing)
    , testCase "Mul Var Var (dict with y) {1 mark}"
        (eval dy99 (Mul vx vy) @?= Nothing)
    , testCase "Mul Var Var (dict with xy) {1 mark}"
        (eval dx42y99 (Mul vx vy) @?= Just 4158.0)
    ]

evalDvdTests
 = testGroup "\nDvd tests  (13 marks)\n"
    [ testCase "Dvd fail fail {1 mark}"
        (eval dx42y99 (Dvd eBad eBad) @?= Nothing)
    , testCase "Dvd fail Val {1 mark}"
        (eval dx42y99 (Dvd eBad d2) @?= Nothing)
    , testCase "Dvd Val fail  {1 mark}"
        (eval dx42y99 (Add d1 eBad) @?= Nothing)
    , testCase "Dvd Val Zero (empty dict) {1 mark}"
        (eval emptyD (Dvd d2 d0) @?= Nothing)
    , testCase "Dvd Val Val (empty dict) {1 mark}"
        (eval emptyD (Dvd d2 d1) @?= Just 2.0)
    , testCase "Dvd Val Val (non-empty dict) {1 mark}"
        (eval dx42y99 (Dvd d1 d2) @?= Just 0.5)
    , testCase "Dvd Val Var (empty dict) {1 mark}"
        (eval emptyD (Dvd d2 vx) @?= Nothing)
    , testCase "Dvd Val Var (dict with x) {1 mark}"
        (eval [("z",3.0)] (Dvd d42 vz) @?= Just 14.0)
    , testCase "Dvd Var Val (empty dict) {1 mark}"
        (eval emptyD (Dvd vx d2) @?= Nothing)
    , testCase "Dvd Var Val (dict with x) {1 mark}"
        (eval dx42y99 (Dvd vx d2) @?= Just 21.0)
    , testCase "Dvd Var Var (dict with x) {1 mark}"
        (eval dx42 (Dvd vx vy) @?= Nothing)
    , testCase "Dvd Var Var (dict with y) {1 mark}"
        (eval dy99 (Dvd vx vy) @?= Nothing)
    , testCase "Dvd Var Var (dict with xy) {1 mark}"
        (eval dx42y7 (Dvd vx vy) @?= Just 6.0)
    ]


evalDefTests
 = testGroup "\nDef tests (8 marks)\n"
    [ testCase "Def n fail fail {1 mark}"
        (eval dx42y99 (Def n eBad eBad) @?= Nothing)
    , testCase "Def n fail Val {1 mark}"
        (eval dx42y99 (Def n eBad d2) @?= Nothing)
    , testCase "Def n Val fail  {1 mark}"
        (eval dx42y99 (Add d1 eBad) @?= Nothing)
    , testCase "Def n Val Val (empty dict) {1 mark}"
        (eval emptyD (Def n d1 d2) @?= Just 2.0)
    , testCase "Def n Val x (empty dict) {1 mark}"
        (eval emptyD (Def n d1 vx) @?= Nothing)
    , testCase "Def n Val x (dict with x) {1 mark}"
        (eval dx42 (Def n d1 vx) @?= Just 42.0)
    , testCase "Def n Val n (empty dict) {1 mark}"
        (eval emptyD (Def n d1 (Var n)) @?= Just 1.0)
    , testCase "a=2, b=42 in a*b {1 mark}"
        (eval emptyD (Def "a" d2 (Def "b" d42 (Mul va vb))) @?= Just 84.0)
    ]

eBig1 = Dvd (Mul vc (Sub va vb)) vd
eBig2 = Sub (Dvd (Mul va vc) vd) (Dvd (Mul vc vb) vd)

abcdWrap e
 = (Def "a" d99 (Def "b" d42 (Def "c" d10 (Def "d" d5 e))))

evalBigTests
 = testGroup "\nBig-Expression Tests (3 marks)\n"
      [ testCase "Big test 1 c*(a-b)/d {1 mark}"
          ( eval emptyD (abcdWrap eBig1) @?= Just 114.0)
      , testCase "Big test 2 (c*a)/d -(c*b)/d {1 mark}"
          ( eval emptyD (abcdWrap eBig2) @?= Just 114.0)
      , testCase "Both Big are the same {1 mark}"
          ( eval emptyD (abcdWrap eBig1) @?= eval emptyD (abcdWrap eBig2) )
      ]

-- Tests for Part 2 (simp) -----------------------------------------------------

simpTests :: TF.Test
simpTests
 = testGroup "\nPart 2 - simp (57 marks)\n"
    [ simpVarTests -- 2
    , simpAddTests -- 8
    , simpSubTests -- 6
    , simpMulTests -- 8
    , simpDvdTests -- 8
    , simpDefTests -- 6, 5*4 + 5*1 = 25
    ]


dz0 = [("z",0.0)]
vu = Var "u"
vw = Var "w"
du1 = [("u",1.0)]
du1w1 = [("u",1.0),("w",1.0)]
du3w3 = [("u",3.0),("w",3.0)]

-- e - arbitrary expression
-- u,v,w,x,y,z  - variables

simpVarTests
 = testGroup "\nVar tests (2 marks)\n"
    [ testCase "x = x {1 mark}" (simp emptyD (Var "x") @?= Var "x" )
    , testCase "x = 42, when x=42 {1 mark}" (simp dx42y99 (Var "x") @?= d42 )
    ]


simpAddTests
 = testGroup "\nAdd tests (8 marks)\n"
    [ testCase "e+0 = e {1 mark}" (simp emptyD (Add eBig1 d0) @?= eBig1 )
    , testCase "e+z = e, when z=0 {1 mark}" (simp dz0 (Add eBig1 vz) @?= eBig1 )
    , testCase "0+e = e {1 mark}" (simp emptyD (Add d0 eBig1) @?= eBig1 )
    , testCase "z+e = e, when z=0 {1 mark}" (simp dz0 (Add vz eBig1) @?= eBig1 )
    , testCase "1+1 = 2 {1 mark}" (simp du1w1 (Add d1 d1) @?= d2 )
    , testCase "u+w = 2, when u,w=1 {1 mark}" (simp du1w1 (Add vu vw) @?= d2 )
    , testCase "1+w = 2, when w=1 {1 mark}" (simp du1w1 (Add d1 vw) @?= d2 )
    , testCase "u+1 = 2, when u=1 {1 mark}" (simp du1w1 (Add vu d1) @?= d2 )
    ]

simpSubTests
 = testGroup "\nSub tests (6 marks)\n"
    [ testCase "e-0 = e {1 mark}" (simp emptyD (Sub eBig1 d0) @?= eBig1 )
    , testCase "e-z = e, when z=0 {1 mark}" (simp dz0 (Sub eBig1 vz) @?= eBig1 )
    , testCase "2-1 = 1  {1 mark}" (simp du1w1 (Sub d2 d1) @?= d1 )
    , testCase "u-w = 0, when u,w=1 {1 mark}" (simp du1w1 (Sub vu vw) @?= d0 )
    , testCase "u-1 = 0, when u=1 {1 mark}" (simp du1w1 (Sub vu d1) @?= d0 )
    , testCase "1-w = 0, when w=1 {1 mark}" (simp du1w1 (Sub d1 vw) @?= d0 )
    ]

simpMulTests
 = testGroup "\nMul tests (8 marks)\n"
    [ testCase "e*1 = e {1 mark}" (simp emptyD (Mul eBig1 d1) @?= eBig1 )
    , testCase "e*u = e, when u=1 {1 mark}" (simp du1 (Mul eBig1 vu) @?= eBig1 )
    , testCase "1*e = e {1 mark}" (simp emptyD (Mul d1 eBig1) @?= eBig1 )
    , testCase "u*e = e, when u=1 {1 mark}" (simp du1 (Mul vu eBig1) @?= eBig1 )
    , testCase "2*2 = 4 {1 mark}" (simp du3w3 (Mul d2 d2) @?= Val 4.0 )
    , testCase "u*w = 9, u,w=3 {1 mark}" (simp du3w3 (Mul vu vw) @?= Val 9.0 )
    , testCase "2*w = 6, w=3 {1 mark}" (simp du3w3 (Mul d2 vw) @?= Val 6.0 )
    , testCase "u*5 = 15, u=3 {1 mark}" (simp du3w3 (Mul vu d5) @?= Val 15.0 )
    ]

simpDvdTests
 = testGroup "\nDvd tests (8 marks)\n"
    [ testCase "e/1 = e {1 mark}" (simp emptyD (Dvd eBig1 d1) @?= eBig1 )
    , testCase "e/u = e, when u=1 {1 mark}" (simp du1 (Dvd eBig1 vu) @?= eBig1 )
    , testCase "42/2 = 21 {1 mark}" (simp du3w3 (Dvd d42 d2) @?= Val 21.0 )
    , testCase "x/y = 6, when x=42,y=7 {1 mark}"
        (simp dx42y7 (Dvd vx vy) @?= Val 6.0 )
    , testCase "x/7 = 6, when x=42 {1 mark}"
        (simp dx42y7 (Dvd vx (Val 7.0)) @?= Val 6.0 )
    , testCase "42/y = 6, when y=7 {1 mark}"
        (simp dx42y7 (Dvd d42 vy) @?= Val 6.0 )
    , testCase "e/0 stays as e/0 {1 mark}"
        (simp dx42y7 (Dvd d42 d0) @?= Dvd d42 d0 )
    , testCase "e/z stays as e/z, when z=0 {1 mark}"
        (simp dz0 (Dvd d42 vz) @?= Dvd d42 d0 )
    ]

aXb = (Mul (Var "a") (Var "b"))
xPy = Add vx vy
xPyPz = Add xPy vz
xPa3 = Add vx (Def "a" (Val 3.0) (Add vx (Var "a")))
xP3 = Add vx (Add vx (Val 3.0))

simpDefTests
 = testGroup "\nDef tests (25 marks)\n"
    [ testCase "let x=0 in x = 0 {4 marks}" (simp emptyD (Def "x" d0 vx) @?= d0 )
    , testCase "let x=0 in y = y {4 marks}" (simp emptyD (Def "x" d0 vy) @?= vy )
    , testCase "let a=2, b=3 in a*b = 6 {4 marks}"
         (simp [("b",3.0)] (Def "a" d2 aXb) @?= Val 6.0 )
    , testCase "let a=2 in x+y = x+y {4 marks}"
         (simp [] (Def "a" d2 xPy) @?= xPy )
    , testCase "let a=2 in (x+y)+z = (x+y)+z {4 marks}"
         (simp [] (Def "a" d2 xPyPz) @?= xPyPz )
    , testCase "let a=2 in (x+let a=3 in x+a)  =  x+(x+3) {5 marks}"
       (simp [] (Def "a" d2 xPa3) @?= xP3)
    ]
