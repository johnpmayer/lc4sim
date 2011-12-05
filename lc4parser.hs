{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults  #-}

module LC4Parser where

-- | Parses LC4 lines. 
-- Ignores all comments unless they are on a separate line.

import LC4VM
import Parser
import ParserCombinators

import Test.HUnit

-- | Parse a String as a specific datatype. 
constP :: String -> a -> Parser a
constP s a = string s >> return a

-- | Parses an LC4 hexadecimal representation.
hexP :: Parser Int
hexP = do _ <- char 'x'
          i <- int
          return i

-- | Parses an LC4 decimal representation. 
decP :: Parser Int
decP = do _ <- char '#'
          i <- int
          return i
          
-- | Parses an LC4 integer of any representation.
intP :: Parser Int
intP = hexP <|> decP

-- | Removes whitespace from Parser feed
wsP :: Parser a -> Parser a
wsP p = do a <- p
           _ws <- many (char ' ' <|> char '\n')
           return a

-- | Parses an LC4 operation that expects 3 register arguments
triOpP :: Parser (Register -> Register -> Register -> Instruction) 
triOpP = constP "ADD" ADD <|>
         constP "MUL" MUL <|>
         constP "SUB" SUB <|> 
         constP "DIV" DIV <|>
         constP "AND" AND <|> 
         constP "OR"  OR  <|>
         constP "XOR" XOR <|>
         constP "MOD" MOD

-- | Parses an LC4 operation that expects 2 register arguments
biOpP :: Parser (Register -> Register -> Instruction)
biOpP = constP "CMP"  CMP  <|>
        constP "CMPU" CMPU <|>
        constP "NOT"  NOT

-- | Parses an LC4 operation that expects 1 register argument
uOpP :: Parser (Register -> Instruction) 
uOpP = constP "JSRR" JSRR <|>
       constP "JMPR" JMPR
       
-- | Parses an LC4 operation that expects 2 register and 1 IMM arguments.
triOpImmP :: Parser (Register -> Register -> Int -> Instruction)
triOpImmP = constP "ADD" ADDI <|>
            constP "AND" ANDI <|>
            constP "LDR" LDR  <|>
            constP "STR" STR  <|>
            constP "SLL" SLL  <|>
            constP "SRA" SRA  <|>
            constP "SRL" SRL
            
-- | Parses an LC4 operation that expects 1 register and 1 IMM argument
biOpRegImmP :: Parser (Register -> Int -> Instruction) 
biOpRegImmP = constP "CMPI"  CMPI  <|>
              constP "CMPIU" CMPIU <|>
              constP "CONST" CONST <|>
              constP "HICONST" HICONST

-- | Parses a branch condition. 
branchCondP :: Parser BC
branchCondP = constP "n"  N  <|> 
              constP "nz" NZ <|>
              constP "np" NP <|>
              constP "z"  Z  <|>
              constP "zp" ZP <|>
              constP "p"  P  <|>
              constP "nzp" NZP

-- | Parses an LC4 Instruction. 
insnP :: Parser Instruction
insnP = choice [constInsnP, brP, triRegOpP, duoRegOpP, unoRegOpP,
                duoRegImmOpP, regImmOpP, regLblOpP, lblOpP, immOpP]
        where
          -- Instructions that take no args
          constInsnP = choice [constP "NOP" NOP,
                               constP "RTI" RTI,
                               constP "RET" RET]
          -- Branches
          brP = 
            do op <- constP "BR" BR
               bc <- branchCondP
               l  <- labelP
               return $ op bc l
          -- Instructions that take 3 register args
          triRegOpP = 
            do op <- triOpP
               r1 <- regP
               r2 <- regP
               r3 <- regP
               return $ op r1 r2 r3
          -- Insns that take 2 reg args
          duoRegOpP = 
            do op <- biOpP
               r1 <- regP
               r2 <- regP
               return $ op r1 r2
          -- Insns that take 1 reg arg
          unoRegOpP = 
            do op <- uOpP
               r1 <- regP
               return $ op r1
          -- Insns that take 2 reg and 1 Imm arg
          duoRegImmOpP = 
            do op <- triOpImmP
               r1 <- regP
               r2 <- regP
               i <- intP
               return $ op r1 r2 i
          -- Insns that take 1 Imm arg
          immOpP = 
            do op <- constP "TRAP" TRAP
               i  <- intP
               return $ op i
          -- Takes a reg and a label
          regLblOpP = 
            do op <- constP "LEA" LEA <|> constP "LC" LC
               r1 <- regP
               l  <- labelP
               return $ op r1 l
          -- Takes a label
          lblOpP = 
            do op <- constP "JSR" JSR <|> constP "JMP" JMP
               l <- labelP 
               return $ op l
          -- Takes a reg and an imm
          regImmOpP = 
            do op <- biOpRegImmP
               r1 <- regP
               i  <- intP
               return $ op r1 i

-- | Parses an LC4 Comment. 
-- TODO: can be any alphanumeric and/or more characters. 
commentP :: Parser String
commentP = 
  do _delim <- many1 $ char ';'
     com <- many (alpha <|> digit <|> symbolP)
     return com

-- | Parses an LC4 directive
directiveP :: Parser Directive
directiveP = choice [constP ".DATA" D_DATA,
                     constP ".CODE" D_CODE,
                     constP ".ADDR" D_ADDR >>= 
                      \d -> intP >>= \i -> return $ d i,
                     constP ".FALIGN" D_FALIGN,
                     constP ".FILL" D_FILL >>=
                       \d -> intP >>= \i -> return $ d i,
                     constP ".BLKW" D_BLKW >>=
                       \d -> intP >>= \i -> return $ d i,
                     constP ".CONST" D_CONST >>= 
                       \d -> intP >>= \i -> return $ d i,
                     constP ".UCONST" D_UCONST >>=
                       \d -> intP >>= \i -> return $ d i]

-- | Parses a labeled LC4 Directive


-- | Parses a labeled LC4 Instruction
lblInsnP :: Parser Line
lblInsnP = 
  do lbl <- labelP
     insn <- insnP 
     return $ Insn insn (Just lbl)
     
-- | Parses an unlabled LC4 Instruction
unLblInsnP :: Parser Line
unLblInsnP = 
  do insn <- insnP
     return $ Insn insn Nothing

-- | Parse a line as either insn, comment, or directive.
lineP :: Parser Line
lineP = choice [lblInsnP, unLblInsnP, 
                commentP >>= \c -> return $ Comment c, 
                directiveP >>= \d -> return $ Dir d]
             
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

-- | Parses an LC4-accepted symbol
symbolP :: Parser Char
symbolP = char '_' <|> char '-'

-- | Parses an LC4 label
labelP :: Parser Label
labelP = 
  do a <- alpha 
     b <- many1 (alpha <|> digit <|> symbolP)
     return $ a ++ b

-- TEST CASES --

-- t1 :: Test