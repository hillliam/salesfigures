module Lib where

import JSONParser_solution
import Control.Lens

someFunc :: IO ()
someFunc = putStrLn "someFunc"

readoffers :: IO ()
readoffers =  do
      input <- readFile "offers.json"
      let output = read input
      --putStrLn (show (output:: JValue))
      putStrLn (head (getdiscounts output))


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
