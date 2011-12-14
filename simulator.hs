
{-# OPTIONS_GHC -Wall #-}

module Simulator where

import Control.Monad.State
import Data.Bits
import qualified Data.Map as M

import LC4VM

readPC :: State VMState PC
readPC = liftM pc get

updatePC :: Int -> State (VMState) ()
updatePC target = get >>= (\s -> put s {pc = target})

incrPC :: State (VMState) ()
incrPC = liftM pc get >>= (\pc' -> updatePC $ pc' + 1)

readRegister :: Register -> State (VMState) Int
readRegister r = liftM ((regValue r).regFile) get

writeRegister :: Register -> Int -> State (VMState) ()
writeRegister r u16 = do vmState <- get
                         let rf = regFile vmState
                         let rf' = M.insert r u16 rf
                         put vmState {regFile = rf'}

readMemory :: Int -> State (VMState) Int
readMemory addr = liftM ((memValue addr).memory) get

writeMemory :: Int -> Int -> State VMState ()  
writeMemory addr val = do vmState <- get
                          let mem = memory vmState
                          let mem' = M.insert addr val mem
                          put vmState {memory = mem'}

stepSimpleBop :: (Int -> Int -> Int) ->
                 Register -> Register -> Register -> 
                 State (VMState) ()
stepSimpleBop bop s1 s2 d = 
  do input1 <- readRegister s1
     input2 <- readRegister s2
     writeRegister d $ input1 `bop` input2

readCC :: State (VMState) CC
readCC = liftM cc get

orderingToCC :: Ordering -> CC
orderingToCC ord = case ord of
       LT -> CC_N
       EQ -> CC_Z
       GT -> CC_P

writeConditionCode :: Ordering -> State VMState ()
writeConditionCode ord = get >>= (\s -> put s {cc = orderingToCC ord})

derefLabel :: Label -> State VMState Int
derefLabel lbl = liftM ((lblValue lbl).lbls) get

setPSR :: Bool -> State VMState ()
setPSR b = get >>= (\s -> put s {psr = b})

evalBranch :: CC -> BC -> Bool
evalBranch cc' bc' = case bc' of
                                       N -> cc' == CC_N
                                       Z -> cc' == CC_Z
                                       P -> cc' == CC_P
                                       NZ -> cc' == CC_N
                                          || cc' == CC_Z
                                       NP -> cc' == CC_N
                                          || cc' == CC_P
                                       ZP -> cc' == CC_Z
                                          || cc' == CC_P
                                       NZP -> True

nextStep :: State (VMState) ()
nextStep = 
  do
    s <- get
    case M.lookup (pc s) (prog s) of
      Nothing -> error "PC at loaction with no valid instruction"
      Just insn -> step insn

step :: Instruction -> State (VMState) ()
step NOP = incrPC

step (BR bc lbl) = do cc' <- readCC
                      target <- derefLabel lbl
                      if evalBranch cc' bc
                      then updatePC target
                      else incrPC

step (ADD d s1 s2) = stepSimpleBop (+) s1 s2 d >> incrPC
step (MUL d s1 s2) = stepSimpleBop (*) s1 s2 d >> incrPC
step (SUB d s1 s2) = stepSimpleBop (-) s1 s2 d >> incrPC
step (DIV d s1 s2) = stepSimpleBop div s1 s2 d >> incrPC

step (ADDI d s i) = do input <- readRegister s
                       writeRegister d $ input + i
                       incrPC

step (CMP s1 s2) = do i1 <- readRegister s1
                      i2 <- readRegister s2
                      writeConditionCode $ i1 `compare` i2
                      incrPC

step (CMPU s1 s2) = do i1 <- readRegister s1
                       i2 <- readRegister s2
                       writeConditionCode $ i1 `compare` i2
                       incrPC

step (CMPI s imm) = do i1 <- readRegister s
                       writeConditionCode $ i1 `compare` imm
                       incrPC

step (CMPIU s imm) = do i1 <- readRegister s
                        writeConditionCode $ i1 `compare` imm
                        incrPC

step (JSR lbl) = do pc' <- derefLabel lbl
                    updatePC pc'

step (JSRR s) = do pc' <- readRegister s
                   updatePC pc'

step (AND d s1 s2) = stepSimpleBop (.&.) s1 s2 d >> incrPC
step (OR d s1 s2)  = stepSimpleBop (.|.) s1 s2 d >> incrPC

step (NOT d s) = do i <- readRegister s
                    writeRegister d $ complement i
                    incrPC

step (XOR d s1 s2) = stepSimpleBop xor s1 s2 d >> incrPC

step (ANDI d s imm) = do i <- readRegister s
                         writeRegister d $ i .&. imm
                         incrPC

step (LDR d s offset) = do addr <- readRegister s
                           val  <- readMemory (addr + offset)
                           writeRegister d val
                           incrPC

step (STR d s offset) = do addr <- readRegister s
                           val  <- readRegister d
                           writeMemory (addr + offset) val
                           incrPC

step RTI = do readRegister R7 >>= updatePC
              setPSR False

step (CONST d imm) = writeRegister d imm >> incrPC

step (SLL d s imm) = do i <- readRegister s
                        writeRegister d $ i `shiftL` imm
                        incrPC

step (SRA d s imm) = do i <- readRegister s
                        writeRegister d $ i `shiftR` imm
                        incrPC

step (SRL _d _s _imm) = error "todo: SRL" >> incrPC

step (MOD d s1 s2) = stepSimpleBop mod s1 s2 d >> incrPC

step (JMPR r) = readRegister r >>= updatePC

step (JMP lbl) = derefLabel lbl >>= updatePC

step (HICONST d imm) = do i <- readRegister d
                          writeRegister d $
                            (i .&. 255) .|. (i `shiftL` imm)
                          incrPC

step (TRAP uimm) = do readPC >>= writeRegister R7
                      updatePC (uimm .|. (1 `shiftL` 15))
                      setPSR True
                      
step RET = step $ JMPR R7

step (LEA r lbl) = derefLabel lbl >>= writeRegister r >> incrPC

step (LC _r _lbl) = error "todo constants?" >> incrPC

