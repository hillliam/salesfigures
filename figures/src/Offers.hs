-----------------------------------------------------------------------------
--
-- Module      :  Offers
-- Copyright   :  2018 liam hill
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Offers where

import JSONParser_solution

--data Offers = Offers
--    { discount :: String
--    , code     :: String
--    , start    :: Date
--    , end      :: Date
--    , cost     :: Integer
--    } deriving (Show)

readoffers :: IO ()
readoffers =  do
      input <- readFile "offers.json"
      let output = read input
      --output:: JValue
      --putStrLn (show (output:: JValue))
      putStrLn (unwords (getdiscounts output))

getdiscounts :: JValue -> [String]
getdiscounts (JArray item) =  map getdiscount item

getdiscount :: JValue -> String
getdiscount JNull = undefined
getdiscount (JBool a) = undefined
getdiscount (JNumber a) = undefined
getdiscount (JString a) = undefined
--getdiscount (JObject item) = if JString item  == "discount" then item _2 else ""
getdiscount (JObject item) = do
  let value = [v | (k, JString v) <- item]--, k == "discount"]
  unlines value
