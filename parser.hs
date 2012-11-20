-- This content is released under the (Link Goes Here) MIT License.
{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults  #-}

module Parser (Parser,                  
               get,
               choose,
               (<|>),
               satisfy,
               doParse,
               ParserG,
               getG,
               (<||>),
               satisfyG,
               doParseG
               ) where

import Control.Monad

newtype Parser a = P (String -> [(a, String)])

newtype ParserG a b = PG ([a] -> [(b, [a])])

doParse :: Parser a -> String -> [(a, String)] 
doParse (P p) s = p s

doParseG :: ParserG a b -> [a] -> [(b, [a])]
doParseG (PG pg) as = pg as

-- | Return the next character
-- (this was called 'oneChar' in lecture)
get :: Parser Char
get = P (\cs -> case cs of 
                (x:xs) -> [ (x,xs) ]
                []     -> [])

getG :: ParserG a a
getG = PG (\as -> case as of
                    (a:as') -> [ (a,as') ]
                    []      -> [] )


-- | Return the next character if it satisfies the given predicate
-- (this was called satP in lecture)
satisfy :: (Char -> Bool) -> Parser Char
satisfy p = do c <- get
               if (p c) then return c else fail "End of input"

satisfyG :: (a -> Bool) -> ParserG a a
satisfyG p = do a <- getG
                if (p a) then return a else fail "End of input"

instance Monad Parser where
   p1 >>= fp2 = P (\cs -> do (a,cs') <- doParse p1 cs 
                             doParse (fp2 a) cs') 

   return x   = P (\cs -> [ (x, cs) ])

   fail _     = P (\_ ->  [ ] )

instance Monad (ParserG a) where
   p1 >>= fp2 = PG (\as -> do (a, as') <- doParseG p1 as
                              doParseG (fp2 a) as')

   return x   = PG (\as -> [ (x, as) ])

   fail _     = PG (\_ -> [] )

instance Functor Parser where
   fmap f p = do x <- p
                 return (f x)

instance Functor (ParserG a) where
   fmap f p = do x <- p
                 return (f x)

-- | Combine two parsers together in parallel, producing all 
-- possible results from either parser.                 
choose :: Parser a -> Parser a -> Parser a
p1 `choose` p2 = P (\cs -> doParse p1 cs ++ doParse p2 cs)

chooseG :: ParserG a b -> ParserG a b -> ParserG a b
p1 `chooseG` p2 = PG (\as -> doParseG p1 as ++ doParseG p2 as)


-- | Combine two parsers together in parallel, but only use the 
-- first result. This means that the second parser is used only 
-- if the first parser completely fails. 
(<|>) :: Parser a -> Parser a -> Parser a
p1 <|> p2 = P $ \cs -> case doParse (p1 `choose` p2) cs of
                          []   -> []
                          x:_ -> [x]

(<||>) :: ParserG a b -> ParserG a b -> ParserG a b
p1 <||> p2 = PG $ \as -> case doParseG (p1 `chooseG` p2) as of
                          []  -> []
                          x:_ -> [x]