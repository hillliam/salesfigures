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
-- |
--
-----------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

module Htmlgen where

import Control.Monad (forM_)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.String -- this makes more sense
--import Text.Blaze.Html.Renderer.Text

gentest :: Html
gentest = docTypeHtml $ do
     H.head $ do
         H.title "blank"
     body $ do
         p "blank"

--totext :: Html -> text
totext a = renderHtml a
