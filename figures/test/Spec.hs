import Test.Hspec
import Test.HUnit
import Lib
import JSONParser_solution
--import Quckcheck
import Control.Exception (evaluate)

testproducts = "[{\"id\":\"ec6b65c4-edad-451b-9bd0-e628fb31e7d8\",\"name\":\"Mr. Spock T-shirt\",\"description\":\"Top quality Mr. Spock T-shirt; 100% cotton\",\"variants\":{\"SKU-1001\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"S\"},\"sku\":\"SKU-1001\"},\"SKU-1002\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"M\"},\"sku\":\"SKU-1002\"},\"SKU-1003\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"L\"},\"sku\":\"SKU-1003\"},\"SKU-1004\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"XL\"},\"sku\":\"SKU-1004\"},\"SKU-1005\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"XXL\"},\"sku\":\"SKU-1005\"}}},{\"id\":\"3ff690f4-9521-45b6-aa20-a5b44b780c06\",\"name\":\"Capt. Kirk T-shirt\",\"description\":\"Top quality Capt. Kirk T-shirt; 100% cotton\",\"variants\":{\"SKU-1006\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"S\"},\"sku\":\"SKU-1006\"},\"SKU-1007\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"M\"},\"sku\":\"SKU-1007\"},\"SKU-1008\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"L\"},\"sku\":\"SKU-1008\"},\"SKU-1009\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"XL\"},\"sku\":\"SKU-1009\"},\"SKU-1010\":{\"price\":{\"GBP\":14.99,\"USD\":16.99,\"EUR\":16.99},\"options\":{\"size\":\"XXL\"},\"sku\":\"SKU-1010\"}}}]"
testorder = "[{\"id\":\"05d8d404-b3f6-46d1-a0f9-dbdab7e0261f\",\"lines\":[{\"description\":\"SKU-1059 x 1\",\"price\":{\"GBP\":13.49}},{\"description\":\"SKU-1035 x 2\",\"price\":{\"GBP\":13.49}},{\"description\":\"SKU-1079 x 1\",\"price\":{\"GBP\":13.49}},{\"description\":\"SKU-1025 x 1\",\"price\":{\"GBP\":13.49}},{\"description\":\"Delivery\",\"price\":{\"GBP\":3.49}}],\"date\":{\"date\":\"2015-01-10T19:11:41.000Z\"},\"offer-code\":\"OFFER-1-XTC\",\"total\":{\"GBP\":57.45},\"invoice-address\":[\"107\",\"Smollett Street\",\"Western Central London\",\"WC18 4SA\"],\"delivery-address\":[\"107\",\"Smollett Street\",\"Western Central London\",\"WC18 4SA\"]},{\"id\":\"5ba6be42-7f99-4f89-8e44-d0a27f215244\",\"lines\":[{\"description\":\"SKU-1015 x 1\",\"price\":{\"GBP\":13.49}},{\"description\":\"SKU-1043 x 1\",\"price\":{\"GBP\":13.49}},{\"description\":\"SKU-1041 x 1\",\"price\":{\"GBP\":13.49}},{\"description\":\"Delivery\",\"price\":{\"GBP\":3.49}}],\"date\":{\"date\":\"2015-01-14T12:47:51.000Z\"},\"offer-code\":\"OFFER-1-XTC\",\"total\":{\"GBP\":43.96},\"invoice-address\":[\"41\",\"Sparta Place\",\"Twickenham\",\"TW6 4WE\"],\"delivery-address\":[\"41\",\"Sparta Place\",\"Twickenham\",\"TW6 4WE\"]}]"

exspectedmcoy = "[[(\"id\",\"03b08ad6-df0b-49ec-b2b8-89f4ba27da04\"),(\"name\",\"Dr. McCoy T-shirt\"),(\"description\",\"Top quality Dr. McCoy T-shirt; 100% cotton\"),(\"variants\",{\"SKU-1011\":{\"price\":{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99}, \"options\":{\"size\":\"S\"}, \"sku\":\"SKU-1011\"}, \"SKU-1012\":{\"price\":{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99}, \"options\":{\"size\":\"M\"}, \"sku\":\"SKU-1012\"}, \"SKU-1013\":{\"price\":{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99}, \"options\":{\"size\":\"L\"}, \"sku\":\"SKU-1013\"}, \"SKU-1014\":{\"price\":{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99}, \"options\":{\"size\":\"XL\"}, \"sku\":\"SKU-1014\"}, \"SKU-1015\":{\"price\":{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99}, \"options\":{\"size\":\"XXL\"}, \"sku\":\"SKU-1015\"}})]]"

main :: IO ()
main = do
    testproduct
    testorders
    --testpathcodef
    --testpathcodel

testproduct :: IO()
testproduct = do
--    input <- readFile "products.json"
    let output = read testproducts
    putStrLn (show (testpcount output))
    putStrLn (show (testskucount output))
    putStrLn (show (testmcoy output))
    putStrLn (show (test1038 output))
    putStrLn (show (testlc output))
    putStrLn (show (testsc output))

testorders :: IO ()
testorders = do
--    input <- readFile "orders.json"
    let output = read testorder
    putStrLn (show (testocount output))

testpcount :: JValue -> Bool
testpcount jvalue@(JArray item) = (getpcount jvalue) == show 2

testskucount :: JValue -> Bool
testskucount jvalue@(JArray item) = (getskucount jvalue) == show 10

testmcoy :: JValue -> Bool
testmcoy jvalue@(JArray item) = (getallMcCoy jvalue) == exspectedmcoy

test1038 :: JValue -> Bool
test1038 jvalue@(JArray item) = (getpriceof1038 jvalue) == "(\"price\",{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99})"

testlc :: JValue -> Bool
testlc jvalue@(JArray item) = (getlargeChekov jvalue) == "(\"price\",{\"GBP\":14.99, \"USD\":16.99, \"EUR\":16.99})"

testsc :: JValue -> Bool
testsc jvalue@(JArray item) = (getChekovsizes jvalue) == "\"S\"\"M\"\"L\"\"XL\"\"XXL\""

testocount :: JValue -> Bool
testocount jvalue@(JArray item) = (getordercount jvalue) == show 2

--testpathcodef :: Bool
--testpathcodef = gotocurrentfile firstday == "acem/orders/"
--
--testpathcodel :: Bool
--testpathcodel = gotocurrentfile lastday == "acem/orders/"
