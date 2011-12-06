{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults  #-}

module LC4Parser where

-- | Parses LC4 lines. 
-- Ignores all comments unless they are on a separate line.

import LC4VM
import Parser
import ParserCombinators


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
               bc <- wsP branchCondP
               l  <- endlineP labelP
               return $ op bc l
          -- Instructions that take 3 register args
          triRegOpP = 
            do op <- wsP triOpP
               r1 <- wsP regP
               _  <- wsP $ char ','
               r2 <- wsP regP
               _  <- wsP $ char ','
               r3 <- endlineP regP
               return $ op r1 r2 r3
          -- Insns that take 2 reg args
          duoRegOpP = 
            do op <- wsP biOpP
               r1 <- wsP regP
               _  <- wsP $ char ','
               r2 <- endlineP regP
               return $ op r1 r2
          -- Insns that take 1 reg arg
          unoRegOpP = 
            do op <- wsP uOpP
               r1 <- endlineP regP
               return $ op r1
          -- Insns that take 2 reg and 1 Imm arg
          duoRegImmOpP = 
            do op <- wsP triOpImmP
               r1 <- wsP regP
               _  <- wsP $ char ','
               r2 <- wsP regP
               _  <- wsP $ char ','
               i <- endlineP intP
               return $ op r1 r2 i
          -- Insns that take 1 Imm arg
          immOpP = 
            do op <- wsP $ constP "TRAP" TRAP
               i  <- endlineP intP
               return $ op i
          -- Takes a reg and a label
          regLblOpP = 
            do op <- wsP $ constP "LEA" LEA <|> constP "LC" LC
               r1 <- wsP $ regP
               l  <- endlineP labelP
               return $ op r1 l
          -- Takes a label
          lblOpP = 
            do op <- wsP $ constP "JSR" JSR <|> constP "JMP" JMP
               l <- endlineP $ labelP 
               return $ op l
          -- Takes a reg and an imm
          regImmOpP = 
            do op <- wsP $ biOpRegImmP
               r1 <- wsP $ regP
               _  <- wsP $ char ','
               i  <- endlineP $ intP
               return $ op r1 i

-- | Parses an LC4 Comment. 
commentP :: Parser String
commentP = 
  do _delim <- many1 $ char ';'
     com <- many (alpha <|> digit <|> symbolP)
     _newline <- char '\n'
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
lblDirectiveP :: Parser Line
lblDirectiveP = 
  do lbl <- wsP $ labelP
     dir <- endlineP $ directiveP
     return $ Dir dir (Just lbl)
     
-- | Parses an unlabeled LC4 directive
unLblDirectiveP :: Parser Line
unLblDirectiveP = endlineP directiveP >>= \d -> return $ Dir d Nothing

-- | Parse a line as either insn, comment, or directive.
lineP :: Parser Line
lineP = choice [labelP >>= \l -> return $ Label l,
                insnP >>= \i -> return $ Insn i,
                lblDirectiveP, unLblDirectiveP,
                wsP (string "\n" <|> commentP) >> return Empty]
             
-- | Removes whitespace after a parse
wsP :: Parser a -> Parser a
wsP p = do a <- p
           _ws <- many $ char ' '
           return a
           
-- | Removes any comments and a newline after a parse
endlineP :: Parser a -> Parser a
endlineP p = do a <- p
                _ws <- string "\n" <|> commentP
                return a
        
-- | Parses a register identifier
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
     return $ a:b

