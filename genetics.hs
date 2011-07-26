module Genetics where

import Data.List (maximumBy)
import Random (randomRIO)

pick :: [a] -> IO a
pick xs = randomRIO (0, length xs - 1) >>= return . (xs !!)

class Gene g where
	-- How ideal is the gene from 0.0 to 1.0?
	fitness :: g -> Float

	-- How does a gene mutate?
	mutate :: g -> IO g

	-- How many species will be explored in each round?
	species :: [g] -> Int

best :: (Gene g) => [g] -> g
best = maximumBy (\a b -> compare (fitness a) (fitness b))

-- Prevents stack overflow
mutate' :: (Gene g) => g -> IO g
mutate' gene = do
	gene' <- mutate gene

	-- Don't mutate a perfect gene
	if fitness gene == 1.0
		then return gene
		else gene' `seq` return gene'

drift :: (Gene g) => [[g]] -> IO [[g]]
drift = mapM (mapM mutate')

compete :: (Gene g) => [g] -> IO [g]
compete pool = do
	let islands = map (replicate (species pool)) pool
	islands' <- drift islands
	let representatives = map best islands'
	return representatives

evolve :: (Gene g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = compete pool >>= evolve (n - 1)