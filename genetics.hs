module Genetics where

import Data.List (sortBy)
import Random (randomRIO)

class Gene g where
	-- How ideal is the gene from 0.0 to 1.0?
	fitness :: g -> Float

	-- How does a gene mutate?
	mutate :: g -> IO g

	-- How many species will be explored in each round?
	species :: [g] -> Int

orderFitness :: (Gene g) => [g] -> [g]
orderFitness = reverse . sortBy (\a b -> compare (fitness a) (fitness b))

compete :: (Gene g) => [g] -> IO [g]
compete pool = do
	variants <- (mapM (mapM mutate) . map (replicate (species pool))) pool
	return $ (map (head . orderFitness)) variants

evolve :: (Gene g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = compete pool >>= evolve (n - 1)