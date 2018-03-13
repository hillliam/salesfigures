-- Optional Task 4: Parser monad, JSON
--
-- (4.2) Write an application testJSONParser that reads JSON input from stdin,
--       parses it, counts the number of JValues and outputs that number.

> module Main where

> import Prelude
> import JSONParser_solution (JValue(..))

> countJValues :: JValue -> Int
> countJValues (JArray vs)   = 1 + sum [countJValues v | v <- vs]
> countJValues (JObject kvs) = 1 + sum [countJValues v | (_,v) <- kvs]
> countJValues _             = 1

> main :: IO ()
> main = putStrLn =<< show . countJValues . read <$> getContents

Here, main is written as a one liner, using =<< (which is a flipped >>=).
The flow of data is from left to right, like with function composition.
