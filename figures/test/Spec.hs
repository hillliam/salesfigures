import Test.Hspec
import Test.HUnit
import Lib
import JSONParser_solution
--import Quckcheck
import Control.Exception (evaluate)

main :: IO ()
main = do
    testproduct
    testorders

testproduct :: IO()
testproduct = do
--    input <- readFile "products.json"
--    let output = read input
    testpcount

testorders :: IO()
testorders = do
--    input <- readFile "orders.json"
--    let output = read input
    testocount

testpcount :: Bool
testpcount = getproductcount == 20

testocount :: Bool
testocount = getordercount == 100
