{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module Lib where
import System.Random
import Control.Monad
import Control.Monad.Random

import GHC.Generics
import Data.Aeson
import Control.Concurrent -- for mvar

-- sample board with my x y coordindates system and the col row system
--      | col1 | col2 | col3 | col4
-- row1 | 1,1  | 2,1  | 3,1  | 4,1
-- row2 | 1,2  | 2,2  | 3,2  | 4,2
-- row3 | 1,3  | 2,3  | 3,3  | 4,3
-- row4 | 1,4  | 2,4  | 3,4  | 4,4


-- creates a gamestate from the initial boxList (which contains Mine or Empty)
-- calls createNumsOnBoard which gets rid of Empty and replaces it with (No x), x being number of mines adjacent
privateGameStateFromBoxL :: Int -> Int -> Int -> [Box] -> GameState
privateGameStateFromBoxL rows1 cols1 flagC boxList = GameState {
    board = createNumsOnBoard rows1 cols1 boxList
  , rows = rows1
  , cols = cols1
  , flagCount = flagC
  , losscheck = lossCheck boxList
  , wincheck = checkWin boxList
}

-- gamestate record, contains the board and other parameters
data GameState = GameState {
   board :: Board
 , rows :: Int
 , cols :: Int
 , flagCount :: Int
 , losscheck :: Int
 , wincheck :: Int
} deriving (Eq, Show, Generic)
instance FromJSON GameState
instance ToJSON GameState

data Board = Board [Box] deriving (Eq, Show, Generic)
instance FromJSON Board
instance ToJSON Board

data Box
    = No Int         -- hidden number
    | Shown Int      -- opened number, no such thing as (Shown 0) look at ZeroAdjacent
    | ZeroAdjacent   -- comes from No 0, has 0 adjacent mines, happens when you open a (No 0), basically a (Shown 0)
    | Mine           -- open this and you lose
    | Boom           -- if you open a mine, loss condition
    | Flag Box       -- anything flagged, can only be a Flag(Mine) Flag(No x)
    | Empty          -- only used in mine setup, before numbers are assigned
    deriving (Eq, Show, Generic)

instance ToJSON Box where
  toJSON (Mine) = object ["box" .= (box2String Mine)]
  toJSON (Boom) = object ["box" .= (box2String Boom)]
  toJSON (Empty) = object ["box" .= (box2String Empty)]
  toJSON (ZeroAdjacent) = object ["box" .= (box2String (ZeroAdjacent))]
  toJSON (No x) = object ["box" .= (box2String (No x))]
  toJSON (Shown x) = object ["box" .= ( show (boxToInt (Shown x)))]
  toJSON (Flag x) = object ["box" .= (box2String (Flag x))]
instance FromJSON Box

-- in JSON boxes will be represented by these strings
box2String :: Box -> String
box2String Mine         = "X"    -- indistinguishable from (No x)
box2String Boom         = "Boom" -- you lost
box2String Empty        = "EE"  -- should never happen
box2String ZeroAdjacent = "[]"
box2String (No x)       = "X"
box2String (Flag x)     = "F"

-- return 1 if won, if only mines are left on the board
checkWin :: [Box] -> Int
checkWin [Mine] = 1
checkWin [ZeroAdjacent] = 1
checkWin [Flag Mine] = 1
checkWin [Shown x] =1
checkWin [x] = 0
checkWin (ZeroAdjacent : xs)= checkWin xs
checkWin (Mine : xs) = checkWin xs
checkWin (Flag Mine : xs) = checkWin xs
checkWin (Shown x : xs) = checkWin xs
checkWin (x:xs) = 0


-- -- creates boxes of (No x) with x being proximity to mines
-- createNumsOnBoard :: Int -> Int -> Board -> Board
-- createNumsOnBoard rows cols (Board x) = Board (startNumberGiver rows cols x)

-- starts inner function with (xPos, yPos) set to (1,1)
createNumsOnBoard :: Int -> Int -> [Box] -> Board
createNumsOnBoard rows cols list = Board (numberGiver rows cols (1, 1) list list)

-- will give number to all boxes
numberGiver :: Int -> Int -> (Int, Int) -> [Box] -> [Box] -> [Box]
numberGiver rows cols (xPos, yPos) [] wholeList = []
numberGiver rows cols (xPos, yPos) [x] wholeList
    | x == (Mine) = [x]
    | otherwise = [No (countAdjacentBox rows cols (xPos, yPos) Mine wholeList)]
numberGiver rows cols (xPos, yPos) (x:xs) wholeList
    | (xPos == cols && yPos == rows) =
            case (x == (Mine)) of
                    True -> [x]
                    False -> [No (countAdjacentBox rows cols (xPos, yPos) Mine wholeList)]
    | x == (Mine) = x : numberGiver rows cols (newXPos, newYPos) xs wholeList
    | otherwise = No (countAdjacentBox rows cols (xPos, yPos) Mine wholeList) : numberGiver rows cols (newXPos, newYPos) xs wholeList
        where
            (newXPos, newYPos) = xyIncrement cols (xPos, yPos)

-- gets the box list from the gamestate
gameStateToBoxL :: GameState -> [Box]
gameStateToBoxL (GameState (Board x) _ _ _ _ _) = x

-- give it the amount of boxes and cols and will give you amount of rows
rowCount :: Int -> Int -> Int
rowCount boxes cols
    | boxes `mod` cols == 0 = boxes `div` cols
    | otherwise = boxes `div` cols + 1

-- for indexes starting at 1
-- calls internal function with index-1
indexToCoord :: Int -> Int -> Int -> (Int, Int)
indexToCoord index rows cols = indexToCoordInternal (index-1) rows cols

-- for indexes starting at 0
indexToCoordInternal :: Int -> Int -> Int -> (Int, Int)
indexToCoordInternal index rows cols
    | index <= 0 = (1, 1)
    | index >= rows*cols = (cols, rows)
    | otherwise = (((index `mod` cols)+1), ((index `div` cols) + 1))

-- gives coordinates (x, y) from the index>0
coord2Index :: Int -> (Int, Int) -> Int
coord2Index cols (x, y) = y*(cols-1) + x


-- increments x, y coordinates in relation to the column count (rowLength)
-- x>0, y>0 min index = 1
xyIncrement :: Int -> (Int, Int) -> (Int, Int)
xyIncrement cols (xPos, yPos) = (newXPos, newyPosMaker newXPos yPos)
        where
            newXPos = (xPos `mod` cols)+1

-- will increment ypos iff xpos moves to new row
newyPosMaker :: Int -> Int -> Int
newyPosMaker 1 yPos = yPos + 1
newyPosMaker _ yPos = yPos

-- checks position in grid and then determines which way to check for box adjacent
-- returns amount of (given box type) adjacent
countAdjacentBox :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
countAdjacentBox rows cols (xPos, yPos) box list
    | check == 1 = ((searchDown rows cols (xPos, yPos) box list) + (searchRight rows cols (xPos, yPos) box list) + (searchSE rows cols (xPos, yPos) box list))
    | check == 2 = ((searchDown rows cols (xPos, yPos) box list) + (searchLeft rows cols (xPos, yPos) box list) + (searchSW rows cols (xPos, yPos) box list))
    | check == 3 = ((searchUp rows cols (xPos, yPos) box list) + (searchRight rows cols (xPos, yPos) box list) + (searchNE rows cols (xPos, yPos) box list))
    | check == 4 = ((searchUp rows cols (xPos, yPos) box list) + (searchLeft rows cols (xPos, yPos) box list) + (searchNW rows cols (xPos, yPos) box list))
    | check == 5 = ((searchDown rows cols (xPos, yPos) box list) + (searchLeft rows cols (xPos, yPos) box list) + (searchRight rows cols (xPos, yPos) box list) + (searchSE rows cols (xPos, yPos) box list)+ (searchSW rows cols (xPos, yPos) box list))
    | check == 6 = ((searchUp rows cols (xPos, yPos) box list) + (searchLeft rows cols (xPos, yPos) box list) + (searchRight rows cols (xPos, yPos) box list) + (searchNW rows cols (xPos, yPos) box list) + (searchNE rows cols (xPos, yPos) box list))
    | check == 7 = ((searchUp  rows cols (xPos, yPos) box list) + (searchDown rows cols (xPos, yPos) box list) + (searchRight rows cols (xPos, yPos) box list) + (searchNE  rows cols (xPos, yPos) box list)+ (searchSE rows cols (xPos, yPos) box list))
    | check == 8 = ((searchUp rows cols (xPos, yPos) box list) + (searchDown rows cols (xPos, yPos) box list) + (searchLeft rows cols (xPos, yPos) box list) + (searchNW rows cols (xPos, yPos) box list) + (searchSW rows cols (xPos, yPos) box list))
    | otherwise = ((searchUp rows cols (xPos, yPos) box list) + (searchDown rows cols (xPos, yPos) box list) + (searchLeft rows cols (xPos, yPos) box list) + (searchRight rows cols (xPos, yPos) box list) + (searchNW rows cols (xPos, yPos) box list) + (searchSW rows cols (xPos, yPos) box list)+ (searchNE rows cols (xPos, yPos) box list) + (searchSE rows cols (xPos, yPos) box list))
    -- | otherwise = 0
            where
                check = (posChecker rows cols (xPos, yPos))

-- all these functions just call search with the relative position
searchDown :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchDown rows cols (xPos, yPos) box list = search rows cols (xPos, (yPos+1)) box list

searchUp :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchUp rows cols (xPos, yPos) box list = search rows cols (xPos, (yPos-1)) box list

searchLeft :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchLeft rows cols (xPos, yPos) box list = search rows cols ((xPos-1), yPos) box list

searchRight :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchRight rows cols (xPos, yPos) box list = search rows cols ((xPos+1), yPos) box list

searchNW :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchNW rows cols (xPos, yPos) box list = search rows cols ((xPos-1), (yPos-1)) box list

searchSW :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchSW rows cols (xPos, yPos) box list = search rows cols ((xPos-1), (yPos+1)) box list

searchNE :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchNE rows cols (xPos, yPos) box list = search rows cols ((xPos+1), (yPos-1)) box list

searchSE :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
searchSE rows cols (xPos, yPos) box list = search rows cols ((xPos+1), (yPos+1)) box list

-- indexes the start of iteration to 1 1
search :: Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
search rows cols (xPos, yPos) box list = searchInner rows cols (xPos, yPos) (1, 1) box list

-- if searching for adjacent hidden numbers, will count mines (No x) (Flag x)
-- searchInner _ _ xPos yPos xPos yPos (x:xs) = mineCheck x

-- doesnt match box == x because then it will discriminated against values inside like (No 1) wouldnt match (No (-1))
searchInner :: Int -> Int -> (Int, Int) -> (Int, Int) -> Box -> [Box] -> Int
searchInner _ _ _ _ _ [] = 0
searchInner rows cols (targetX, targetY) (xPos, yPos) box [x]
    | ((targetX, targetY) == (xPos, yPos) && box == Mine) = mineCheck x
    | ((targetX, targetY) == (xPos, yPos) && box == ZeroAdjacent) = zeroCheck x
    | ((targetX, targetY) == (xPos, yPos) && flagCheck box ==1) = flagCheck x
    | ((targetX, targetY) == (xPos, yPos) && hiddenCheck box == 1 &&  (hiddenCheck x ==1) ) = 1
    | otherwise = 0
searchInner rows cols (targetX, targetY) (xPos, yPos) box (x:xs)
    | (targetX == xPos && targetY == yPos&& box == Mine) = mineCheck x
    | (targetX == xPos && targetY == yPos&& box == ZeroAdjacent) = zeroCheck x
    | (targetX == xPos && targetY == yPos&& flagCheck box ==1) = flagCheck x
    | (targetX == xPos && targetY == yPos&& hiddenCheck box == 1 &&  (hiddenCheck x ==1)) = 1
    | otherwise = searchInner rows cols (targetX, targetY) (newXPos, newYPos) box xs
        where
            (newXPos, newYPos) = xyIncrement cols (xPos, yPos)

-- box is hidden if box is a Number (not a shown number) or Mine
hiddenCheck :: Box -> Int
hiddenCheck (No _) = 1
hiddenCheck Mine = 1
hiddenCheck _ = 0

zeroCheck :: Box -> Int
zeroCheck ZeroAdjacent = 1
zeroCheck _ = 0

flagCheck :: Box -> Int
flagCheck (Flag _) = 1
flagCheck _ = 0

mineCheck :: Box -> Int
mineCheck Boom = 1
mineCheck Mine = 1
mineCheck (Flag x) = mineCheck x
mineCheck _ = 0

-- returns the position the box is in, relative to the board
posChecker :: Int -> Int -> (Int, Int) -> Int
posChecker rows cols (xPos, yPos)
    | (xPos == 1 && yPos == 1) = 1 -- top left
    | (cols == xPos && yPos == 1) = 2 --top right
    | (rows == yPos && xPos == 1) = 3 --bottom left
    | (rows == yPos && cols == xPos) = 4 --bottom right
    | (yPos == 1) = 5 --top row
    | (cols == yPos) = 6 -- bottom row
    | (xPos == 1) = 7 -- left side
    | (cols == xPos) = 8 -- right side
    | otherwise = 0 -- not touching any side

boxToInt :: Box -> Int
boxToInt (No x) = x
boxToInt (Shown x) = x
boxToInt _ = -1 --will never get called

-- only used for testing to visualise the board
-- board + length of rows
rowMaker ::  Int -> [a] -> [[a]]
rowMaker rowLen list = rowMakerInternal list rowLen rowLen

-- list length rowsLeft
rowMakerInternal :: [a] -> Int -> Int-> [[a]]
rowMakerInternal [] _ _ = []
rowMakerInternal list len left
    | left > 0 =  (take len list) : rowMakerInternal newList len newLeft
    | otherwise = [list]
        where
            newList = rotateList len list
            newLeft = left - 1

-- will drop n amount from list
-- lengthtorotate list
rotateList :: Int -> [a] -> [a]
rotateList _ [] = []
rotateList 0 x = x
rotateList n (x:xs) = rotateList (n-1) xs

-- mines generator boxes
mineSim :: RandomGen g => Int -> g -> Int -> [Box]
mineSim m g x = intL2BoxL (createMines m g x (createScaler x))

-- will create a list of boxes from the list of 1s and 0s, mine if 1, empty if 0
intL2BoxL :: [Int] -> [Box]
intL2BoxL [] = []
intL2BoxL [x]
    | x == 1 = [Mine]
    | otherwise = [Empty]
intL2BoxL (x:xs)
    | x == 1 = (Mine) : intL2BoxL xs
    | otherwise = Empty : intL2BoxL xs

-- generates a list of ints with 1 being a mines and 0 empty
-- if the random number between 0 to the scaleRandom rolls a 0, a mine is placed
createMines :: RandomGen g => Int -> g -> Int -> Int -> [Int]
createMines _ _ 0 _ = []
createMines 0 generator x scaleRandom = 0 : createMines 0 generator (x-1) scaleRandom
createMines m generator x scaleRandom
    | m >= x = 1 : createMines (m-1) generator (x-1) scaleRandom
    | otherwise = mineChance : createMines minesLeft newGenerator (x-1) scaleRandom
        where
           (r, newGenerator) = randomR (0, scaleRandom) generator
           mineChance = placeMineIfZero r
           minesLeft = m-mineChance

-- the random number will be from 0 to the number returned here
createScaler :: Int -> Int
createScaler x
    | x > 400 = 5
    | x > 300 = 6
    | x > 200 = 7
    | otherwise = 10

-- very similar to pressBox
flagBox :: Int -> Int -> MVar GameState -> IO GameState
flagBox xPos yPos gem = do
    gameState <- liftIO (takeMVar gem)
    let x = flagBoxInternal (xPos, yPos) gameState
    liftIO $ putMVar gem x
    return x

-- if you flag, it will decrement flag count, if you unflag will decrement
-- if position is invalid (-1, -1) will return the same gamestate that it took in
flagBoxInternal :: (Int, Int) -> GameState -> GameState
flagBoxInternal (-1, -1) samegs = samegs
flagBoxInternal (xPos, yPos) (GameState (Board x) rows cols flagsLeft _ winc) = GameState {
        board = Board (box1)
      , rows = rows
      , cols = cols
      , flagCount = (flagsLeft + (flagpicker (countFlag x) (countFlag box1)))
      , losscheck = lossCheck box1
      , wincheck = winc
    }
        where box1 = (flagInternal flagsLeft cols xPos yPos (1, 1) x)

--  flagCountBefore flagCountAfter
-- whatever is returned is added to flagsLeft
flagpicker :: Int -> Int -> Int
flagpicker x y
    | x > y = (1)
    | x < y = (-1)
    | otherwise = 0

-- returns amount of Flags on board
countFlag :: [Box] -> Int
countFlag x = (countFlagInternal x 0)

countFlagInternal :: [Box] -> Int -> Int
countFlagInternal [] count = count
countFlagInternal [Flag x] count = (count+1)
countFlagInternal [x] count = count
countFlagInternal ((Flag x):xs) count = countFlagInternal xs (count+1)
countFlagInternal (_:xs) count = countFlagInternal xs count

-- wont flag mines or open numbers, will unflag a flag if a flag is already there
flagInternal :: Int -> Int -> Int -> Int -> (Int, Int) -> [Box] -> [Box]
flagInternal flagsLeft cols targetX targetY (xPos, yPos) [Mine]
    | flagsLeft > 0 = [Flag Mine]
    | otherwise = [Mine]
flagInternal flagsLeft cols targetX targetY (xPos, yPos) [(No x)]
    | flagsLeft > 0 = [Flag (No x)]
    | otherwise = [(No x)]
flagInternal flagsLeft cols targetX targetY (xPos, yPos) [(Flag x)] = [x]
flagInternal flagsLeft cols targetX targetY (xPos, yPos) [x] = [x]
flagInternal flagsLeft cols targetX targetY (xPos, yPos) ((Flag x):xs)
    | (targetX == xPos && targetY == yPos) = x : xs
    | otherwise = (Flag x) : flagInternal flagsLeft cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
flagInternal flagsLeft cols targetX targetY (xPos, yPos) (Mine:xs)
    | (targetX == xPos && targetY == yPos && flagsLeft > 0) = (Flag Mine) : xs
    | otherwise = Mine : flagInternal flagsLeft cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
flagInternal flagsLeft cols targetX targetY (xPos, yPos) ((No x):xs)
    | (targetX == xPos && targetY == yPos && flagsLeft >0) = (Flag (No x)) : xs
    | otherwise = (No x) : flagInternal flagsLeft cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
flagInternal flagsLeft cols targetX targetY (xPos, yPos) (x:xs)
    | (targetX == xPos && targetY == yPos) = x : xs
    | otherwise = x : flagInternal flagsLeft cols targetX targetY (xyIncrement cols (xPos, yPos)) xs

openIfBesideAdjacent :: Int -> Int -> (Int, Int) -> [Box] -> [Box] -> [Box]
openIfBesideAdjacent rows cols (xPos, yPos) [] wholeList = []
openIfBesideAdjacent rows cols (xPos, yPos) [(No x)] wholeList
    | (countAdjacentBox rows cols (xPos, yPos) ZeroAdjacent wholeList) >0 = [Shown (boxToInt (No x))]
    | otherwise = [No x]
openIfBesideAdjacent rows cols (xPos, yPos) [x] wholeList = [x]
openIfBesideAdjacent rows cols (xPos, yPos) ((No x):xs) wholeList
    | (xPos == cols && yPos == rows && (countAdjacentBox rows cols (xPos, yPos) ZeroAdjacent wholeList)>0) = [Shown (boxToInt (No x))]
    | (countAdjacentBox rows cols (xPos, yPos) ZeroAdjacent wholeList)>0 = Shown (boxToInt (No x)) : openIfBesideAdjacent rows cols (xyIncrement cols (xPos, yPos)) xs wholeList
    | otherwise = No x : openIfBesideAdjacent rows cols (xyIncrement cols (xPos, yPos)) xs wholeList
openIfBesideAdjacent rows cols (xPos, yPos) (x:xs) wholeList = x : openIfBesideAdjacent rows cols (xyIncrement cols (xPos, yPos)) xs wholeList

checkIfBoxIsNo :: Box -> Int
checkIfBoxIsNo (No x) = 1
checkIfBoxIsNo _ = 0

-- takes in coordinates and gamestate, opens this box
pressBox :: Int -> Int -> MVar GameState -> IO GameState
pressBox xPos yPos gem = do
    gameState <- liftIO (takeMVar gem)
    let newgs = (pressBoxInternal (xPos, yPos) gameState)
    let x = updateEmptys newgs (xPos, yPos)
    liftIO $ putMVar gem x
    return x


pressBoxInternal :: (Int, Int) -> GameState -> GameState
pressBoxInternal (xPos, yPos) (GameState (Board x) rows cols flagCount _ _) = GameState {
        board = Board newBox
      , rows = rows
      , cols = cols
      , flagCount = flagCount
      , losscheck = lossCheck newBox
      , wincheck = checkWin newBox
    }
        where newBox = (pressInternal cols xPos yPos (1, 1) x)

-- wont open a flag, zeroadjacent(shown 0)
pressInternal :: Int -> Int -> Int -> (Int, Int) -> [Box] -> [Box]
pressInternal cols targetX targetY (xPos, yPos) [(No 0)]
    | (targetX == xPos && targetY == yPos) = [ZeroAdjacent]
    | otherwise = [(No 0)]
pressInternal cols targetX targetY (xPos, yPos) [(No x)]
    | (targetX == xPos && targetY == yPos) = [Shown (boxToInt (No x))]
    | otherwise = [(No x)]
pressInternal cols targetX targetY (xPos, yPos) [(Mine)] = [Boom]
pressInternal cols targetX targetY (xPos, yPos) [Boom] = [Boom]
pressInternal _ _ _ _ [x] = [x]
pressInternal cols targetX targetY (xPos, yPos)  ((Flag x) :xs)
    | (targetX == xPos && targetY == yPos) = (Flag x) : xs
    | otherwise = (Flag x) : pressInternal cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
pressInternal cols targetX targetY (xPos, yPos) ((No x):xs)
    | (targetX == xPos && targetY == yPos && x == 0) = ZeroAdjacent : xs
    | (targetX == xPos && targetY == yPos) = Shown (boxToInt (No x)) : xs
    | otherwise = (No x) : pressInternal cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
pressInternal cols targetX targetY (xPos, yPos) (ZeroAdjacent:xs)
    | (targetX == xPos && targetY == yPos) = ZeroAdjacent : xs
    | otherwise = ZeroAdjacent : pressInternal cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
pressInternal cols targetX targetY (xPos, yPos) (x:xs)
    | (targetX == xPos && targetY == yPos) =
        case (x == (Mine) || x == Boom) of
                    True -> Boom : xs
                    False -> (Shown (boxToInt x)) : xs
    | otherwise = x : pressInternal cols targetX targetY (xyIncrement cols (xPos, yPos)) xs

-- if you open a (No 0) box, it will be opened as ZeroAdjacent and this will check if
updateEmptys :: GameState -> (Int, Int) -> GameState
updateEmptys (GameState (Board x) rows cols flagCount losscheck wincheck) (xPos, yPos)
    | ((checkIfOpenedZero cols xPos yPos (1, 1) x) == 1) = newgs
    | otherwise = oldgs
        where
            oldgs = (GameState (Board x) rows cols flagCount losscheck wincheck)
            newBoxL1 = (beginFixing rows cols (xPos, yPos) x)
            newBoard = openIfBesideAdjacent rows cols (1, 1) newBoxL1 newBoxL1
            newgs = (GameState (Board newBoard) rows cols flagCount losscheck wincheck)

-- initially gets called from updateEmptys if you open a box that has no mines adjacent, this will open all the
-- surrounding boxes which also have no mines adjacent
-- calls emptyFix in different directions
-- will be called recursively from emptyFix
beginFixing :: Int -> Int -> (Int, Int) -> [Box] -> [Box]
beginFixing rows cols (xPos, yPos) list = se
    where
        up = emptyFix rows cols xPos (yPos-1) (1, 1) list list
        down = emptyFix rows cols (xPos) (yPos+1) (1, 1) up up
        left = emptyFix rows cols (xPos-1) yPos (1, 1) down down
        right = emptyFix rows cols (xPos+1) yPos (1, 1) left left
        nw = emptyFix rows cols (xPos-1) (yPos-1) (1, 1) right right
        sw = emptyFix rows cols (xPos-1) (yPos+1) (1, 1) nw nw
        ne = emptyFix rows cols (xPos+1) (yPos-1) (1, 1) sw sw
        se = emptyFix rows cols (xPos+1) (yPos+1) (1, 1) ne ne

-- open target box if it is (No 0), change it to ZeroAdjacent
emptyFix :: Int -> Int -> Int -> Int -> (Int, Int) -> [Box] -> [Box] -> [Box]
emptyFix rows cols targetX targetY (xPos, yPos) [(No 0)] wholeList
    | ((targetOutOfBounds rows cols (xPos, yPos)) == 1) = wholeList
    | (targetX == xPos && targetY == yPos) = (beginFixing rows cols (xPos, yPos) a)
    | otherwise = wholeList
        where a = (makePosIntoDesiredBox cols targetX targetY (1, 1) ZeroAdjacent wholeList)
emptyFix rows cols targetX targetY (xPos, yPos) [(ZeroAdjacent)] wholeList
    | ((targetOutOfBounds rows cols (xPos, yPos)) == 1) = wholeList
    | (targetX == xPos && targetY == yPos) = wholeList --(beginFixing rows cols (xPos, yPos) (makePosIntoDesiredBox cols targetX targetY (1, 1) wholeList))
    | otherwise = wholeList
emptyFix rows cols targetX targetY (xPos, yPos) [x] wholeList= wholeList
emptyFix rows cols targetX targetY (xPos, yPos) ((ZeroAdjacent) : xs) wholeList
    | ((targetOutOfBounds rows cols (xPos, yPos)) == 1) = wholeList
    | (targetX == xPos && targetY == yPos) = wholeList --(beginFixing rows cols (xPos, yPos) (makePosIntoDesiredBox cols targetX targetY (1, 1) wholeList))
    | otherwise = emptyFix rows cols targetX targetY (xyIncrement cols (xPos, yPos)) xs wholeList
emptyFix rows cols targetX targetY (xPos, yPos) ((No 0) : xs) wholeList
    | ((targetOutOfBounds rows cols (xPos, yPos)) == 1) = wholeList
    | (targetX == xPos && targetY == yPos) =  beginFixing rows cols (xPos, yPos) (makePosIntoDesiredBox cols targetX targetY (1, 1) ZeroAdjacent wholeList)
    | otherwise = emptyFix rows cols targetX targetY (xyIncrement cols (xPos, yPos)) xs wholeList
emptyFix rows cols targetX targetY (xPos, yPos) (x:xs) wholeList
    | ((targetOutOfBounds rows cols (xPos, yPos)) == 1) = wholeList
    | (targetX == xPos && targetY == yPos) = wholeList
    | otherwise = emptyFix rows cols targetX targetY (xyIncrement cols (xPos, yPos)) xs wholeList

-- 1 if out of bounds
targetOutOfBounds :: Int -> Int -> (Int, Int) -> Int
targetOutOfBounds rows cols (xPos, yPos)
    | xPos > cols = 1
    | yPos > rows = 1
    | xPos < 1 = 1
    | yPos < 1 = 1
    | otherwise = 0

-- give BoxList, box type and position, return 1 if that box type is at position, 0 otherwise
checkIfPosIsBox :: Int -> Int -> Int -> (Int, Int) -> Box -> [Box] -> Int
checkIfPosIsBox cols targetX targetY (xPos, yPos) box [x]
    | (targetX == xPos && targetY == yPos && hiddenCheck box == 1 &&(hiddenCheck x ==1 )) = 1
    | (targetX == xPos && targetY == yPos && box == x) = 1
    | otherwise = 0
checkIfPosIsBox cols targetX targetY (xPos, yPos) box (x:xs)
    | (targetX == xPos && targetY == yPos && hiddenCheck box == 1 &&(hiddenCheck x ==1 )) = 1
    | (targetX == xPos && targetY == yPos && box == x) = 1
    | otherwise = checkIfPosIsBox cols targetX targetY (xyIncrement cols (xPos, yPos)) box xs

-- return boxList with the box in target pos, changed to the inputted box parameter
makePosIntoDesiredBox :: Int -> Int -> Int -> (Int, Int) -> Box -> [Box] -> [Box]
makePosIntoDesiredBox cols targetX targetY (xPos, yPos) box [x]
    | (targetX == xPos && targetY == yPos) = [box]
    | otherwise = [x]
makePosIntoDesiredBox cols targetX targetY (xPos, yPos) box (x:xs)
    | (targetX == xPos && targetY == yPos) = box : xs
    | otherwise = x : makePosIntoDesiredBox cols targetX targetY (xyIncrement cols (xPos, yPos)) box xs

-- 1 if target is ZeroAdjacent
checkIfOpenedZero :: Int -> Int -> Int -> (Int, Int) -> [Box] -> Int
checkIfOpenedZero _ _ _ _ [ZeroAdjacent]  = 1
checkIfOpenedZero _ _ _ _ [x]  = 0
checkIfOpenedZero cols targetX targetY (xPos, yPos) (ZeroAdjacent:xs)
    | (targetX == xPos && targetY == yPos) = 1
    | otherwise = checkIfOpenedZero cols targetX targetY (xyIncrement cols (xPos, yPos)) xs
checkIfOpenedZero cols targetX targetY (xPos, yPos) (x:xs)
    | (targetX == xPos && targetY == yPos) = 0
    | otherwise = checkIfOpenedZero cols targetX targetY (xyIncrement cols (xPos, yPos)) xs

-- check Box list have we lost
lossCheck :: [Box] -> Int
lossCheck [Boom] = 1
lossCheck [x] = 0
lossCheck (Boom:xs) = 1
lossCheck (x:xs) = lossCheck xs

-- if the random number gen lands on 0, return 1 for mine spawn
placeMineIfZero :: Int -> Int
placeMineIfZero x
    | x < 1 = 1
    | otherwise = 0

-- will open random if its not certain
autoOpen :: MVar GameState -> IO GameState
autoOpen gam = do
    (GameState (Board x) rows cols flagsLeft ls wc) <- liftIO (takeMVar gam)
    let (xPos, yPos) = (opener flagsLeft rows cols (1,1) x x [])
    let newgs = pressBoxInternal (xPos, yPos) (GameState (Board x) rows cols flagsLeft ls wc)
    let x2 = updateEmptys newgs (xPos, yPos)
    liftIO $ putMVar gam x2
    return x2

-- isnt unfairly avoiding mines as it checker for (No x) and Mine and does the same thing
opener :: Int -> Int -> Int -> (Int, Int) -> [Box] -> [Box] -> [Int] -> (Int, Int)
opener flagsLeft rows cols (xPos, yPos) []  wholeList mineChanceList = indexToCoordInternal rows cols (findLowestMineChance 100 0 0 mineChanceList)
opener flagsLeft rows cols (xPos, yPos) [x] wholeList mineChanceList
    | mineChanceChecker flagsLeft rows cols (xPos, yPos) wholeList == 0 = (xPos, yPos)
    | otherwise = indexToCoordInternal rows cols (findLowestMineChance 100 0 0 mineChanceList)
opener flagsLeft rows cols (xPos, yPos) ((No x):xs) wholeList mineChanceList
    | mineChanceChecker flagsLeft rows cols (xPos, yPos) wholeList == 0 = (xPos, yPos)
    | otherwise = opener flagsLeft rows cols (xyIncrement cols (xPos, yPos)) xs wholeList (mineChanceList ++ [(mineChanceChecker flagsLeft rows cols (xPos, yPos) wholeList)])
opener flagsLeft rows cols (xPos, yPos) ((Mine):xs) wholeList mineChanceList
    | mineChanceChecker flagsLeft rows cols (xPos, yPos) wholeList == 0 = (xPos, yPos)
    | otherwise = opener flagsLeft rows cols (xyIncrement cols (xPos, yPos)) xs wholeList (mineChanceList ++ [(mineChanceChecker flagsLeft rows cols (xPos, yPos) wholeList)])
opener flagsLeft rows cols (xPos, yPos) (x:xs) wholeList mineChanceList = opener flagsLeft rows cols (xyIncrement cols (xPos, yPos)) xs wholeList (mineChanceList ++ [150])

-- (Flag Empty) is put in but when searching for Flag it will match any (Flag Box)
mineChanceChecker :: Int -> Int -> Int -> (Int, Int) -> [Box] -> Int
mineChanceChecker flagsLeft rows cols (xPos, yPos) wholeList
    | searchUp rows cols (xPos, yPos) (No (-1)) wholeList == 0 && (searchNE rows cols (xPos, yPos) (Flag Empty) wholeList == 0 || searchNW rows cols (xPos, yPos) (Flag Empty) wholeList == 0 ) = 0
    | searchDown rows cols (xPos, yPos) (No (-1)) wholeList  == 0 && (searchSE rows cols (xPos, yPos) (Flag Empty) wholeList == 0 || searchSW rows cols (xPos, yPos) (Flag Empty) wholeList == 0 ) = 0
    | searchLeft rows cols (xPos, yPos) (No (-1)) wholeList  == 0 && (searchSW rows cols (xPos, yPos) (Flag Empty) wholeList == 0 || searchNW rows cols (xPos, yPos) (Flag Empty) wholeList == 0 ) = 0
    | searchRight rows cols (xPos, yPos) (No (-1)) wholeList == 0 && (searchNE rows cols (xPos, yPos) (Flag Empty) wholeList == 0 || searchSE rows cols (xPos, yPos) (Flag Empty) wholeList == 0 ) = 0
    | searchUp rows cols (xPos, yPos) (Flag Empty) wholeList == 0 && (searchNE rows cols (xPos, yPos) (No (-1)) wholeList == 0 || searchNW rows cols (xPos, yPos) (No (-1)) wholeList == 0 ) = 0
    | searchDown rows cols (xPos, yPos) (Flag Empty) wholeList == 0 && (searchSE rows cols (xPos, yPos) (No (-1)) wholeList == 0 || searchSW rows cols (xPos, yPos) (No (-1)) wholeList == 0 ) = 0
    | searchLeft rows cols (xPos, yPos) (Flag Empty) wholeList == 0 && (searchSW rows cols (xPos, yPos) (No (-1)) wholeList == 0 || searchNW rows cols (xPos, yPos) (No (-1)) wholeList == 0 ) = 0
    | searchRight rows cols (xPos, yPos) (Flag Empty) wholeList == 0 && (searchNE rows cols (xPos, yPos) (No (-1)) wholeList == 0 || searchSE rows cols (xPos, yPos) (No (-1)) wholeList == 0 ) = 0
    | (posChecker rows cols (xPos, yPos) == 1 || posChecker rows cols (xPos, yPos) == 2 || posChecker rows cols (xPos, yPos) == 7) = 8
    | otherwise = weightedDiv flagsLeft (countHidden 0 wholeList)

-- divides ints and returns a ceiling, is multiplied by 100 to make values easier to work with as ints
weightedDiv :: Int -> Int -> Int
weightedDiv a b =
      let x = (fromIntegral a) * 100
          y = fromIntegral b
      in ceiling (x / y)

-- returns index which is starting at 0
findLowestMineChance :: Int -> Int -> Int -> [Int] -> Int
findLowestMineChance highest highestIndex pos [x]
    | x < highest = (pos+1)
    | otherwise = highestIndex
findLowestMineChance highest highestIndex  pos (x:xs)
    | x < highest = findLowestMineChance x pos (pos+1) xs
    | otherwise = findLowestMineChance highest highestIndex (pos+1) xs

-- wont force a flag unless its almost certain
autoFlag :: MVar GameState -> IO GameState
autoFlag gam = do
    (GameState (Board x) rows cols flagsLeft ls wc) <- liftIO (takeMVar gam)
    let x2 = flagBoxInternal (flagSearcher rows cols (1,1) x x) (GameState (Board x) rows cols flagsLeft ls wc)
    liftIO $ putMVar gam x2
    return x2

-- determines some obvious moves No -1 is searched for as it doesnt matter whats inside (No x)
-- searching for No will also count Mine as it doesnt discriminate againt any hidden boxes
flagSearcher :: Int -> Int -> (Int, Int) -> [Box] -> [Box] -> (Int, Int)
flagSearcher rows cols (xPos, yPos) [] wholeList = (-1, -1)
flagSearcher rows cols (xPos, yPos) [(Shown x)] wholeList
    | x==5 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-4) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 1= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==5 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-3) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 2= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==5 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-2) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 3= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==5 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-1) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 4= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==4 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-1) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 3= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==4 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-2) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 2= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==4 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-3) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 1 = posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==3 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-2) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 1 = posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==3 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-1) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 2= posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | x==2 && countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList== (x-1) && countAdjacentBox rows cols (xPos, yPos) (Flag (No (-1))) wholeList == 1 = posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | (countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList)== x = posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | otherwise = (-1,-1)
