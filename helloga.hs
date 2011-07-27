#!/usr/bin/env runhaskell

{-# LANGUAGE TypeSynonymInstances #-}

import Genetics
import Data.Random
import Data.Random.Source.DevRandom
import Data.Random.Extras
import Control.Monad (replicateM)
import Char (ord, chr)

target :: String
target = "helloworld"

randomChar :: IO Char
randomChar = runRVar (choice ['a'..'z']) DevRandom

randomGene :: IO String
randomGene = replicateM (length target) randomChar

instance Gene String where
	fitness gene = (sum $ zipWith (\t g -> if t == g then 1 else 0) target gene) / (fromIntegral (length target))

	mutate gene = do
		index <- runRVar (choice [0 .. length target - 1]) DevRandom
		ch <- randomChar
		return $ (take index gene) ++ [ch] ++ (drop (index + 1) gene)

	species _ = 8

main :: IO ()
main = do
	let generations = 10 ^ 4

	pool <- replicateM (species [""]) randomGene

	putStrLn $ "Target: " ++ target
	putStrLn $ "Pool size: " ++ show (species [""])
	putStrLn $ "Running " ++ show generations ++ " generations..."

	pool' <- evolve generations pool

	putStrLn $ "Current pool:\n" ++ unlines pool'