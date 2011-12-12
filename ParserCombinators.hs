{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults #-}

-- CIS 552, University of Pennsylvania
-- based on Parsec and ReadP parsing libraries
module ParserCombinators where

import Parser
import Control.Monad
import Data.Char
import System.IO

            
type ParseError = String

-- | Use a parser for a particular string. Note that this parser
-- combinator library doesn't support descriptive parse errors.
-- However, for compatibility with Parsec, we give this function 
-- the same type.
parse :: Parser a -> String -> Either ParseError a
parse parser str = case (doParse parser str) of 
    []      -> Left $ "No parse on: " ++ str
    [(a,_)] -> Right a
    -- [(_,rem')] -> Left $ "Didn't consume entire line" ++ 
    --                   "\n\t" ++ str ++
    --                   "\n\t remained: " ++ rem'
    _       -> Left $ "Multiple parses on: " ++ str



parseG :: Show a => ParserG a b -> [a] -> Either ParseError b
parseG p as = case (doParseG p as) of
                []      -> Left "No parses"
                [(b,rest)] -> if null rest then Right b else Left $ show rest
                _       -> Left "Multiple parses"
    
parseFromFile :: Parser a -> String -> IO (Either ParseError a)
parseFromFile parser filename = do 
  handle <- openFile filename ReadMode 
  str <- hGetContents handle
  return $ parse parser str  

parseFromFileG :: Show a => Parser [a] -> ParserG a b -> String -> IO (Either ParseError b)
parseFromFileG lexer parser filename = do
  handle <- openFile filename ReadMode
  str <- hGetContents handle
  let eToks = parse lexer str
  return $ (case eToks of
             Left e -> Left e
             Right toks -> parseG parser toks)

-- | Parsers for specific sorts of characters 
alpha, digit, upper, lower, space :: Parser Char
alpha = satisfy isAlpha
digit = satisfy isDigit            
upper = satisfy isUpper
lower = satisfy isLower
space = satisfy isSpace
   
-- | Parsers and returns the specified character        
-- succeeds only if the input is exactly that character
char :: Char -> Parser Char
char c = satisfy (c ==)   

specificG :: Eq a => a -> ParserG a a
specificG a = satisfyG (a ==)

-- | Parses and returns the specified string. 
-- Succeeds only if the input is the given string
string :: String -> Parser String
string = mapM char

-- | succeed only if the input is a (positive or negative) integer
int :: Parser Int
int = do n <- string "-" <|> return []
         s <- many1 digit  
         return $ (read (n ++ s) :: Int)

-- | given a parser, apply it as many times as possible                         
-- and return the answer in a list
many   :: Parser a -> Parser [a]
many p = many1 p <|> many0 
   where many0 = return []
                    
-- | given a parser, apply it as many times as possible,
-- but at least once.
many1 :: Parser a -> Parser [a]
many1 p = do x  <- p
             xs <- many p
             return (x:xs)

-- | @chainl p op x@ parses zero or more occurrences of @p@, separated by @op@.
--   Returns a value produced by a /left/ associative application of all
--   functions returned by @op@. If there are no occurrences of @p@, @x@ is
--   returned.
chainl :: Parser b -> Parser (b -> b -> b) -> b -> Parser b
chainl p op x = chainl1 p op <|> return x

-- | Like 'chainl', but parses one or more occurrences of @p@.
chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
p `chainl1` pop = p >>= rest
    where rest x = next x <|> return x 
          next x = do o <- pop
                      y <- p
                      rest $ x `o` y

chainl1G :: ParserG a b -> ParserG a (b -> b -> b) -> ParserG a b
p `chainl1G` pop = p >>= rest
    where rest x = next x <||> return x
          next x = do o <- pop
                      y <- p
                      rest $ x `o` y
                      
-- | Combine all parsers in the list (sequentially)
choice :: [Parser a] -> Parser a
choice = foldr (<|>) (fail "")

choiceG :: [ParserG a b] -> ParserG a b
choiceG = foldr (<||>) (fail "no parse")

-- | @between open close p@ parses @open@, followed by @p@ and finally
--   @close@. Only the value of @p@ is returned.
between :: Parser open -> Parser a -> Parser close -> Parser a
between open p close = do _ <- open
                          x <- p
                          _ <- close
                          return x

-- | @sepBy p sep@ parses zero or more occurrences of @p@, separated by @sep@.
--   Returns a list of values returned by @p@.
sepBy :: Parser a -> Parser sep -> Parser [a]
sepBy p sep = sepBy1 p sep <|> return []

-- | @sepBy1 p sep@ parses one or more occurrences of @p@, separated by @sep@.
--   Returns a list of values returned by @p@.
sepBy1 :: Parser a -> Parser sep -> Parser [a]
sepBy1 p sep = liftM2 (:) p (many (sep >> p))


