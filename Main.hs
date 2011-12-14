-- | LC4sim's REPL
-- Main is here
-- 

module Main where

import System.Exit (exitSuccess, exitFailure)
import System.IO
import System (getArgs)
import Data.Char
import Control.Monad.State

import LC4Parser
import LC4VM
import ParserCombinators
import VMLoader

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
  \p | print [arg] -- Print the system state. Optional arg will print \
  \ that specific element.\n \
  \h | help -- Print this message.\n"

success :: Either ParseError Line -> Bool
success (Left _) = False
success (Right _) = True

-- | Prints the argument to screen
print :: String -> IO ()
print s = undefined 

-- | Processes a command from main and calls the appropriate 
--   functions to deal with them.
processCmd :: [String] -> IO ()
processCmd cmd
  | cmd!!0 `elem` ["quit", "q"] = exitSuccess
  | cmd!!0 `elem` ["help", "h"] = putStrLn helpText
  | cmd!!0 `elem` ["n", "next"] = putStrLn "This will step next"
  | cmd!!0 `elem` ["p", "print"] = putStrLn "This will print somethin."
  | otherwise = putStrLn "Command not recognized. Type help or h for help."

repl :: VMState -> IO ()
repl s = 
  do 
    putStr prompt
    hFlush stdout
    cmd <- getLine
    let cmds = words cmd
    if length cmds < 1 then 
      repl s
      else 
      processCmd (map (\s -> map toLower s) cmds)
    putStrLn $ "You typed " ++ cmd ++ ". "
    repl s
      
    
mainHelp :: String
mainHelp = "LC4 Interpreter. Usage: lc4sim <filename.asm>"

parseLinesFromFile :: String -> IO ([Either ParseError Line])
parseLinesFromFile filename = do
  handle <- openFile filename ReadMode
  contents <- hGetContents handle
  -- putStrLn $ show $ lines contents
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

-- | Program entry.
main :: IO ()
main = do 
  args <- getArgs
  let l = length args
  if (l > 1 || l < 1) then
    putStrLn "Incorrect number of arguments, type --help for help."
    else 
    do 
      let arg = head args
      prelines <- parseLinesFromFile arg
      lines <- checkParsedLines prelines
      -- putStrLn $ show lines
      repl $ load lines

