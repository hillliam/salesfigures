-----------------------------------------------------------------------------
--
-- Module      :  Products
-- Copyright   :  2018 liam hill
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- containes all of the code for hanadaling the product JSON file
--
-----------------------------------------------------------------------------

module Products where

--import Data.HashMap as HM
import Data.List --as LM

import JSONParser_solution
import Common

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

getpcount :: IO ()
getpcount = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (getcount (output:: JValue)))

getskucount :: IO ()
getskucount = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (sum (skucounts (output:: JValue))))

skucounts :: JValue -> [Int]
skucounts (JArray item) = map skucount item

skucount :: JValue -> Int
skucount (JObject item) = do
    let sub = item !! 3
    getcount (snd sub)

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

getallmcoy :: IO ()
getallmcoy = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (unlines (findmcoys (output:: JValue))))

findmcoys :: JValue -> [String]
findmcoys (JArray item) = map findmcoy item --map findbyname (item "McCoy")

findmcoy :: JValue -> String
findmcoy (JObject item) = do
    let name = snd (item !! 1)
    if isInfixOf "McCoy" (show name) then
        show [item]
    else
        "" --show name++ " a "

findbyname :: JValue -> String -> String
findbyname (JObject item) key = do
    let name = snd (item !! 1)
    if isInfixOf key (show name) then
        show [item]
    else
        "" --show name++ " a "

get1038 :: IO ()
get1038 = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (unlines (find1038s (output:: JValue))))

find1038s :: JValue -> [String]
find1038s (JArray item) = map find1038 item

find1038 :: JValue -> String
find1038 (JObject item) = do
    let variation = snd (item !! 3)
    unlines (getskubykey variation "1038")
    --show value

--get1038sku :: JValue -> [String]
--get1038sku (JObject item) = getskubykey (JValue item) "1038"

getskubykey :: JValue -> String -> [String]
getskubykey (JObject item) key = [ if isInfixOf key k then show v else "" | (k, v) <- item]

-- the version that should be used.
--getskubyvindex :: JValue => a -> Int -> String -> [String]
getskubyvindex (JObject item) index key f = [ if isInfixOf key (show (getvalue v index)) then f v else "" | (k, v) <- item]

getskubyprice :: JValue -> String -> [String]
getskubyprice (JObject item) key = [ if isInfixOf key (show (getvalue v 0)) then show v else "" | (k, v) <- item]

-- modified to be used with getlChekov
getskubyoption :: JValue -> String -> [String]
getskubyoption (JObject item) key = [ if isInfixOf key (show (getvalue v 1)) then show (getvalue v 0) else "" | (k, v) <- item]

getlChekov :: IO ()
getlChekov = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (unlines (findlchekovs (output:: JValue))))

findlchekovs :: JValue -> [String]
findlchekovs (JArray item) = map findchekovl item

findchekovl :: JValue -> String
findchekovl (JObject item) = do
    let name = snd (item !! 1)
    if isInfixOf "Chekov" (show name) then do
        let variation = snd (item !! 3)
        unlines (getskubyoption variation "L")
    else
        "" --show name++ " a "

loadproducts :: JValue -> [String]
loadproducts (JArray item) = map loadproduct item

loadproduct :: JValue -> String
loadproduct (JObject item) = do
  let value = [ if k == "name" then v else "" | (k, JString v) <- item]
  show value

-- returns true if the current object has key name variation
isvariation :: JValue -> Bool
isvariation (JObject item) = fst (last item) == "variation"

toproducts :: JValue -> [Product]
toproducts (JArray item) = map toproduct item

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

