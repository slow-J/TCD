{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Main where
import System.Random
import Control.Monad
import Control.Monad.Random
import Web.Scotty
import Network.HTTP.Types
import Data.Text
import Paths_assignment2

import Control.Concurrent -- for mvar

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics

import           Network.Wai.Middleware.RequestLogger (logStdoutDev)

import Lib

main = do
    putStrLn "enter value for mines: "
    input1  <- getLine
    putStrLn "enter value for columns(wide): "
    input2  <- getLine
    putStrLn "enter value for rows(down): "
    input3  <- getLine

    let mines = (read input1 :: Int)
    let cols = (read input2 :: Int)
    let rows = (read input3 :: Int)
    let boxes = cols * rows

    seed <- liftIO newStdGen

    -- if you want seed to be set manually

    -- putStrLn "enter value for seed: "
    -- input4  <- getLine
    -- let seed = (read input4 :: Int)

    -- need this if manually doing seed
    -- generator <- newStdGen
    -- (mkStdGen seed) instead of (seed) below

    -- creates a list of boxes
    let boxList = mineSim mines (seed) boxes ::[Box]

    -- putStrLn (show( boxList))
    privateBoard <- newMVar (privateGameStateFromBoxL rows cols mines boxList)
    -- putStrLn (show( privateGameStateFromBoxL rows cols mines boxList))
    -- putStrLn (show( rowMaker cols (gameStateToBoxL (privateGameStateFromBoxL rows cols mines boxList))))
    scotty 3000 $ do
        middleware logStdoutDev

        get "/favicon.ico" $ do
            foo <- liftIO $ getDataFileName "src/static/favicon.ico"
            setHeader "Content-Type" "image/x-icon"
            file foo

        post "/newMatch" $ do
            -- new random match setup
            seed <- liftIO newStdGen
            let boxList2 = mineSim mines (seed) boxes ::[Box]
            let boxes2 = 81

            let x = (privateGameStateFromBoxL rows cols mines boxList2)
            discard <- liftIO $ takeMVar privateBoard
            liftIO $ putMVar privateBoard x
            json $ (x :: GameState)

        get "/gameState" $ do
            x <- liftIO $ takeMVar privateBoard
            liftIO $ putMVar privateBoard x
            json $ (x :: GameState)

        -- open box request, parameter = index of box to be opened
        -- index staring at 1 as seen on the displayed board in the browser
        post "/leftclick/:index" $ do
            index <- param "index"
            let (x, y) = indexToCoord index rows cols
            mov <- liftIO $ pressBox x y privateBoard
            json $ (mov :: GameState)

        -- flag box request, parameter = index of box to be opened
        -- index staring at 1 as seen on the displayed board in the browser
        post "/rightclick/:index" $ do
            index <- param "index"
            let (x, y) = indexToCoord index rows cols
            mov <- liftIO $ flagBox x y privateBoard
            json $ (mov :: GameState)

        -- 1 ai move for opening
        -- will "guess" if no obvious move
        post "/autoOpen" $ do
            mov <- liftIO $ autoOpen privateBoard
            json $ (mov :: GameState)

        -- 1 ai move for flagging
        -- will not force
        post "/autoFlag" $ do
            mov <- liftIO $ autoFlag privateBoard
            json $ (mov :: GameState)

        -- serve static files
        get "/" $ do
            foo <- liftIO $ getDataFileName "src/static/index.html"
            setHeader "Content-Type" "text/html; charset=utf-8"
            file foo