-- | LC4sim's REPL
-- Main is here
-- 

module Main where

import System.Exit (exitSuccess)
import System.IO
import System (getArgs)
import Data.Char
import Control.Monad.State

import LC4Parser
import ParserCombinators

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
  \l | load <filename> -- load the asm file into the interpreter.\n \
  \q | quit -- Leave the interpreter.\n \
  \n | next -- Step to the next instruction.\n \
  \p | print [arg] -- Print the system state. Optional arg will print \
  \ that specific element.\n \
  \h | help -- Print this message.\n"

-- | Processes a .asm file into a list of lines.
-- Argument is filename
readAsmFile :: String -> IO ()
readAsmFile fn = 
  do 
    y <- parseFromFile lineP fn
    case y of 
      Left _ -> putStrLn "Error parsing file"
      Right lines -> putStrLn "Parsed file successfully"

-- | Processes a command from main and calls the appropriate 
--   functions to deal with them.
processCmd :: String -> IO ()
processCmd cmd
  | cmd `elem` ["quit", "q"] = exitSuccess
  | cmd `elem` ["help", "h"] = putStrLn helpText
  | cmd `elem` ["n", "next"] = putStrLn "This will step next"
  | cmd `elem` ["l", "load"] = putStrLn "This will load the file" 
  | otherwise = putStrLn "Command not recognized. Type help or h for help."

repl :: IO ()
repl = 
  do 
    putStr prompt
    hFlush stdout
    cmd <- getLine
    processCmd (map toLower cmd)
    putStrLn $ "You typed " ++ cmd ++ ". "
    main
    
mainHelp :: String
mainHelp = "LC4 Interpreter. Usage: lc4sim <filename.asm>"

-- | The main REPL loop.
main :: IO ()
main = do 
  args <- getArgs
  let l = length args
  if (l > 1 || l < 1) then
    putStr "Incorrect number of arguments, type --help for help."
    else 
    do 
      let arg = head args
      
    