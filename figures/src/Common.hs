-----------------------------------------------------------------------------
--
-- Module      :  common
-- Copyright   :  2018 liam hill
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- functions that can be used by multiple files
--
-----------------------------------------------------------------------------

module Common where

import JSONParser_solution

-- add function that can be used for multiple JSON files

getvalue :: JValue -> Int -> JValue
getvalue (JObject item) index = do
    let it = item !! index
    snd it
--
-- get the count of a part of the JSON tree
--
getcount ::JValue -> Int
getcount (JArray item) = length item
getcount (JObject item) = length item


