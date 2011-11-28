
{-# LANGUAGE GADTs #-}

module LC4VM where

import Data.Int (Int16)
import Data.Map (Map)
import Data.Set (Set)

type Label = String
type LineNumber = Int

data Line = Insn Instruction
          | Comment String
          | Directive String

data Register = R0 
              | R1
              | R2
              | R3
              | R4
              | R5
              | R6
              | R7

type RegisterFile = Map Register Int16
type Program = Map LineNumber Line
type Memory = Map Int16 Int16
type Breakpoints = Set LineNumber

data CC = CC_N 
        | CC_Z 
        | CC_P

type VMState = (RegisterFile, Program, Memory, Breakpoints, CC)

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

data BC = N
        | NZ
        | NP
        | Z
        | ZP
        | P
        | NZP

data Instruction = NOP
                 | BR BC Label
                 | ADD Register Register Register
                 | MUL Register Register Register
                 | SUB Register Register Register
                 | DIV Register Register Register
                 | Addi Register Register (IMM I5)
                 | CMP Register Register

-- todo move to the parser
checkIMM :: IMM n -> Bool
checkIMM (IMM5 n) = False

