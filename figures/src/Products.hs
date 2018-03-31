-----------------------------------------------------------------------------
--
-- Module      :  Products
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

module Products where

--import Data.HashMap as HM
import Data.List --as LM

import JSONParser_solution

-- id key
-- name string
-- description string
-- variants type of tshirt
--  list of prices
--  list of options
--  sku product code

data Price = Price String Double deriving (Show)
data Product = Product String [Price] deriving (Show)


readproducts :: IO ()
readproducts = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (output:: JValue))
      putStrLn  (unwords (loadproducts (output:: JValue)))

loadproducts :: JValue -> [String]
loadproducts (JArray item) = map loadproduct item

loadproduct :: JValue -> String
loadproduct (JObject item) = do
  let value = [ if k == "name" then v else "" | (k, JString v) <- item]
  show value

-- returns true if the current
isvariation :: JValue -> Bool
isvariation (JObject item) = fst (last item) == "variation"

toproducts :: JValue -> [Product]
toproducts (JArray item) = map toproduct item

getcount ::JValue -> Int
getcount (JArray item) = length item

getguid :: JValue -> String
getguid (JObject item) = do
    let guid = head item
    show (snd guid)

getname :: JValue -> String
getname (JObject item) = do
    let guid = item !! 1
    show (snd guid)

getdescription :: JValue -> String
getdescription (JObject item) = do
    let guid = item !! 2
    show (snd guid)

getvalue :: JValue -> Int -> String
getvalue (JObject item) index = do
    let guid = item !! index
    show (snd guid)
--
--getarrayinvariation :: JValue -> [Product]
--getarrayinvariation (JObject item) = if isvariation item then map toproduct (snd (head item)) else []

toproduct :: JValue -> Product
toproduct (JObject item) = do
  let sku = [ k | (k, v) <- item]
  let rest = [ v | (k, v) <- item]
  let prices = getprices (head rest)
  Product (head sku) prices

getprices :: JValue -> [Price]
getprices (JArray item) = map getprice item

getprice :: JValue -> Price
getprice (JObject item) = do
  let typeof = [ k | (k, JNumber v) <- item]
  let value = [ v | (k, JNumber v) <- item]
  Price (unlines typeof) (head value:: Double)