flagSearcher rows cols (xPos, yPos) [x] wholeList = (-1,-1) -- for debug rn
flagSearcher rows cols (xPos, yPos) ((Shown x):xs) wholeList
    | countAdjacentBox rows cols (xPos, yPos) (No (-1)) wholeList == x = posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | otherwise = flagSearcher rows cols (xyIncrement cols (xPos, yPos)) xs wholeList
flagSearcher rows cols (xPos, yPos) (_:xs) wholeList = flagSearcher rows cols (xyIncrement cols (xPos, yPos)) xs wholeList

-- returns position of first adjacent hidden number
posOfClosestHiddenNo :: Int -> Int -> (Int, Int) -> [Box] -> (Int, Int)
posOfClosestHiddenNo rows cols (xPos, yPos) wholeList
    | targetOutOfBounds rows cols (xPos+1, yPos) == 0 && checkIfPosIsBox cols (xPos+1) yPos (1,1) (No (-1)) wholeList ==1 = (xPos+1, yPos)
    | targetOutOfBounds rows cols (xPos-1, yPos) == 0 && checkIfPosIsBox cols (xPos-1) yPos (1,1) (No (-1)) wholeList ==1 = (xPos-1, yPos)
    | targetOutOfBounds rows cols (xPos, yPos+1) == 0 && checkIfPosIsBox cols (xPos) (yPos+1) (1,1) (No (-1)) wholeList ==1 = (xPos, yPos+1)
    | targetOutOfBounds rows cols (xPos, yPos-1) == 0 && checkIfPosIsBox cols (xPos) (yPos-1) (1,1) (No (-1)) wholeList ==1 = (xPos, yPos-1)
    | targetOutOfBounds rows cols (xPos+1, yPos-1) == 0 && checkIfPosIsBox cols (xPos+1) (yPos-1) (1,1) (No (-1)) wholeList ==1 = (xPos+1, yPos-1)
    | targetOutOfBounds rows cols (xPos+1, yPos+1) == 0 && checkIfPosIsBox cols (xPos+1) (yPos+1) (1,1) (No (-1)) wholeList ==1 = (xPos+1, yPos+1)
    | targetOutOfBounds rows cols (xPos-1, yPos+1) == 0 && checkIfPosIsBox cols (xPos-1) (yPos+1) (1,1) (No (-1)) wholeList ==1 = (xPos-1, yPos+1)
    | targetOutOfBounds rows cols (xPos-1, yPos-1) == 0 && checkIfPosIsBox cols (xPos-1) (yPos-1) (1,1) (No (-1)) wholeList ==1 = (xPos-1, yPos-1)
    | otherwise = (-1, -1)


-- counts all boxes with unopened numbers
countHidden :: Int -> [Box] -> Int
countHidden count [] = count
countHidden count [(No x)] = count+1
countHidden count [x] = count
countHidden count (No x:xs) = countHidden (count+1) xs
countHidden count (x:xs) = countHidden count xs