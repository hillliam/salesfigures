module SimpleJSON
    (
      JValue(..)
    , getString
    , getInt
    , getDouble
    , getBool
    , getObject
    , getArray
    , isNull
    ) where
    
import Data.Char
import Data.List

data JValue = JString String
            | JNumber Double
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
              deriving (Eq, Ord, Show)

getString :: JValue -> Maybe String
getString (JString s) = Just s
getString _           = Nothing

getInt (JNumber n) = Just (truncate n)
getInt _           = Nothing

getDouble (JNumber n) = Just n
getDouble _           = Nothing

getBool (JBool b) = Just b
getBool _         = Nothing

getObject (JObject o) = Just o
getObject _           = Nothing

getArray (JArray a) = Just a
getArray _          = Nothing

isNull v            = v == JNull

renderJValue :: JValue -> String
renderJValue (JBool True)  = "true"
renderJValue (JBool False) = "false"
renderJValue JNull         = "null"
renderJValue (JNumber num) = show num
renderJValue (JString str) = show str

countObjects :: JValue -> Int
countObjects (JString _) = 0
countObjects (JBool _) = 0
countObjects (JNumber _) = 0
countObjects (JNull ) = 0
countObjects (JObject a) = 1 + sum [countObjects v | (k,v) <- a] -- list comprehension
countObjects (JArray a) = sum (map countObjects a) 

exampledata = (JArray [ JObject [("width", JNumber 40.0)], JObject [("height", JNumber 50.0)]])