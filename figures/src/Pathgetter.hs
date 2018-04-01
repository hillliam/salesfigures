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
--
--
-----------------------------------------------------------------------------

module Pathgetter where

import System.Directory.PathWalk

data Date = Date Int Int Int deriving (Show)

--getorders :: Date -> Date -> String
--getorders start end = pathWalk "acem/orders/" ++ (makepath start end) $ \root dirs files -> do
--  forM_ files $ \file ->
--      putStrLn $ joinPath [root, file]
--
--makepath :: Date -> Date -> String
--makepath start end = undefined
