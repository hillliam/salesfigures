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

getvalue :: String -> JValue -> JValue
getvalue key jvalue@(JObject item) = do
    let Just sub = lookup key item
    sub

getatindex :: JValue -> Int -> JValue
getatindex (JArray item) index = item !! index
--
-- get the count of a part of the JSON tree
--
getcount ::JValue -> Int
getcount (JArray item) = length item
getcount (JObject item) = length item

cleanup :: String -> String
cleanup line = filter (/= '\n') line
-- reads a file and path that it is given

--readfile :: String -> String -> IO JValue
--readfile dir file = do
--      let input = readFile (dir ++ file)
--      item <- read input
--      return item
