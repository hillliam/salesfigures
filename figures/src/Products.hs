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

import JSONParser_solution

-- id key
-- name string
-- description string
-- variants type of tshirt
-- list of prices
-- list of options
-- sku product code

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
  unlines value
