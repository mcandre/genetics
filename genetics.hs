module Genetics (Gene, fitness, mutate, species, evolve, best) where

import Data.Random (RVar, runRVar)
import Data.Random.Source.DevRandom

import Control.Parallel.Strategies (parMap, rseq)

import Control.Monad (liftM)

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

-- Prevents stack overflow
mutate' :: (Gene g) => g -> IO g
mutate' gene
-- Don't mutate a perfect gene
  | fitness gene /= 1.0 = mutate gene
  | otherwise = return gene

drift :: (Gene g) => [[g]] -> IO [[g]]
drift = mapM (mapM mutate')

compete :: (Gene g) => [g] -> IO [g]
compete pool
  | any ((/= 1.0) . fitness) pool = liftM (parMap rseq best) (drift (parMap rseq (replicate (species pool)) pool))
  | otherwise = return pool

evolve :: (Gene g) => Int -> [g] -> IO [g]
evolve 0 pool = return pool
evolve n pool = compete pool >>= evolve (n-1)
