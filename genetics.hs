module Genetics (Gene, fitness, mutate, species, evolve) where

import Data.List (maximumBy)
import Data.Ord (comparing)

class Gene g where
	-- How ideal is the gene from 0.0 to 1.0?
	fitness :: g -> Float

	-- How does a gene mutate?
	mutate :: g -> IO g

	-- How many species will be explored in each round?
	species :: [g] -> Int

best :: (Gene g) => [g] -> g
best = maximumBy (comparing fitness)

drift :: (Gene g) => [[g]] -> IO [[g]]
drift = mapM (mapM mutate')
	where
		-- Prevents stack overflow
		mutate' :: (Gene g) => g -> IO g
		mutate' gene
			-- Don't mutate a perfect gene
			| fitness gene == 1.0 = return gene
			| otherwise = mutate gene

compete :: (Gene g) => [g] -> IO [g]
compete pool = drift (map (replicate (species pool)) pool) >>= return . map best

evolve :: (Gene g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = compete pool >>= evolve (n - 1)