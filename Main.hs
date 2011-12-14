-- | LC4sim's REPL
-- Main is here
-- 

module Main where

import System.Exit (exitSuccess, exitFailure)
import System.IO
import System (getArgs)
import Data.Char
import qualified Data.Map as M
import Data.Maybe
import Control.Monad.State

import LC4Parser
import LC4VM
import ParserCombinators
import VMLoader
import Simulator

-- | The welcome message. This is printed when the interpreter is started
--   without any command-line arguments. 
welcomeMsg :: String
welcomeMsg = 
  "Welcome to the LC4 Simulator. This is a general purpose \
   \interpreter for the LC4 assembly language. Type h or help for help.\n"

-- | The prompt displayed. 
prompt :: String
prompt = "lc4sim> "

-- | The help text that is displayed for help.
helpText :: String
helpText = 
  "This is a list of commands available to you. Some commands expect \
  \an argument. \n \
  \\n \
  \q | quit -- Leave the interpreter.\n \
  \n | next -- Step to the next instruction.\n \
  \r | reg  -- Show the register file.\n \
  \h | help -- Print this message.\n"

-- | Processes a command from main and calls the appropriate 
--   functions to deal with them.
processCmd :: VMState -> String -> IO VMState
processCmd s cmd
  | cmd `elem` ["quit", "q"] = exitSuccess
  | cmd `elem` ["help", "h"] = putStrLn helpText >> return s
  | cmd `elem` ["n", "next"] = nextInstruction s
  | cmd `elem` ["r", "reg", "registers"] = showRegisters s >> return s
  | cmd `elem` ["p", "prog"] = showProgram s >> return s
  | cmd `elem` ["m", "mem", "memory"] = showMemory s >> return s
  | cmd `elem` ["l", "lbl", "lables"] = showLabels s >> return s
  | otherwise = 
      putStrLn "Command not recognized. Type help or h for help." >> 
        return s

showLabels :: VMState -> IO ()
showLabels s =
  do
    putStrLn "Labels"
    putStrLn . show . LC4VM.lbls $ s

showMemory :: VMState -> IO ()
showMemory s =
  do
    putStrLn "Memory"
    putStrLn . show . memory $ s

showProgram :: VMState -> IO ()
showProgram s =
  do
    putStrLn "Program Counter"
    putStrLn . show . pc $ s
    putStrLn (case M.lookup (pc s) (LC4VM.prog s) of
      Nothing -> "No valid insn"
      Just insn -> show insn)

showRegisters :: VMState -> IO ()
showRegisters s = 
  do
    putStrLn "Regfile"
    let registers = regFile s
    putStrLn $ show registers

nextInstruction :: VMState -> IO VMState
nextInstruction s = return $ execState nextStep s

repl :: VMState -> IO ()
repl s = 
  do 
    putStr prompt
    hFlush stdout
    cmd <- getLine
    putStrLn $ "You typed " ++ cmd ++ ". "
    s' <- processCmd s (map toLower cmd)
    repl s'
    
mainHelp :: String
mainHelp = "LC4 Interpreter. Usage: lc4sim <filename.asm>"

parseLinesFromFile :: String -> IO ([Either ParseError Line])
parseLinesFromFile filename = do
  handle <- openFile filename ReadMode
  contents <- hGetContents handle
  --putStrLn $ show $ lines contents
  return $ fmap (\lineS -> parse lineP lineS) (lines contents)

checkParsedLines :: ([Either ParseError Line]) -> IO [Line]
checkParsedLines [] = return []
checkParsedLines (Left err : _ls) = 
  do
    putStrLn $ "Parser failed:\n\t" ++ err
    exitFailure
checkParsedLines (Right l : ls) = 
  do
    ls <- checkParsedLines ls
    return $ l : ls

run :: String -> IO ()
run filename = 
  do
    prelines <- parseLinesFromFile filename
    lines <- checkParsedLines prelines
    putStrLn . unlines $ fmap show lines
    putStrLn welcomeMsg
    repl $ load lines

-- | The main REPL loop.
main :: IO ()
main = do 
  args <- getArgs
  let l = length args
  if (l > 1 || l < 1) then
    putStrLn "Incorrect number of arguments, type --help for help."
    else 
    do 
      let filename = head args
      run filename

test :: IO ()
test = run "fib.asm"