-- This content is released under the (Link Goes Here) MIT License.
{-# OPTIONS -Wall -fwarn-tabs -fno-warn-type-defaults  #-}

module LC4Parser where

-- | Parses LC4 lines. 
-- Ignores all comments unless they are on a separate line.

import Data.Char

import LC4VM
import Parser
import ParserCombinators

pow16 :: Int -> Int
pow16 0 = 1
pow16 x = 16 * pow16 (x-1)

hexToDec :: String -> Int
hexToDec [] = 0
hexToDec (x:xs) = digitToInt x * (pow16 $ length xs) + hexToDec xs

-- | Parse a String as a specific datatype. 
constP :: String -> a -> Parser a
constP s a = string s >> return a

-- | Parses an LC4 hexadecimal representation.
hexP :: Parser Int
hexP = do _ <- string "0x" <|> string "x"
          hexString <- many.choice $ [ char 'a', char 'b', 
                                       char 'c', char 'd',
                                       char 'e', char 'f',
                                       digit ]
          let i = hexToDec hexString
          if i < 0 then fail ""  -- Because this is a hex number, not a decimal. 
            else return i

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
-- Order is important. 
branchCondP :: Parser BC
branchCondP = choice [constP "nzp" NZP,
                      constP "nz" NZ,
                      constP "np" NP,
                      constP "zp" ZP,
                      constP "z"  Z ,
                      constP "n"  N,
                      constP "p"  P 
                     ]

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
               l  <- labelP
               return $ op bc l
          -- Instructions that take 3 register args
          triRegOpP = 
            do op <- wsP triOpP
               r1 <- wsP regP
               _  <- wsP $ char ','
               r2 <- wsP regP
               _  <- wsP $ char ','
               r3 <- regP
               return $ op r1 r2 r3
          -- Insns that take 2 reg args
          duoRegOpP = 
            do op <- wsP biOpP
               r1 <- wsP regP
               _  <- wsP $ char ','
               r2 <- regP
               return $ op r1 r2
          -- Insns that take 1 reg arg
          unoRegOpP = 
            do op <- wsP uOpP
               r1 <- regP
               return $ op r1
          -- Insns that take 2 reg and 1 Imm arg
          duoRegImmOpP = 
            do op <- wsP triOpImmP
               r1 <- wsP regP
               _  <- wsP $ char ','
               r2 <- wsP regP
               _  <- wsP $ char ','
               i <- intP
               return $ op r1 r2 i
          -- Insns that take 1 Imm arg
          immOpP = 
            do op <- wsP $ constP "TRAP" TRAP
               i  <- intP
               return $ op i
          -- Takes a reg and a label
          regLblOpP = 
            do op <- wsP $ constP "LEA" LEA <|> constP "LC" LC
               r1 <- wsP $ regP
               _ <- wsP $ char ','
               l  <- labelP
               return $ op r1 l
          -- Takes a label
          lblOpP = 
            do op <- wsP $ constP "JSR" JSR <|> constP "JMP" JMP
               l  <- labelP 
               return $ op l
          -- Takes a reg and an imm
          regImmOpP = 
            do op <- wsP $ biOpRegImmP
               r1 <- wsP $ regP
               _  <- wsP $ char ','
               i  <- intP
               return $ op r1 i

-- | Parses an LC4 Comment. 
commentP :: Parser String
commentP = 
  do _delim <- wsP . many1 $ char ';'
     com <- many get
     return com

-- | Parses an LC4 directive
directiveP :: Parser Directive
directiveP = choice [constP ".DATA" D_DATA,
                     constP ".CODE" D_CODE,
                     argedDirectiveP ".ADDR" D_ADDR,
                     constP ".FALIGN" D_FALIGN,
                     argedDirectiveP ".FILL" D_FILL,
                     argedDirectiveP ".BLKW" D_BLKW,
                     argedDirectiveP ".CONST" D_CONST, 
                     argedDirectiveP ".UCONST" D_UCONST
                    ]
  where 
    -- | For directives that require an integer argument
    argedDirectiveP :: String -> (Int -> Directive) -> Parser Directive
    argedDirectiveP s d = 
      do d' <- wsP $ constP s d 
         i <- intP 
         return $ d' i

-- | Parses a labeled LC4 Directive
lblDirectiveP :: Parser Line
lblDirectiveP = 
  do lbl <- wsP $ labelP
     dir <- directiveP
     return $ Dir dir (Just lbl)
     
-- | Parses an unlabeled LC4 directive
unLblDirectiveP :: Parser Line
unLblDirectiveP = directiveP >>= \d -> return $ Dir d Nothing

-- | Parses an empty line (Comment, whitespace)
emptyP :: Parser Line
emptyP = many (string " " <|> commentP) >> 
         string "" >>
         return Empty

-- | Parse a line as either insn, comment, or directive.
lineP :: Parser Line
lineP = 
  do 
    _ws <- many (char ' ' <|> char '\t')
    choice [insnP >>= \i -> return $ Insn i,
            lblDirectiveP, 
            unLblDirectiveP,
            labelP >>= \l -> return $ Label l,
            emptyP
           ]
             
-- | Removes whitespace after a parse
wsP :: Parser a -> Parser a
wsP p = do a <- p
           _ws <- many $ char ' ' <|> char '\t'
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

