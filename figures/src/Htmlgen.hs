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
         p $ "number of products: " getproductcount
         P $ "loaded products: " getallproducts
         p $ "number of orders: " getordercount
         P $ "loaded orders: " getallorders
         P $ "loaded orders: " getallMcCoy
         P $ "loaded orders: " getpriceof1038
         P $ "loaded orders: " getlargeChekov
         P $ "loaded orders: " getChekovsizes
         buttons "href" "/products" "display all products"
         buttons "href" "/offers" "display all offers"
         buttons "href" "/orders" "display all orders"

buttons :: String -> String -> String -> Html
buttons att code text = button! att code $ text

--totext :: Html -> text
totext a = renderHtml a
