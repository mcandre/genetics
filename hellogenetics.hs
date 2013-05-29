#!/usr/bin/env runhaskell

{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

import Genetics
import Data.Random
import Data.Random.Source.DevRandom
import Data.Random.List (randomElement)
import Control.Monad (replicateM)
import Data.Char (ord, chr)
import Data.List (sortBy)
import Data.Ord (comparing)

target :: String
target = "helloworld"

randomChar :: IO Char
randomChar = runRVar (randomElement ['a' .. 'z']) DevRandom

randomGene :: IO String
randomGene = replicateM (length target) randomChar

instance Gene String where
  fitness gene = (sum $ zipWith (\t g -> if t == g then 1 else 0) target gene) / (fromIntegral (length target))

  mutate gene = do
    index <- runRVar (randomElement [0 .. length target - 1]) DevRandom
    ch <- randomChar
    return $ take index gene ++ [ch] ++ drop (index + 1) gene

  species _ = 8

main :: IO ()
main = do
  let generations = 10 ^ 4
  pool <- replicateM (species [""]) randomGene
  pool' <- evolve generations pool
  putStrLn $ last $ sortBy (comparing fitness) pool'
