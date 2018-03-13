This module offers functionality to break strings into JSON lexemes
(representing strings, numbers, Booleans, null, and separating characters),
to recognise the lexemes, and to extract their data.

> module JSONLexer (
>   Lexeme
> , lex
> , unLex
>
> , isComma
> , isColon
> , isLBracket
> , isRBracket
> , isLBrace
> , isRBrace
> , isTrue
> , isFalse
> , isNull
> , isBool
> , isString
> , isNumber
>
> , getBool
> , getString
> , getNumber
> ) where
>
> import Prelude hiding (lex)
> import Data.Char (isSpace)
> import Data.List (intercalate)
> import Data.Maybe (isJust)


LEXER

> type Lexeme = String


lex breaks a string into a list of lexemes separated by white space,
the JSON separator characters (comma, colon, brackets and braces), and
double quotes.

> lex :: String -> [Lexeme]
> lex input =
>     case input of
>         []    -> []
>         '"':_ -> let (cs, input1) = readStringLexeme input in
>                  cs : lex input1
>         c:rest | isSpace c -> lex rest
>                | isSep c   -> [c] : lex rest
>                | otherwise -> let (cs, input1) = readOtherLexeme input in
>                               cs : lex input1


unLex turns a list of lexemes back into a string.
It is a right inverse to lex, i.e. lex . unLex is the identity.

> unLex :: [Lexeme] -> String
> unLex = intercalate " "


isSep classifies the characters that serve as separating lexemes in JSON;
note that white space is also a separating lexeme.

> isSep :: Char -> Bool
> isSep ',' = True
> isSep ':' = True
> isSep '{' = True
> isSep '}' = True
> isSep '[' = True
> isSep ']' = True
> isSep _   = False


readStringLexeme is called when the first character of the input is
a double quote. It consisting of the characters forming the string
(including opening and closing double quotes) and the remainder of the input.
The function skips double quotes within a string if they are preceded by
a backslash.  Note that the function signals that it has read a non-terminated
string by returning the input prefixed with a space character (so that the
lexeme returned won't be classified as a string).

> readStringLexeme :: String -> (String, String)
> readStringLexeme input = if ok
>                          then ('"':cs, rest)
>                          else (' ':input, "")  -- error case return
>   where
>     (cs, ok, rest) = read (tail input)
>     read :: String -> (String, Bool, String)
>     read []        = ("", False, "")    -- error case: non-terminated string
>     read (c:input) =
>         case c of
>             '"'  -> ("\"", True, input)
>             '\\' -> (c:cs, ok, rest) where (cs, ok, rest) = escape input
>             _    -> (c:cs, ok, rest) where (cs, ok, rest) = read input
>     escape :: String -> (String, Bool, String)
>     escape []        = ("", False, "")  -- error case: non-terminated string
>     escape (c:input) = (c:cs, ok, rest) where (cs, ok, rest) = read input


readOtherLexeme is called when the first character of the input is neither
white space nor a separator nor a double quote. It returns a pair
consisting of the characters read up to (and excluding) the next white space
or separator, and the remainder of the input.

> readOtherLexeme :: String -> (String, String)
> readOtherLexeme []        = ("", "")
> readOtherLexeme (c:input)
>     | isSpace c = ("", c:input)
>     | isSep c   = ("", c:input)
>     | otherwise = (c:cs, rest) where (cs, rest) = readOtherLexeme input


LEXEME RECOGNIZERS

> isComma, isColon, isLBracket, isRBracket, isLBrace, isRBrace :: String -> Bool
> isComma    "," = True
> isComma    _   = False
> isColon    ":" = True
> isColon    _   = False
> isLBracket "[" = True
> isLBracket _   = False
> isRBracket "]" = True
> isRBracket _   = False
> isLBrace   "{" = True
> isLBrace   _   = False
> isRBrace   "}" = True
> isRBrace   _   = False

> isTrue, isFalse, isNull :: String -> Bool
> isTrue  "true"  = True
> isTrue  _       = False
> isFalse "false" = True
> isFalse _       = False
> isNull  "null"  = True
> isNull  _       = False

> isBool, isString, isNumber :: String -> Bool
> isBool   = isJust . getString
> isString = isJust . getString
> isNumber = isJust . getNumber


LEXEME EXTRACTORS

> getBool :: String -> Maybe Bool
> getBool "true"  = Just True
> getBool "false" = Just False
> getBool _       = Nothing

> getString :: String -> Maybe String
> getString ('"':cs) = Just (init cs)
> getString _        = Nothing

> getNumber :: String -> Maybe Double
> getNumber input =
>     case reads input of
>         [(num, "")] -> Just num
>         _           -> Nothing


TEST DATA

> j1, j2 :: String
>
> j1 = "{\"id\": 1.0, \"name\": \"Foo\", \"price\": 123.0, \"tags\": [\"Bar\", \"Eek\"], \"stock\": {\"warehouse\": 300.0, \"retail\": 20.0}}"
>
> j2 = "{\"firstName\": \"John\", \"lastName\": \"Smith\", \"isAlive\": true, \"age\": 27.0, \"address\": {\"streetAddress\": \"21 2nd Street\", \"city\": \"New York\", \"state\": \"NY\", \"postalCode\": \"10021-3100\"}, \"phoneNumbers\": [{\"type\": \"home\", \"number\": \"212 555-1234\"}, {\"type\": \"office\", \"number\": \"646 555-4567\"}, {\"type\": \"mobile\", \"number\": \"123 456-7890\"}], \"children\": [], \"spouse\": null}"
