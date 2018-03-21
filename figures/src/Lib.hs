module Lib where

import JSONParser_solution
import Control.Lens
import Offers
import Orders
import Products

someFunc :: IO ()
someFunc = putStrLn "someFunc"

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



parseproducts :: JValue -> [String]
parseproducts (JArray item) =  map getdiscount item
--readproductsfile :: IO () -> String
--readproductsfile = do
--    (readFile "products.json") >>= filedata

--getproducts :: String -> String
--getproducts =
--      let output = read readproductsfile
--      show (output:: JValue)

readorders :: IO ()
readorders = do
      input <- readFile "orders.json"
      let output = read input
      putStrLn (show (output:: JValue))

