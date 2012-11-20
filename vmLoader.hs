-- This content is released under the (Link Goes Here) MIT License.

{-# OPTIONS_GHC -Wall #-}

module VMLoader where

import Control.Monad.State
import Data.Map (Map)
import qualified Data.Map as M
import qualified Data.Set as S

import LC4VM

data LoaderMode = START | CODE | DATA deriving Eq

data LoaderState = L { mode :: LoaderMode,
                       addr :: Int,
                       prog :: Program,
                       lbls :: Labels,
                       brks :: Breakpoints,
                       mem :: Memory }

blankRegFile :: Map Register Int
blankRegFile = M.fromList [ (R0,0),
                            (R1,0),
                            (R2,0),
                            (R3,0),
                            (R4,0),
                            (R5,0),
                            (R6,0),
                            (R7,0) ]

initial :: LoaderState
initial = L START 0 M.empty M.empty S.empty M.empty

load :: [Line] -> VMState
load ls = convert $ execState (loadAll ls) initial where

  convert :: LoaderState -> VMState
  convert (L _ _a p lbls' brks' mem') = 
    VM p lbls' blankRegFile mem' brks' 0 CC_Z False

  loadAll :: [Line] -> State LoaderState ()
  loadAll = foldl (\soFar line -> soFar >> (loadLine line)) (return ())

addLabel :: Label -> State LoaderState ()
addLabel lbl =
  do
    s <- get
    put $ s { VMLoader.lbls = 
                M.insert lbl (addr s) (VMLoader.lbls s) }

align :: Int -> Int
align i = if i `mod` 16 == 0
          then i
          else align $ i + 1

incrAddr :: State LoaderState ()
incrAddr = get >>= (\s -> put $ s { VMLoader.addr =
                                      (VMLoader.addr s + 1) })

loadLine :: Line -> State LoaderState ()
loadLine Empty = return ()
loadLine (Label lbl) = addLabel lbl
loadLine (Insn insn) =
  do
    s <- get
    if (mode s) /= CODE
    then error "insn in non-code section"
    else do put $ s { VMLoader.prog =
                        M.insert (VMLoader.addr s) insn (VMLoader.prog s)}
            incrAddr

loadLine (Dir D_DATA (Just _)) = error "labeled .DATA directive"
loadLine (Dir D_DATA Nothing)  = 
  get >>= (\s -> put s { mode = DATA})

loadLine (Dir D_CODE (Just _)) = error "labeled .CODE directive"
loadLine (Dir D_CODE Nothing)  = 
  get >>= (\s -> put s { mode = CODE})

loadLine (Dir (D_ADDR _    ) (Just _)) = error "labaled .ADDR directive"
loadLine (Dir (D_ADDR addr') Nothing) = 
  get >>= (\s -> put s { VMLoader.addr = addr'})

loadLine (Dir D_FALIGN (Just _)) = error "labeled .FALIGN directive"
loadLine (Dir D_FALIGN Nothing) =
  get >>= (\s -> put s { VMLoader.addr =
                           align (VMLoader.addr s) })

loadLine (Dir (D_FILL i) mlbl) =
  do
    get >>= (\s -> put $ s { VMLoader.mem =
                               M.insert (VMLoader.addr s) i (VMLoader.mem s) })
    (case mlbl of
      Just lbl' -> addLabel lbl'
      Nothing -> return ())
    incrAddr

loadLine (Dir (D_BLKW i) mlbl) =
  do
    (case mlbl of
      Just lbl' -> addLabel lbl'
      Nothing -> return ())
    get >>= (\s -> put s {VMLoader.addr = (VMLoader.addr s) + i})

loadLine (Dir (D_CONST _) _) = error "unsupported"
loadLine (Dir (D_UCONST _) _) = error "unsupported"
