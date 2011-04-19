-- Define the following:
--
-- Gene
-- fitness
-- mutate

module Genetics where

import Data.List (sortBy)
import Random (randomRIO)

orderFitness :: (g -> Float) -> [g] -> [g]
orderFitness fitness = reverse . sortBy (\a b -> compare (fitness a) (fitness b))

compete :: Float -> Int -> (g -> Float) -> (g -> IO g) -> [g] -> IO [g]
compete rate advantage fitness mutate pool = do
	let mutate' gene = do
		r <- randomRIO (0, 1.0)

		if (r < rate) then do
			gene' <- mutate gene

			return gene'
		else do
			return gene

	pool' <- mapM mutate' pool
	let winners = take ((length pool') `div` advantage) $ orderFitness fitness pool'
	return $ concat $ replicate advantage winners

evolve :: Int -> Float -> Int -> (g -> Float) -> (g -> IO g) -> [g] -> IO [g]
evolve 0 _ _ _ _ pool = return pool
evolve n rate advantage fitness mutate pool = do
	pool' <- compete rate advantage fitness mutate pool
	evolve (n - 1) rate advantage fitness mutate pool'