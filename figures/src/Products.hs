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
skucounts (JArray item) = do
    let result = map (getvalue "variants") item
    map getcount result

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
      putStrLn (show (cleanup (unlines (findmcoys (output:: JValue)))))

findmcoys :: JValue -> [String]
findmcoys (JArray item) = map (findbyname "McCoy") item

findmcoy :: JValue -> String
findmcoy jvalue@(JObject item) = do
    let name = getvalue "name" jvalue
    if isInfixOf "McCoy" (show name) then
        show [item]
    else
        "" --show name++ " a "

findbyname :: String -> JValue -> String
findbyname key jvalue@(JObject item) = do
    let name = getvalue "name" jvalue
    if isInfixOf key (show name) then
        show [item]
    else
        "" --show name++ " a "

get1038 :: IO ()
get1038 = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (cleanup (unlines (find1038s (output:: JValue)))))

find1038s :: JValue -> [String]
find1038s (JArray item) = map find1038 item

find1038 :: JValue -> String
find1038 jvalue@(JObject item) = do
    let variation = getvalue "variants" jvalue
    unlines (getskubyvindex variation "sku" "1038" showprices)
    --show value

--get1038sku :: JValue -> [String]
--get1038sku (JObject item) = getskubykey (JValue item) "1038"

--getskubykey :: JValue -> String -> [String]
--getskubykey (JObject item) key = [ if isInfixOf key k then show v else "" | (k, v) <- item]

-- the version that should be used.
--getskubyvindex :: JValue => a -> Int -> String -> [String]
getskubyvindex (JObject item) name key f = [ if isInfixOf key (show (getvalue name v)) then f v else "" | (k, v) <- item]

--getskubyprice :: JValue -> String -> [String]
--getskubyprice (JObject item) key = [ if isInfixOf key (show (getvalue v 0)) then show v else "" | (k, v) <- item]

-- modified to be used with getlChekov
--getskubyoption :: JValue -> String -> [String]
--getskubyoption (JObject item) key = [ if isInfixOf key (show (getvalue v 1)) then show (getvalue v 0) else "" | (k, v) <- item]

getlChekov :: IO ()
getlChekov = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (cleanup (unlines (findlchekovs (output:: JValue)))))

findlchekovs :: JValue -> [String]
findlchekovs (JArray item) = map findchekovl item

-- this can be made more generic
findchekovl :: JValue -> String
findchekovl jvalue@(JObject item) = do
    let name = getvalue "name" jvalue
    if isInfixOf "Chekov" (show name) then do
        let variation = getvalue "variants" jvalue
        unlines (getskubyvindex variation "options" "L" showprices)
    else
        "" --show name++ " a "

getsChekov :: IO ()
getsChekov = do
      input <- readFile "products.json"
      let output = read input
      putStrLn (show (cleanup (unlines (findschekovs (output:: JValue)))))

findschekovs :: JValue -> [String]
findschekovs (JArray item) = map findchekovs item

findchekovs :: JValue -> String
findchekovs jvalue@(JObject item) = do
    let name = getvalue "name" jvalue
    if isInfixOf "Chekov" (show name) then do
        let variation = getvalue "variants" jvalue
        unlines (getskubyvindex variation "options" "" showsizes)
    else
        "" --show name++ " a "

--showes the prices of the current sku.
showprices :: JValue -> String
showprices jvalue@(JObject item) = show (head item)

-- shows the sizes of the current sku.
showsizes :: JValue -> String
showsizes jvalue@(JObject item) = show (getvalue "size" (getvalue "options" jvalue))

loadproducts :: JValue -> [String]
loadproducts (JArray item) = map loadproduct item

loadproduct :: JValue -> String
loadproduct (JObject item) = do
  let value = [ if k == "name" then v else "" | (k, JString v) <- item]
  show value

--toproducts :: JValue -> [Product]
--toproducts (JArray item) = map toproduct item

showproducts :: JValue -> String
showproducts jvalue@(JObject item) = (getguid jvalue) ++ (getname jvalue)
-- gets the current guid
getguid :: JValue -> String
getguid jvalue@(JObject item) = show (getvalue "id" jvalue)

-- gets the name of the product
getname :: JValue -> String
getname jvalue@(JObject item) = show (getvalue "name" jvalue)

-- product description
getdescription :: JValue -> String
getdescription jvalue@(JObject item) = show (getvalue "description" jvalue)

-- the sku of
getsku :: JValue -> String
getsku jvalue@(JObject item) = show (getvalue "sku" jvalue)
--
--getarrayinvariation :: JValue -> [Product]
--getarrayinvariation (JObject item) = if isvariation item then map toproduct (snd (head item)) else []

--toproduct :: JValue -> Product
--toproduct jvalue@(JObject item) = do
--  let guid = getguid
--  let name = getname
--  let description = getdescription
--  --let sku = [ k | (k, v) <- item]
--  --let rest = [ v | (k, v) <- item]
--  let sub = getvalue "variants" jvalue
--  let sku = getsku sub
--  let prices = getprices sub --(snd (item !! 3))
--  --print getcount item
--  Product (show name) prices

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

