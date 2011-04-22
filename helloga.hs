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

rate :: Float
rate = 1.0 --always mutate

factor :: Int
factor = 8

instance Gene String where
	fitness gene = (sum $ zipWith (\t g -> if t == g then 1 else 0) target gene) / (fromIntegral (length target))

	mutability _ = rate

	advantage _ = factor

	mutate gene = do
		index <- randomRIO (0, length target - 1)
		ch <- randomChar
		let gene' = (take index gene) ++ [ch] ++ (drop (index + 1) gene)

		return gene'

main :: IO ()
main = do
	let generations = 10 ^ 3
	let poolSize = 512
	pool <- replicateM poolSize randomGene

	putStrLn $ "Target: " ++ target
	putStrLn $ "Mutation rate: " ++ show rate
	putStrLn $ "Advantage: " ++ show factor
	putStrLn $ "Pool size: " ++ show poolSize
	putStrLn $ "Running " ++ show generations ++ " generations..."

	pool' <- evolve generations pool

	putStrLn $ "Current pool:\n" ++ unlines pool'

	let best = head $ orderFitness pool'
	putStrLn $ "Best candidate: " ++ best