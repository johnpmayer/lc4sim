
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
               | D_ADDR Int
               | D_FALIGN
               | D_FILL Int
               | D_BLKW Int
               | D_CONST Int
               | D_UCONST Int

data Register = R0
              | R1
              | R2
              | R3
              | R4
              | R5
              | R6
              | R7

-- Parser builds these
type Program = Map Int (LineNumber, Line)
type Labels = Map Label Int

-- Mutable state
type RegisterFile = Map Register Int
type Memory = Map Int Int
type Breakpoints = Set LineNumber
data CC = CC_N | CC_Z | CC_P deriving Eq
type PC = Int

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
                 | AddI Register Register Int
                 | CMP Register Register
                 | CMPU Register Register
                 | CMPI Register Int
                 | CMPIU Register Int
                 | JSR Label
                 | JSRR Register
                 | AND Register Register Register
                 | NOT Register Register
                 | OR Register Register Register
                 | XOR Register Register Register
                 | ANDI Register Register Int
                 | LDR Register Register Int
                 | STR Register Register Int
                 | RTI
                 | CONST Register Int
                 | SLL Register Register Int
                 | SRA Register Register Int
                 | SRL Register Register Int
                 | MOD Register Register Register
                 | JMPR Register
                 | JMP Label
                 | HICONST Register Int
                 | TRAP Int
                 -- Psuedo-Instructions
                 | RET
                 | LEA Register Label
                 | LC Register Label

