module Genetics where

import Data.List (sortBy)
import Random (randomRIO)

class Gene g where
	-- How ideal is the gene from 0.0 to 1.0?
	fitness :: g -> Float

	-- How often will the gene mutate from 0.0 to 1.0?
	mutability :: g -> Float

	-- By which factor will the best candidates in a pool
	-- replace the worst (2x, 3x, 4x, ...)?
	-- Note that the pool must be larger than the factor,
	-- e.g. [g1, g2, g3, g4] with factor 2x becomes [g1, g2, g1, g2].
	advantage :: [g] -> Int

	-- How does a gene mutate?
	mutate :: g -> IO g

orderFitness :: (Gene g) => [g] -> [g]
orderFitness = reverse . sortBy (\a b -> compare (fitness a) (fitness b))

mutate' :: (Gene g) => g -> IO g
mutate' gene = do
	r <- randomRIO (0, 1.0)

	if (r < mutability gene) then do
		gene' <- mutate gene

		return gene'
	else do
		return gene

compete :: (Gene g) => [g] -> IO [g]
compete pool = do
	pool' <- mapM mutate' pool
	let winners = take ((length pool') `div` (advantage pool')) $ orderFitness pool'
	return $ concat $ replicate (advantage winners) winners

evolve :: (Gene g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = do
	pool' <- compete pool
	evolve (n - 1) pool'