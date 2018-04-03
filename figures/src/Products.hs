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

data Price = Price String String deriving (Show)
data Product = Product String [Price] deriving (Show)

readproducts :: IO ()
readproducts = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (output:: JValue))
      putStrLn  (unwords (loadproducts (output:: JValue)))

--getpricedata :: IO () -> [Product]
--getpricedata = do
--      input <- readFile "products.json"
--      let output = read input
--      let first = head output
--      let variation = getvalue first 3
--      let pdata = getvalue variation 0
--      let pdata = map toproduct output
--      let prices = getvalue pdata 0
--      let gbpprice = getvalue prices 0
--      let usdprice = getvalue prices 1
--      let eurprice = getvalue prices 2

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
getcount (JObject item) = length item

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

getsku :: JValue -> String
getsku (JObject item) = do
    let guid = item !! 2
    show (snd guid)

getvalue :: JValue -> Int -> JValue
getvalue (JObject item) index = do
    let guid = item !! index
    snd guid
--
--getarrayinvariation :: JValue -> [Product]
--getarrayinvariation (JObject item) = if isvariation item then map toproduct (snd (head item)) else []

toproduct :: JValue -> Product
toproduct (JObject item) = do
  let guid = snd (head item)
  let name = snd (item !! 1)
  let description = snd (item !! 2)
  --let sku = [ k | (k, v) <- item]
  --let rest = [ v | (k, v) <- item]
  let sub = item !! 3
  let sku = sub
  let prices = getprices (snd sub)--(snd (item !! 3))
  --print getcount item
  Product (show name) prices

getprices :: JValue -> [Price]
getprices (JArray item) = map getprice item
getprices (JObject item) = map getprice [ v | (k, v) <- item]

getprice :: JValue -> Price
getprice (JObject item) = do
  let typeof = [ (k, show v) | (k, JNumber v) <- item]
  --let value = [ v | (k, JNumber v) <- item]
  uncurry Price (head typeof)

--showprice :: Price -> String
--showprice name value = name ++ value
