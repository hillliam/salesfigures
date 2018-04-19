module Lib where

import JSONParser_solution
import Control.Lens
import Offers
import Orders
import Products
import Databaseversion
import Pathgetter
import Common

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

getpcount :: JValue -> String
getpcount jvalue@(JArray item) =  show (getcount jvalue)

--getallproducts :: JValue -> String
--getallproducts jvalue@(JArray item) = -- readproducts

getskucount :: JValue -> String
getskucount jvalue@(JArray item) = show (sum (skucounts jvalue)) -- getskucount

getallMcCoy :: JValue -> String
getallMcCoy jvalue@(JArray item) = show (cleanup (unlines (findmcoys jvalue)))-- getallmcoy

getpriceof1038 :: JValue -> String
getpriceof1038 jvalue@(JArray item) = show (cleanup (unlines (find1038s jvalue)))-- get1038

getlargeChekov :: JValue -> String
getlargeChekov jvalue@(JArray item) = show (cleanup (unlines (findlchekovs jvalue)))-- getlChekov

getChekovsizes :: JValue -> String
getChekovsizes jvalue@(JArray item) = show (cleanup (unlines (findschekovs jvalue))) -- getsChekov

getordercount :: JValue -> String
getordercount jvalue@(JArray item) = show (getcount jvalue)-- getocount

getallorders :: String
getallorders = undefined-- readorders

getfirstorder :: String
getfirstorder = undefined-- getfirstorder

