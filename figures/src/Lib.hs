module Lib where

import JSONParser_solution
import Control.Lens

someFunc :: IO ()
someFunc = putStrLn "someFunc"


readoffers :: IO ()
readoffers =  do
      input <- readFile "offers.json"
      let output = read input
      putStrLn (show (output:: JValue))
      putStrLn (head (getdiscounts output))


getdiscounts :: JValue -> [String]
getdiscounts (JArray item) =  map getdiscount item

getdiscount :: JValue -> String
getdiscount (JObject item) = undefined
--getdiscount (JObject item) = do
--  let value = [v | (_, JString v) <- item, _ == "discount"]


readproducts :: IO ()
readproducts = do
      input <- readFile "offers.json"
      let output = read input
      putStrLn (show (output:: JValue))

readorders :: IO ()
readorders = do
      input <- readFile "offers.json"
      let output = read input
      putStrLn (show (output:: JValue))
