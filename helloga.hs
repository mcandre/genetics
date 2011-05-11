#!/usr/bin/env runhaskell

{-# LANGUAGE TypeSynonymInstances #-}

import Genetics
import Control.Monad (replicateM)
import Random (randomRIO)
import Char (ord, chr)

target :: String
target = "helloworld"

pick :: [a] -> IO a
pick xs = (randomRIO (0, length xs - 1)) >>= (return . (xs !!))

randomChar :: IO Char
randomChar = pick ['a'..'z']

randomGene :: IO String
randomGene = replicateM (length target) randomChar

numSpecies :: Int
numSpecies = 8

instance Gene String where
	fitness gene = (sum $ zipWith (\t g -> if t == g then 1 else 0) target gene) / (fromIntegral (length target))

	mutate gene = do
		index <- randomRIO (0, length target - 1)
		ch <- randomChar
		return $ (take index gene) ++ [ch] ++ (drop (index + 1) gene)

	species _ = numSpecies

main :: IO ()
main = do
	let generations = 10 ^ 4
	pool <- replicateM numSpecies randomGene

	putStrLn $ "Target: " ++ target
	putStrLn $ "Pool size: " ++ show numSpecies
	putStrLn $ "Running " ++ show generations ++ " generations..."

	pool' <- evolve generations pool

	putStrLn $ "Current pool:\n" ++ unlines pool'