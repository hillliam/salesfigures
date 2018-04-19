-----------------------------------------------------------------------------
--
-- Module      :  Databaseversion
-- Copyright   :  2018 liam hill
-- License     :  BSD3
--
-- Maintainer  :  example@example.com
-- Stability   :
-- Portability :
--
-- handles the database version of the JSON files
--
-----------------------------------------------------------------------------

module Databaseversion where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

--Connecttodb :: IO Connection
--Connecttodb = open ":memory:"

populatedatabase :: IO ()
populatedatabase = undefined

performquerey :: String -> IO ()
performquerey command = undefined

