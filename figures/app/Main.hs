{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Spock
--import qualified Web.Spock.Action as SA
import Web.Spock.Config

import Control.Monad.Trans
import Data.Monoid
import Data.IORef
import qualified Data.Text as T

import Lib
import Htmlgen

data MySession = EmptySession
data MyAppState = DummyAppState (IORef Int)
--data products = readproducts
--data offers = readoffers
--data orders = readorders

main :: IO ()
main =
    do ref <- newIORef 0
       spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
       runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
    do get root $
           html (T.pack (totext gentest))
-- handle offers
       get "offers" $
           do (DummyAppState ref) <- getState
              text ("displaying all offers " <> " \n" )
-- handle single offer
       get ("offers" <//> var) $ \name ->
           do (DummyAppState ref) <- getState
              text ("displaying offer with name: " <> name <> " \n" )
-- handle orders
--       get "orders" $
--           do (DummyAppState ref) <- getState
--               "displaying all orders \n"
-- handle single order
--       get ("orders" <//> var) $ \name ->
--           do (DummyAppState ref) <- getState
--              text ("displaying offer with name: " <> name <> " \n" <> T.pack (show visitorNumber))
-- handle products

-- handle single product


