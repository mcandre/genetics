module Genetics (Gene, fitness, mutate, species, evolve) where

import Data.List (maximumBy)

class Gene g where
	-- How ideal is the gene from 0.0 to 1.0?
	fitness :: g -> Float

	-- How does a gene mutate?
	mutate :: g -> IO g

	-- How many species will be explored in each round?
	species :: [g] -> Int

best :: (Gene g) => [g] -> g
best = maximumBy (\a b -> compare (fitness a) (fitness b))

drift :: (Gene g) => [[g]] -> IO [[g]]
drift = mapM (mapM mutate')
	where
		-- Prevents stack overflow
		mutate' :: (Gene g) => g -> IO g
		mutate' gene
			-- Don't mutate a perfect gene
			| fitness gene == 1.0 = return gene
			| otherwise = do
				gene' <- mutate gene
				gene' `seq` return gene'

compete :: (Gene g) => [g] -> IO [g]
compete pool = do
	islands <- drift (map (replicate (species pool)) pool)
	islands `seq` return $ map best islands

evolve :: (Gene g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = do
	pool' <- compete pool
	pool' `seq` evolve (n - 1) pool'