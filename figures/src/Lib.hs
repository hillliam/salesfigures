module Lib where

import JSONParser_solution
import Control.Lens
import Offers
import Orders
import Products

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

getproffit :: JValue
getproffit = undefined

getproductcount :: String
getproductcount = getpcount

getallproducts :: String
getallproducts = undefined

getallMcCoy :: String
getallMcCoy = undefined

getpriceof1038 :: String
getpriceof1038 = undefined

getlargeChekov :: String
getlargeChekov = undefined

getChekovsizes :: String
getChekovsizes = undefined

getordercount :: String
getordercount = getocount

getallorders :: String
getallorders = undefined

