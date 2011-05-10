module Genetics where

import Data.List (sortBy)
import Random (randomRIO)
import Control.DeepSeq

class Gene g where
	-- How ideal is the gene from 0.0 to 1.0?
	fitness :: g -> Float

	-- How does a gene mutate?
	mutate :: g -> IO g

	-- How many species will be explored in each round?
	species :: [g] -> Int

orderFitness :: (Gene g, NFData g) => [g] -> [g]
orderFitness = reverse . sortBy (\a b -> compare (fitness a) (fitness b))

drift :: (Gene g, NFData g) => [g] -> IO [[g]]
drift pool = do
	let islands = map (replicate (species pool)) pool
	islands' <- mapM (mapM mutate) islands
	islands' `deepseq` return islands'

compete :: (Gene g, NFData g) => [g] -> IO [g]
compete pool = do
	variants <- drift pool
	return $ map (head . orderFitness) variants

evolve :: (Gene g, NFData g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = compete pool >>= evolve (n - 1)