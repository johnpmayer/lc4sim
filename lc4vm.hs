
{-# LANGUAGE GADTs #-}

type Label = String

data Register = R0 
              | R1
              | R2
              | R3
              | R4
              | R5
              | R6
              | R7

data I5
data I7
data I9
data I11

data U4
data U7
data U8

data IMM n where
  IMM5 :: Int -> IMM I5
  IMM7 :: Int -> IMM I7

data CC = N
        | NZ
        | NP
        | Z
        | ZP
        | P
        | NZP

data Instruction = NOP
                 | BR CC Label
                 | ADD Register Register Register
                 | MUL Register Register Register
                 | SUB Register Register Register
                 | DIV Register Register Register
                 | Addi Register Register (IMM I5)
                 