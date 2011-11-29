
{-# OPTIONS_GHC -Wall #-}

module Simulator where

import Control.Monad.State
import qualified Data.Map as M

import LC4VM

step :: State (VMState) ()
step = do (prog, _, _, _, _, pc, _) <- get
          exec $ case M.lookup pc prog of
                       Just (_, (Insn insn)) -> insn
                       _                          -> NOP

updatePC :: Imm U16 -> State (VMState) ()
updatePC target = do (prog, lbls, regFile, mem, brks, _, cc) <- get
                     put (prog, lbls, regFile, mem, brks, target, cc)

exec :: Instruction -> State (VMState) ()
exec NOP = return ()

exec (BR bc lbl) = do (_, lbls, _, _, _, _, cc) <- get
                      if (case bc of
                                       N -> cc == CC_N
                                       Z -> cc == CC_Z
                                       P -> cc == CC_P
                                       NZ -> cc == CC_N
                                          || cc == CC_Z
                                       NP -> cc == CC_N
                                          || cc == CC_P
                                       ZP -> cc == CC_Z
                                          || cc == CC_P
                                       NZP -> True)
                      then do let target = case M.lookup lbl lbls of
                                               Nothing   -> error "bad label"
                                               Just lbl' -> lbl'
                              updatePC target
                      else return ()

