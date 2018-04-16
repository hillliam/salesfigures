module Lib where

import JSONParser_solution
import Control.Lens
import Offers
import Orders
import Products
import Databaseversion

-- this will store the buisness logic to generate data

someFunc :: IO ()
someFunc = putStrLn "someFunc"



parseproducts :: JValue -> [String]
parseproducts (JArray item) =  map getdiscount item
--readproductsfile :: IO () -> String
--readproductsfile = do
--    (readFile "products.json") >>= filedata

--getproducts :: String -> String
--getproducts =
--      let output = read readproductsfile
--      show (output:: JValue)

-- gui functions
getproffit :: JValue
getproffit = undefined

getproductcount :: String
getproductcount = undefined-- getpcount

getallproducts :: String
getallproducts = undefined-- readproducts

getallMcCoy :: String
getallMcCoy = undefined-- getallmcoy

getpriceof1038 :: String
getpriceof1038 = undefined-- get1038

getlargeChekov :: String
getlargeChekov = undefined-- getlChekov

getChekovsizes :: String
getChekovsizes = undefined

getordercount :: String
getordercount = undefined-- getocount

getallorders :: String
getallorders = undefined--

