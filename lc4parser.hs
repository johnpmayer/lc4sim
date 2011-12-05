{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults  #-}

import LC4VM

import Parser
import ParserCombinators

-- Parse the lines left to write and delegate to another parser
-- as necessary

constP :: String -> a -> Parser a
constP s a = string s >> return a

-- | Parse a line as either insn, comment, or directive.
lineP :: Parser Line
lineP = choice [insnP >>= \insn -> return $ Insn insn, 
                commentP >>= \c -> return $ Comment c, 
                directiveP >>= \d -> return $ Dir d]

insnP :: Parser Instruction
insnP = choice [constInsnP, brP, triRegOpP, duoRegOpP, unoRegOpP,
                duoRegImmOpP, regImmOpP]
        where
          -- Instructions that take no args
          constInsnP = choice [constP "NOP" NOP,
                               constP "RTI" RTI,
                               constP "RET" RET]
          -- Branches
          brP = undefined
          -- Instructions that take 3 register args
          triRegOpP = undefined
          -- Insns that take 2 reg args
          duoRegOpP = undefined
          -- Insns that take 1 reg arg
          unoRegOpP = undefined
          -- Insns that take 2 reg and 1 Imm arg
          duoRegImmOpP = undefined
          -- Insns that take 1 Imm arg
          regImmOpP = undefined

commentP :: Parser String
commentP = 
  do _hash <- many1 $ char ';'
     com <- many alpha
     return com

-- | Parses an LC4 hexadecimal representation.
hexP :: Parser Int
hexP = do char 'x'
          i <- int
          return i

-- | Parses an LC4 decimal representation. 
decP :: Parser Int
decP = do char '#'
          i <- int
          return i

-- | Parses an LC4 directive
directiveP :: Parser Directive
directiveP = choice [constP ".DATA" D_DATA,
                     constP ".CODE" D_CODE,
                     parseAddr,
                     constP ".FALIGN" D_FALIGN,
                     parseFill,
                     parseBlkw,
                     parseConst,
                     parseUconst]
             where
               parseAddr :: Parser Directive
               parseAddr = 
                 do string ".ADDR"
                    i <- hexP <|> decP
                    return $ D_ADDR (UIMM16 i)
                   
               parseFill :: Parser Directive
               parseFill = 
                 do string ".FILL"
                    i <- hexP
                    return $ D_FILL (IMM16 i)
                 
               parseBlkw :: Parser Directive
               parseBlkw = 
                 do string ".BLKW"
                    i <- hexP
                    return $ D_BLKW (UIMM16 i)

               parseConst :: Parser Directive
               parseConst = 
                 do string ".CONST"
                    i <- hexP
                    return $ D_CONST (IMM16 i)

               parseUconst :: Parser Directive
               parseUconst = 
                 do string ".UCONST"
                    i <- hexP
                    return $ D_UCONST (UIMM16 i)
                    
               parseStringUD :: String -> Parser Directive
               parseStringUD s = 
                 do string s
                    
               
               
-- Can't figure this one out except for making a huge case switch
-- on the IMM width, which seems stupid. Any ideas?
-- Idea 1: Create seperate parser for each IMM type, and call that parser
--         depending on the insn.
--immP :: Imm n -> Parser Imm n
--immP w = char '#' >> 
--        int >>= \i -> return $ Imm n

immU16P :: Parser (Imm U16)
immU16P = int >>= \i -> return $ UIMM16 i

-- | Parses a register identifier
-- Todo: error handling
regP :: Parser Register
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
         _ -> error "Wrong register identifier!"

labelP :: Parser Label
labelP = many1 (alpha <|> digit)

