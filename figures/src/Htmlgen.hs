-----------------------------------------------------------------------------
--
-- Module      :  Htmlgen
-- Copyright   :  2018 liam hill
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

import JSONParser_solution
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

genmainpage :: JValue -> Html
genmainpage jvalue@(JArray item) = docTypeHtml $ do
     H.head $ do
         H.title "main"
     H.body $ do
         H.p $ toMarkup ("number of products: " ++ (getpcount jvalue))
         H.p $ toMarkup ("number of skus: " ++ (getskucount jvalue))
         --H.p $ toMarkup ("loaded products: "  ++ (getallproducts jvalue))
         --H.p $ toMarkup ("number of orders: " ++ (getordercount jvalue))
         --H.p $ toMarkup ("loaded orders: " ++ (getallorders jvalue))
         H.p $ toMarkup ("all McCoy types: " ++ (getallMcCoy jvalue))
         H.p $ toMarkup ("prices of sku 1038 : " ++ (getpriceof1038 jvalue))
         H.p $ toMarkup ("price of large Chekov: " ++ (getlargeChekov jvalue))
         H.p $ toMarkup ("sizes of all chekov: " ++ (getChekovsizes jvalue))
         buttons "/products" "display all products"
         buttons "/offers" "display all offers"
         buttons "/orders" "display all orders"

--paragraph :: String -> a -> Html
--paragraph text x = P $  toMarkup (text ++ x)

buttons :: String -> String -> Html
buttons code text = button! href (toValue code) $  toMarkup text

--totext :: Html -> text
totext a = renderHtml a
