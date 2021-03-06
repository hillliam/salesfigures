-----------------------------------------------------------------------------
--
-- Module      :  Orders
-- Copyright   :  2018 liam hill
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Orders where

import JSONParser_solution
import Common

-- id key
-- lines product + quantity
--

-- use

-- shipments
--

-- purchase-order


-- discounts
-- optional not needed

--data Orders = Orders
--    { id    :: String
--    , lines :: Lines
--    } deriving (Show)

--data Lines = Lines
--    { description   :: String
--    , price         :: Lines
--    } deriving (Show)

readorders :: IO ()
readorders = do
      input <- readFile "orders.json"
      let output = read input
      putStrLn (show (output:: JValue))

getocount :: IO ()
getocount = do
      input <- readFile "orders.json"
      let output = read input
      putStrLn (show (getcount (output:: JValue)))

getfirstorder:: IO ()
getfirstorder = do
      input <- readFile "orders.json"
      let output = read input
      putStrLn (show ( (output:: JValue)))
