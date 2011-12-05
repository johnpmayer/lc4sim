
{-# LANGUAGE GADTs #-}

module LC4VM where

import Data.Int (Int16)
import Data.Map (Map)
import Data.Set (Set)

import Immediate

type LineNumber = Int
type Label = String

data Line = Insn Instruction
          | Comment String
          | Dir Directive

data Directive = D_DATA
               | D_CODE
               | D_ADDR (Imm U16)
               | D_FALIGN
               | D_FILL (Imm I16)
               | D_BLKW (Imm U16)
               | D_CONST (Imm I16)
               | D_UCONST (Imm U16)

data Register = R0
              | R1
              | R2
              | R3
              | R4
              | R5
              | R6
              | R7

-- Parser builds these
type Program = Map (Imm U16) (LineNumber, Line)
type Labels = Map Label (Imm U16)

-- Mutable state
type RegisterFile = Map Register (Imm U16)
type Memory = Map (Imm U16) (Imm U16)
type Breakpoints = Set LineNumber
data CC = CC_N | CC_Z | CC_P deriving Eq
type PC = (Imm U16)

type VMState = (Program, Labels, RegisterFile, Memory, Breakpoints, PC, CC)

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
                 | Addi Register Register (Imm I5)
                 | CMP Register Register
                 | CMPU Register Register
                 | CMPI Register (Imm I7)
                 | CMPIU Register (Imm U7)
                 | JSR Label
                 | JSRR Register
                 | AND Register Register Register
                 | NOT Register Register
                 | OR Register Register Register
                 | XOR Register Register Register
                 | ANDI Register Register (Imm I5)
                 | LDR Register Register (Imm I6)
                 | STR Register Register (Imm I6)
                 | RTI
                 | CONST Register (Imm I9)
                 | SLL Register Register (Imm U4)
                 | SRA Register Register (Imm U4)
                 | SRL Register Register (Imm U4)
                 | MOD Register Register Register
                 | JMPR Register
                 | JMP Label
                 | HICONST Register (Imm U8)
                 | TRAP (Imm U8)
                 -- Psuedo-Instructions
                 | RET
                 | LEA Register Label
                 | LC Register Label

