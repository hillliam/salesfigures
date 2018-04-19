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
import Data.Time.Calendar
import JSONParser_solution

--data Date = Date Int Int Int deriving (Show)

-- toGregorian

--class Pathm f where
--     next :: (Date a) => f a -> f a -> f a

--tostring :: Date -> String
--tostring (d,m,y) = undefined

firstday :: Day
firstday = fromGregorian 2015 02 02

lastday :: Day
lastday = fromGregorian 2017 12 31

--todatepath :: Day -> String
--todatepath date = do
--    let pair = toGregorian date
--    show (fst pair) ++ "/" ++ show (snd pair) ++ "/" ++ show (trd pair)

-- date range and function to perform to files
--getorders :: Day -> Day -> (JValue -> String) -> String
--getorders start end f = pathWalk "acem/orders/" ++  $ \root dirs files -> do
--  forM_ files $ \file ->
--      f file

-- makes the path for the current date
--gotocurrentfile :: Day -> (JValue -> String) -> String
--gotocurrentfile current f = "acem/orders/" ++ todatepath current ++ "/"


--makepath :: Date -> Date -> String
--makepath start end = undefined
