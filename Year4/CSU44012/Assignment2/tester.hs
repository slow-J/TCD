-- File just used for testing, I hope I did'nt submit this

-- -- board + length of rows
-- rowMaker ::  Int -> [Int] -> [[Int]]
-- rowMaker rowLen list = rowMakerInternal list rowLen rowLen

-- -- list length rowsLeft 
-- rowMakerInternal :: [a] -> Int -> Int-> [[a]]
-- rowMakerInternal [] _ _ = []
-- rowMakerInternal list len left
--     | left > 0 =  (take len list) : rowMakerInternal newList len (left-1)
--     | otherwise = [list]
--         where
--             newList = rotateList len list
--             newLeft = left - 1
    

-- -- lengthtorotate list
-- rotateList :: Int -> [a] -> [a]
-- rotateList _ [] = []
-- rotateList 0 x = x
-- rotateList n (x:xs) = rotateList (n-1) xs
-- x = 
-- [No 0,No 0,No 0,No 0,No 0,No 0,No 1,Mine,Mine,
-- No 0,Shown 1,Shown 1,No 1,No 0,No 0,No 1,No 3,Mine,
-- No 0,No 1,Mine,No 1,No 1,No 1,No 1,No 1,No 1,
-- No 0,No 1,No 1,No 1,No 1,Mine,No 1,No 0,No 0,
-- No 0,No 0,No 1,No 1,No 2,No 1,No 1,No 0,No 0,No 0,No 0,No 2,Mine,No 2,No 0,No 0,No 0,No 0,No 0,No 0,No 2,Mine,No 3,No 1,No 0,No 0,No 0,No 0,No 0,No 1,No 2,Mine,No 1,No 0,No 1,No 1,No 0,No 0,No 0,No 1,No 1,No 1,No 0,No 1,Mine]

-- x = [No 0,No 0,No 0,No 0,No 0,No 0,No 1,Mine,Mine,No 0,Shown 1,Shown 1,No 1,No 0,No 0,No 1,No 3,Mine,No 0,No 1,Mine,No 1,No 1,No 1,No 1,No 1,No 1,No 0,No 1,No 1,No 1,No 1,Mine,No 1,No 0,No 0,No 0,No 0,No 1,No 1,No 2,No 1,No 1,No 0,No 0,No 0,No 0,No 2,Mine,No 2,No 0,No 0,No 0,No 0,No 0,No 0,No 2,Mine,No 3,No 1,No 0,No 0,No 0,No 0,No 0,No 1,No 2,Mine,No 1,No 0,No 1,No 1,No 0,No 0,No 0,No 1,No 1,No 1,No 0,No 1,Mine]
-- x1 = GameState {board = Board [No 1,No 1,No 1,No 1,No 1,No 0,No 0,No 0,No 0,Mine,No 1,No 1,Mine,No 1,No 0,No 0,No 0,No 0,No 1,No 2,No 2,No 2,No 1,No 0,No 0,No 0,No 0,No 0,No 1,Mine,No 2,No 1,No 1,No 0,No 0,No 0,No 0,No 1,No 1,No 2,Mine,No 2,No 1,No 0,No 0,No 0,No 0,No 0,No 2,No 3,Mine,No 1,No 0,No 0,No 0,No 0,No 0,No 1,Mine,No 2,No 1,No 0,No 0,No 0,No 0,No 0,No 1,No 2,No 2,No 2,No 2,No 2,No 0,No 0,No 0,No 0,No 1,Mine,No 2,Mine,Mine], rows = 9, cols = 9, flagCount = 9, losscheck = 0, wincheck = 0}
-- x2 = GameState {board = Board [No 1,No 1,No 1,No 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,Mine,No 1,No 1,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 1,No 2,No 2,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,Mine,No 2,Shown 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,No 1,No 2,Mine,Shown 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 2,No 3,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,Mine,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,No 2,No 2,Shown 2,Shown 2,Shown 2,No 0,No 0,No 0,No 0,No 1,Mine,No 2,Mine,Mine], rows = 9, cols = 9, flagCount = 9, losscheck = 0, wincheck = 0}

-- x5 = GameState {board = Board [Shown 1,Shown 1,Shown 1,No 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,Mine,Shown 1,No 1,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 1,No 2,No 2,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,Mine,No 2,Shown 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,No 1,No 2,Mine,Shown 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 2,No 3,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,Mine,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,No 2,No 2,Shown 2,Shown 2,Shown 2,No 0,No 0,No 0,No 0,No 1,Mine,No 2,Mine,Mine], rows = 9, cols = 9, flagCount = 9, losscheck = 0, wincheck = 0}
-- box5 = [Shown 1,Shown 1,Shown 1,No 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,Mine,Shown 1,No 1,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 1,No 2,No 2,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,Mine,No 2,Shown 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,No 1,No 2,Mine,Shown 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 2,No 3,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,Mine,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,No 2,No 2,Shown 2,Shown 2,Shown 2,No 0,No 0,No 0,No 0,No 1,Mine,No 2,Mine,Mine]

