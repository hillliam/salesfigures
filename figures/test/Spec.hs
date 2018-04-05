import Test.HUnit
import Quckcheck

main :: IO ()
main = do
    testproduct
    testorders

testproduct :: IO()
testproduct = do
    input <- readFile "products.json"
    let output = read input
    testpcount

testorders :: IO()
testorders = do
    input <- readFile "orders.json"
    let output = read input

testpcount :: Jvalue -> Bool
testpcount =
