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
     H.body $ do
         H.p $ toMarkup ("number of products: " ++ getproductcount)
         H.p $ toMarkup ("loaded products: "  ++ getallproducts)
         H.p $ toMarkup ("number of orders: " ++ getordercount)
         H.p $ toMarkup ("loaded orders: " ++ getallorders)
         H.p $ toMarkup ("all McCoy types: " ++ getallMcCoy)
         H.p $ toMarkup ("prices of sku 1038 : " ++ getpriceof1038)
         H.p $ toMarkup ("sku and price of large Chekov: " ++ getlargeChekov)
         H.p $ toMarkup ("sku and sizes of all chekov: " ++ getChekovsizes)
         buttons "/products" "display all products"
         buttons "/offers" "display all offers"
         buttons "/orders" "display all orders"

--paragraph :: String -> a -> Html
--paragraph text x = P $  toMarkup (text ++ x)

buttons :: String -> String -> Html
buttons code text = button! href (toValue code) $  toMarkup text

--totext :: Html -> text
totext a = renderHtml a
