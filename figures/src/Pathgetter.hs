-----------------------------------------------------------------------------
--
-- Module      :  Pathgetter
-- Copyright   :  2018 liam hill
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- a state monad that can be itorated to range between 2 dates
--
-----------------------------------------------------------------------------

module Pathgetter where

import Control.Monad
import System.Directory.PathWalk

data Date = Date Int Int Int deriving (Show)

--class Pathm f where
--     next :: (Date a) => f a -> f a -> f a

--tostring :: Date -> String
--tostring (d,m,y) = undefined

--getorders :: Date -> Date -> String
--getorders start end = pathWalk "acem/orders/" ++ (makepath start end) $ \root dirs files -> do
--  forM_ files $ \file ->
--      putStrLn $ joinPath [root, file]
--
--makepath :: Date -> Date -> String
--makepath start end = undefined
