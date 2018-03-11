-----------------------------------------------------------------------------
--
-- Module      :  Offers
-- Copyright   :  2018 Author name here
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Offers (

) where


data Offers = Offers
    { discount :: String
    , code     :: String
    , start    :: Date
    , end      :: Date
    , cost     :: Integer
    } deriving (Show)
