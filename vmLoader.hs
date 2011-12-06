
module VMLoader where

import Control.Monad.State
import qualified Data.Map as M
import qualified Data.Set as S

import LC4VM

data LoaderState = L { addr :: Int,
                       prog :: Program,
                       lbls :: Labels,
                       brks :: Breakpoints,
                       mem :: Memory }

initial :: LoaderState
initial = L 0 M.empty M.empty S.empty M.empty

load :: [Line] -> VMState
load ls = convert $ execState (loadAll ls) initial where

  convert :: LoaderState -> VMState
  convert (L _a p lbls' brks' mem') = 
    VM p lbls' M.empty mem' brks' 0 CC_Z False

  loadAll :: [Line] -> State LoaderState ()
  loadAll = foldl (\soFar line -> soFar >> (loadLine line)) (return ())

loadLine :: Line -> State LoaderState ()
loadLine = undefined