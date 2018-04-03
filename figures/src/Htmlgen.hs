-----------------------------------------------------------------------------
--
-- Module      :  Htmlgen
-- Copyright   :  2018 Author name here
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- generates html to be displayed by calling functions in the buisness logic
--
-----------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

module Htmlgen where

import Control.Monad (forM_)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.String -- this makes more sense
--import Text.Blaze.Html.Renderer.Text
import Evalsystem
import Lib -- the buisness logic

gentest :: Html
gentest = docTypeHtml $ do
     H.head $ do
         H.title "blank"
     body $ do
         p "blank"
--         p evaltest "m = 2"

genmainpage :: Html
genmainpage = docTypeHtml $ do
     H.head $ do
         H.title "main"
     body $ do
         p $ "number of products: " toMarkup getproductcount
         P $ "loaded products: " toMarkup getallproducts
         p $ "number of orders: " toMarkup getordercount
         P $ "loaded orders: " toMarkup getallorders
         P $ "all McCoy types: " toMarkup getallMcCoy
         P $ "prices of sku 1038 : " toMarkup getpriceof1038
         P $ "sku and price of large Chekov: " toMarkup getlargeChekov
         P $ "sku and sizes of all chekov: " toMarkup getChekovsizes
         buttons "/products" "display all products"
         buttons "/offers" "display all offers"
         buttons "/orders" "display all orders"

buttons :: String -> String -> Html
buttons code text = button! href (toValue code) $  toMarkup text

--totext :: Html -> text
totext a = renderHtml a
