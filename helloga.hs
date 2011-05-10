#!/usr/bin/env runhaskell

{-# LANGUAGE TypeSynonymInstances #-}

import Genetics
import Control.Monad (replicateM)
import Random (randomRIO)
import Char (ord, chr)

target :: String
target = "helloworld"

randomChar :: IO Char
randomChar = do
	c <- randomRIO (0, 25)
	let c' = (ord 'a') + c
	return $ chr c'

randomGene :: IO String
randomGene = replicateM (length target) randomChar

numSpecies :: Int
numSpecies = 8

instance Gene String where
	fitness gene = (sum $ zipWith (\t g -> if t == g then 1 else 0) target gene) / (fromIntegral (length target))

	mutate gene = do
		index <- randomRIO (0, length target - 1)
		ch <- randomChar
		let gene' = (take index gene) ++ [ch] ++ (drop (index + 1) gene)
		return gene'

	species pool = numSpecies

main :: IO ()
main = do
	let generations = 10000 -- 10 ^ 4
	pool <- replicateM numSpecies randomGene

	putStrLn $ "Target: " ++ target
	putStrLn $ "Pool size: " ++ show numSpecies
	putStrLn $ "Running " ++ show generations ++ " generations..."

	pool' <- evolve generations pool

	putStrLn $ "Current pool:\n" ++ unlines pool'