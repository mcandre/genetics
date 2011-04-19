#!/usr/bin/env runhaskell

import Genetics
import Control.Monad (replicateM)
import Random (randomRIO)
import Data.List (intercalate)
import Char (ord, chr)

type Gene = String

randomChar :: IO Char
randomChar = do
	c <- randomRIO (0, 25)
	let c' = (ord 'a') + c
	return $ chr c'

randomGene :: IO Gene
randomGene = replicateM 10 randomChar

mutate :: Gene -> IO Gene
mutate gene = do
	index <- randomRIO (0, 9)
	ch <- randomChar
	let gene' = (take index gene) ++ [ch] ++ (drop (index + 1) gene)

	return gene'

fitness :: Gene -> Float
fitness gene = (sum $ zipWith (\t g -> if t == g then 1 else 0) "helloworld" gene) / (fromIntegral 10)

main :: IO ()
main = do
	let generations = 10 ^ 4
	let mutationRate = 1.0
	let advantage = 8
	let poolSize = 256
	pool <- replicateM poolSize randomGene

	putStrLn $ "Target: helloworld"
	putStrLn $ "Mutation rate: " ++ show mutationRate
	putStrLn $ "Advantage: " ++ show advantage
	putStrLn $ "Pool size: " ++ show poolSize
	putStrLn $ "Running " ++ show generations ++ " generations..."

	pool' <- evolve generations mutationRate advantage fitness mutate pool

	putStrLn $ "Current pool:\n" ++ intercalate "\n" pool	

	let best = head $ orderFitness fitness pool'
	putStrLn $ "Best candidate: " ++ best