{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Main where

import System.Random as Rand

import Genetics
import Control.Monad (replicateM)

target :: String
target = "Hello World!"

generations :: Int
generations = (2 :: Int) ^ (16 :: Int)

randomIndex :: IO Int
randomIndex = getStdRandom $ randomR (0, length target - 1)

randomChar :: IO Char
randomChar = getStdRandom $ randomR (' ', '~')

randomGene :: IO String
randomGene = replicateM (length target) randomChar

instance Gene String where
    fitness gene = sum correctScore / fromIntegral (length target)
        where correctScore = zipWith (\t g -> if t == g then 1 else 0) target gene

    mutate gene = do
        i <- randomIndex
        c <- randomChar
        return $ take i gene ++ [c] ++ drop (i + 1) gene

    species _ = 8

main :: IO ()
main = do
    pool <- replicateM (species [""]) randomGene
    pool' <- evolve generations pool
    putStrLn $ best pool'
