
module LC4VM where

import Data.Int (Int16)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe
import Data.Set (Set)
import qualified Data.Set as S
import Control.Monad.State

type LineNumber = Int
type Label = String

data Line = Label Label
          | Insn Instruction
          | Dir Directive (Maybe Label)
          | Empty
       deriving Show

-- These are data directives
data Directive = D_DATA
               | D_CODE
               | D_ADDR Int
               | D_FALIGN
               | D_FILL Int
               | D_BLKW Int
               | D_CONST Int
               | D_UCONST Int
  deriving Show

data Register = R0
              | R1
              | R2
              | R3
              | R4
              | R5
              | R6
              | R7
  deriving (Eq, Ord, Show)

-- Parser builds these
type Program = Map Int Instruction -- (LineNumber, Line)
-- | A map from labels to addresses
type Labels = Map Label Int

-- Mutable state
type RegisterFile = Map Register Int
type Memory = Map Int Int
type Breakpoints = Set LineNumber
data CC = CC_N | CC_Z | CC_P deriving (Eq, Show)
type PC = Int

regValue :: Register -> RegisterFile -> Int
regValue reg regFile = fromMaybe 0 $ M.lookup reg regFile

memValue :: Int -> Memory -> Int
memValue addr mem = fromMaybe 0 $ M.lookup addr mem
lblValue :: Label -> Labels -> Int
lblValue lbl labels =
  fromMaybe (error "missing label") $ M.lookup lbl labels

data VMState = VM { prog :: Program,
                    lbls :: Labels,
                    regFile :: RegisterFile,
                    memory :: Memory,
                    brks :: Breakpoints,
                    pc :: PC,
                    cc :: CC,
                    psr :: Bool }
             deriving (Eq, Show)

data BC = N
        | NZ
        | NP
        | Z
        | ZP
        | P
        | NZP
  deriving (Eq, Show)

data Instruction = NOP
                 | BR BC Label
                 | ADD Register Register Register
                 | MUL Register Register Register
                 | SUB Register Register Register
                 | DIV Register Register Register
                 | ADDI Register Register Int
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
  deriving (Eq, Show)
