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
