-- Optional Task 4: Parser monad, JSON

This module provides a parser for JSON, producing values of type JValue.

The module exports only the JValue datatype and its constructors.
The parser is implicitly expoerted via the Read instance for JValue.

> module JSONParser_solution (JValue(..)) where
>
> import Prelude hiding (lex)
> import Control.Monad (unless)
> import Data.List (intercalate)
> import JSONLexer (
>     Lexeme, lex, unLex,
>     isComma, isColon, isLBracket, isRBracket, isLBrace, isRBrace, isNull,
>     getBool, getNumber, getString)
> import ParserCombinators (Parser, run, empty, (<|>), get, sepBy)


------------------------------------------------------------------------------
JSON data type with hand-rolled Show instance

> data JValue = JNull
>             | JBool Bool
>             | JNumber Double
>             | JString String
>             | JArray [JValue]
>             | JObject [(String, JValue)]
>             deriving (Eq, Ord)

> instance Show JValue where
>     show JNull         = "null"
>     show (JBool False) = "false"
>     show (JBool True)  = "true"
>     show (JNumber n)   = show n
>     show (JString s)   = show s
>     show (JArray vs)   = "[" ++ intercalate ", " [show v | v <- vs] ++ "]"
>     show (JObject kvs) = "{" ++ intercalate ", " pairs ++ "}" where
>                              pairs = [show k ++ ":" ++ show v | (k,v) <- kvs]

------------------------------------------------------------------------------
-- (4.1) Write parser for JSON values.
--       The parser takes as input not Strings but a list of lexemes
--       produced by the lex function of module JSONLexer.

> pJValue :: Parser Lexeme JValue
> pJValue = pJNull <|> pJBool <|> pJNumber <|> pJString <|> pJArray <|> pJObject

> pJNull :: Parser Lexeme JValue
> pJNull = do { lexeme <- get; if isNull lexeme then return JNull else empty }

> pJBool :: Parser Lexeme JValue
> pJBool = fmap JBool pBool

> pJNumber :: Parser Lexeme JValue
> pJNumber = fmap JNumber pDouble

> pJString :: Parser Lexeme JValue
> pJString = fmap JString pString

> pJArray :: Parser Lexeme JValue
> pJArray = do
>     pLBracket
>     vs <- pJValue `sepBy` pComma
>     pRBracket
>     return (JArray vs)

> pJObject :: Parser Lexeme JValue
> pJObject = do
>     pLBrace
>     kvs <- pKeyValue `sepBy` pComma
>     pRBrace
>     return (JObject kvs)

> pKeyValue :: Parser Lexeme (String, JValue)
> pKeyValue = do
>     k <- pString
>     pColon
>     v <- pJValue
>     return (k,v)


Auxiliary parsers for individual lexemes

> pBool :: Parser Lexeme Bool
> pBool = fmap getBool get >>= maybe empty return

> pDouble :: Parser Lexeme Double
> pDouble = fmap getNumber get >>= maybe empty return

> pString :: Parser Lexeme String
> pString = fmap getString get >>= maybe empty return

> pComma :: Parser Lexeme ()
> pComma = do { lexeme <- get; unless (isComma lexeme) empty }

> pColon :: Parser Lexeme ()
> pColon = do { lexeme <- get; unless (isColon lexeme) empty }

> pLBracket :: Parser Lexeme ()
> pLBracket = do { lexeme <- get; unless (isLBracket lexeme) empty }

> pRBracket :: Parser Lexeme ()
> pRBracket = do { lexeme <- get; unless (isRBracket lexeme) empty }

> pLBrace :: Parser Lexeme ()
> pLBrace = do { lexeme <- get; unless (isLBrace lexeme) empty }

> pRBrace :: Parser Lexeme ()
> pRBrace = do { lexeme <- get; unless (isRBrace lexeme) empty }

------------------------------------------------------------------------------
RUNNING LEXER AND PARSER

To run the parser together with the lexer, we instantiate type class Read
for JValue. Running parser and lexer essentially requires composing
the lex and run functions. However, the type of that is
run pJValue . lex :: String -> [(JValue, [Lexeme])].

However, to instantiate read, we need type String -> [(JValue, String)].
That is, for each parser result we need to turn the remainder of the input
(the second component) from a list of lexemes back into a string.
We could do this by mapping over the result list, applying the unLex function
to each second component. That is, the entire function for instantiating
the Read class should be
map (\ (v, rest) -> (v, unLex rest)) . run pJValue . lex

Compare this to the actual function below. The outer fmap operates on lists
and corresponds to map; the inner fmap operates on pairs and lifts the unLex
function to apply to the 2nd component.

> instance Read JValue where
>     readsPrec _ = fmap (fmap unLex) . run pJValue . lex

------------------------------------------------------------------------------
HOW TO TEST

Type `read j1 :: JValue` in the interpreter.

Note that the type annotation is necessary. Without it the compiler
will try (and fail) to parse String `j1` as a different type.

> j1 = "{\"id\": 1.0, \"name\": \"Foo\", \"price\": 123.0, \"tags\": [\"Bar\", \"Eek\"], \"stock\": {\"warehouse\": 300.0, \"retail\": 20.0}}"

> j2 = "{\"firstName\": \"John\", \"lastName\": \"Smith\", \"isAlive\": true, \"age\": 27.0, \"address\": {\"streetAddress\": \"21 2nd Street\", \"city\": \"New York\", \"state\": \"NY\", \"postalCode\": \"10021-3100\"}, \"phoneNumbers\": [{\"type\": \"home\", \"number\": \"212 555-1234\"}, {\"type\": \"office\", \"number\": \"646 555-4567\"}, {\"type\": \"mobile\", \"number\": \"123 456-7890\"}], \"children\": [], \"spouse\": null}"
