This module is a parser combinator library, following the (now classic) pearl
by Hutton and Meijer [1]. A gentler and more comprehensive introduction
to parser combinators can be found in [2].

The standard Haskell type class hierarchy has changed significantly
since [1] was published in 1998. Therefore, the names of some combinators
have changed; I will point out these changes below. I have also left out
a few of the combinators that seemed less relevant.

References:
1. Graham Hutton and Erik Meijer. Monadic parsing in Haskell.
   Journal of Functional Programming, 8(4):437-444, 1998. 
   [http://www.cs.nott.ac.uk/~pszgmh/bib.html#pearl]

2. Graham Hutton and Erik Meijer. Monadic parser combinators.
   Technical Report NOTTCS-TR-96-4, Department of Computer Science,
   University of Nottingham, 1996. 
   [http://www.cs.nott.ac.uk/~pszgmh/bib.html#monparsing]


> module ParserCombinators (
>   Parser(run)
> , get
> , satisfy
> , eof
> , empty
> , (<|>)
> , (<++)
> , many
> , some
> , sepBy
> , sepBy1
> ) where
>
> import Prelude
> import Control.Applicative (Alternative(empty, (<|>), some, many))


The Parser type in the article is a newtype wrapper around the function type
String -> [(a, String)]. I am abstracting String by a further type variable i.
This results in a Parser type that is parametric in the type of input,
which is necessary if we want to combine the parser with a lexer rather
than read characters directly.

I also use record notation, which implicitly defines a function
run :: Parser i a -> [i] -> [(a,[i])]. In the article, this function
is called parse (but its definition is omitted).

> newtype Parser i a = Parser { run :: [i] -> [(a,[i])] }


The article defines the item parser for reading the next input item.
In line with modern parser combinator libraries I've renamed this to get.

> get :: Parser i i
> get = Parser $ \ is -> case is of { [] -> []; i:is -> [(i,is)] }


The article defines the sat parser for reading the next input item,
provided it satisfies the predicate p. I've renamed this parser to satisfy,
in line with modern parser combinator libraries.

> satisfy :: (i -> Bool) -> Parser i i
> satisfy p = do { i <- get; if p i then return i else empty }


The eof parser succeeds if and only if the get parser fails,
that is when all input is consumed. The article omitted this parser;
it is included here because it is sometimes useful.

> eof :: Parser i ()
> eof = Parser $ \ is -> if null is then [((),[])] else []


The article defines the Parser type an instance of the Monad type class.
Nowadays, however, we first need to instantiate Functor and Applicative.

> instance Functor (Parser i) where
>     fmap f p = Parser $ \ is -> [(f a, is') | (a,is') <- run p is]

> instance Applicative (Parser i) where
>     pure a  = Parser $ \ is -> [(a,is)]
>     p <*> q = Parser $ \ is -> [(f b, is'') | (f,is') <- run p is,
>                                               (b,is'') <- run q is']


Here comes the Monad instance, providing sequencing of parsers.
Note that this code is exactly the same as in the article (modulo
renaming of variables and renaming parse into run).

> instance Monad (Parser i) where
>     return a = Parser $ \ is -> [(a,is)]
>     p >>= f  = Parser $ \ is -> concat [run (f a) is' | (a,is') <- run p is]


The article defines choice combinators by instantiating the type classes
MonadZero and MonadPlus. Nowadays these classes are subsumed by class
Alternative. As a result, the combinators zero, ++ and many1 of the article
are now called empty, <|> and some.

> instance Alternative (Parser i) where
>     empty   = Parser $ \ is -> []
>     p <|> q = Parser $ \ is -> run p is ++ run q is
>     some p  = do { a <- p; as <- many p; return (a:as) }
>     many p  = some p <++ return []


The many combinator is defined in terms of the left-biased deterministic
choice combinator <++. In the article, this combinator was called +++
but that notation does not visibly highlight left-bias, which is why I
chose <++ (in line with other parser combinator libraries).

> (<++) :: Parser i a -> Parser i a -> Parser i a
> p <++ q = Parser $ \ is -> take 1 (run (p <|> q) is)
>
> infixr 5 <++


sepBy and sepBy1 are utilities, variants of many and some, specifically
for parsing lists (where individual elements are syntactically separated).

> sepBy  :: Parser i a -> Parser i b -> Parser i [a]
> p `sepBy` sep  = (p `sepBy1` sep) <++ return []
>
> sepBy1 :: Parser i a -> Parser i b -> Parser i [a]
> p `sepBy1` sep = do { a  <- p; as <- many (sep >> p); return (a:as) }
