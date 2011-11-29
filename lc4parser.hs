{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults  #-}

import LC4VM

import qualified Parser as PS
import ParserCombinators

-- Parse the lines left to write and delegate to another parser
-- as necessary

insnP :: PS.Parser Instruction
insnP = undefined

-- Can't figure this one out except for making a huge case switch
-- on the IMM width, which seems stupid. Any ideas?
-- immP :: Imm n -> PS.Parser Imm n
-- immP w = char '#' >> 
--         int >>= \i -> return $ Imm n

-- | Parses a register identifier
-- Todo: error handling
regP :: PS.Parser Register
regP = char 'R' >>
       int >>= \i -> 
       return $ case i of 
         0 -> R0
         1 -> R1
         2 -> R2
         3 -> R3
         4 -> R4
         5 -> R5
         6 -> R6
         7 -> R7
         _ -> error "Wrong register name!"

labelP :: PS.Parser Label
labelP = many1 (alpha PS.<|> digit)