-- [Shown 1,Shown 1,Shown 1,No 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,Flag Mine,Shown 1,No 1,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 1,No 2,No 2,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,Mine,No 2,Shown 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,No 1,No 2,Mine,Shown 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 2,No 3,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,Mine,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,No 2,No 2,Shown 2,Shown 2,Shown 2,No 0,No 0,No 0,No 0,No 1,Mine,No 2,Mine,Mine]


-- [Shown 1,Shown 1,Shown 1,No 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,
-- Flag Mine,Shown 1,No 1,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,
-- No 1    ,No 2    ,No 2,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,
-- No 0,No 1,Mine,No 2,Shown 1,Shown 1,ZeroAdjacent,ZeroAdjacent,ZeroAdjacent,No 0,No 1,No 1,No 2,Mine,Shown 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 2,No 3,Mine,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,Mine,No 2,Shown 1,ZeroAdjacent,ZeroAdjacent,No 0,No 0,No 0,No 1,No 2,No 2,Shown 2,Shown 2,Shown 2,No 0,No 0,No 0,No 0,No 1,Mine,No 2,Mine,Mine]

-- x= [Empty,Mine,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Mine,Empty,Empty,Empty,Empty,Empty,Empty,Mine,Empty,Mine,Empty,Mine,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Mine,Mine,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Mine,Mine,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty]

-- [[No 0,Mine,No 0,No 0,No 0,No 2,No 2,No 0,No 0],
-- [No 1,No 1,Mine,No 0,No 1,No 3,No 3,No 0,No 0],
-- [Mine,No 3,Mine,No 0,Mine,No 1,No 1,No 0,No 0],
-- [No 1,No 3,No 1,No 0,No 1,No 1,No 3,No 1,No 0],
-- [No 0,No 3,No 3,No 0,No 0,No 0,Mine,Mine,No 2],
-- [No 1,No 1,No 1,No 1,No 2,No 0,No 2,No 1,No 1],
-- [No 1,No 1,Mine,Mine,No 1,No 0,No 0,No 0,No 2],
-- [No 1,No 0,No 0,No 1,No 2,No 0,No 0,No 0,No 0],
-- [No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0]]

-- [[No 1,Mine,No 2,No 1,No 0,No 0,No 0,No 0,No 0],
-- [No 2,No 4,Mine,No 3,No 1,No 1,No 0,No 0,No 0],
-- [Mine,No 3,Mine,No 3,Mine,No 1,No 0,No 0,No 0],
-- [No 1,No 2,No 1,No 2,No 1,No 2,No 2,No 2,No 1],
-- [No 0,No 0,No 0,No 0,No 0,No 1,Mine,Mine,No 1],
-- [No 0,No 1,No 2,No 2,No 1,No 1,No 2,No 2,No 1],
-- [No 0,No 1,Mine,Mine,No 1,No 0,No 0,No 0,No 0],
-- [No 0,No 1,No 2,No 2,No 1,No 0,No 0,No 0,No 0],
-- [No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0]]

-- [[No 1,Mine,No 2,No 1,No 0,No 0,No 0,No 0,No 0],
-- [No 2,No 4,Mine,No 3,No 1,No 1,No 0,No 0,No 0],
-- [Mine,No 3,Mine,No 3,Mine,No 1,No 0,No 0,No 0],
-- [No 1,No 2,No 1,No 2,No 1,No 2,No 2,No 2,No 1],
-- [No 0,No 0,No 0,No 0,No 0,No 1,Mine,Mine,No 1],
-- [No 0,No 1,No 2,No 2,No 1,No 1,No 2,No 2,No 1],
-- [No 0,No 1,Mine,Mine,No 1,No 0,No 0,No 0,No 0],
-- [No 0,No 1,No 2,No 2,No 1,No 0,No 0,No 0,No 0],
-- [No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0]]
-- [[Hidden Mine,No 2,No 1,No 0,No 0,No 1,No 1,No 2,Hidden Mine],
-- [No 2,Hidden Mine,No 1,No 0,No 0,No 1,Hidden Mine,No 3,No 2],
-- [No 1,No 1,No 1,No 0,No 0,No 2,No 4,Hidden Mine,No 2],

-- [No 0,No 0,No 0,No 0,No 1,No 2,Hidden Mine,Hidden Mine,No 2],
-- [No 0,No 0,No 0,No 0,No 1,Hidden Mine,No 3,No 2,No 1],
-- [No 0,No 0,No 0,No 0,No 1,No 1,No 1,No 1,No 1],

-- [No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 1,Hidden Mine]
-- ,[No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 1,No 1],
-- [No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0,No 0]]
-- {"cols":9,"rows":9,"flagCount":9,"board":
-- {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"[]"},    {"box":"[]"}    ,{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},
-- {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"[]"}    ,{"box":"[]"}    ,{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},
-- {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"[]"},    {"box":"[]"},    {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},
-- {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},
-- {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},
-- {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},{"box":"Hidden"},
-- {"box":"[]"},    {"box":"[]"},    {"box":"[]"}    ,{"box":"[]"},    {"box":"[]"},    {"box":"[]"}    ,{"box":"[]"}   , {"box":"Hidden"},{"box":"Hidden"},
-- {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"Hidden"},{"box":"Hidden"},
-- {"box":"[]"}    ,{"box":"[]"},    {"box":"[]"},    {"box":"[]"}    ,{"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"},    {"box":"[]"}]}