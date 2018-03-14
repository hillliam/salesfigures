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
getdiscount (JObject item) = if item.1 == "discount" then
item.2
else ""
--getdiscount (JObject item) = do
--  let value = [v | (_, JString v) <- item, _ == "discount"]


readproducts :: IO ()
readproducts = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (output:: JValue))

readorders :: IO ()
readorders = do
      input <- readFile "orders.json"
      let output = read input
      putStrLn (show (output:: JValue))
