
module LC4PP where

import LC4VM

import Text.PrettyPrint.HughesPJ (Doc, (<+>),($$),(<>))
import qualified Text.PrettyPrint.HughesPJ as PP

class PP a where
  pp :: a -> Doc
  
instance PP BC where
  pp NZ = PP.text "nz"
  pp N = PP.char 'n'
  pp Z = PP.char 'z'
  pp P = PP.char 'p'
  pp ZP = PP.text "zp"
  pp NP = PP.text "np"
  pp NZP = PP.text "nzp"
  
instance PP CC where
  pp CC_N = PP.text "Condition Code: " <> PP.char 'N'
  pp CC_Z = PP.text "Condition Code: " <> PP.char 'Z'
  pp CC_P = PP.text "Condition Code: " <> PP.char 'P'
  
instance PP Line where   
  pp (Label l) = PP.text l
  pp (Insn i) = pp i
  pp (Dir d _ml) = pp d
  pp Empty = PP.text ""

instance PP Directive where
  pp D_DATA = PP.text ".DATA"
  pp D_CODE = PP.text ".CODE"
  pp (D_ADDR i) = PP.text ".ADDR 0x" <> PP.int i
  pp D_FALIGN = PP.text ".FALIGN"
  pp (D_FILL i) = PP.text ".FILL" <> PP.int i
  pp (D_BLKW i) = PP.text ".BLKW" <> PP.int i
  pp (D_CONST i) = PP.text ".CONST" <> PP.int i
  pp (D_UCONST i) = PP.text ".UCONST" <> PP.int i

instance PP Register where
  pp r = PP.text $ show r

(<*>) :: Doc -> Doc -> Doc
(<*>) d1 d2 = d1 <> PP.char ',' <+> d2

triOpPP :: String -> Register -> Register -> Register -> Doc
triOpPP s r1 r2 r3 = PP.text s <+> pp r1 <*> pp r2 <*> pp r3

triOpImmPP :: String -> Register -> Register -> Int -> Doc
triOpImmPP s r1 r2 i = PP.text s <+> pp r1 <*> pp r2 <*> PP.char '#' <> PP.int i

instance PP Instruction where
  pp NOP = PP.text "NOP"
  pp RET = PP.text "RET"
  pp RTI = PP.text "RTI"
  
  pp (BR cc lbl) = PP.text "BR" <> pp cc <+> PP.text lbl
  
  pp (ADD r1 r2 r3) = triOpPP "ADD" r1 r2 r3
  pp (MUL r1 r2 r3) = triOpPP "MUL" r1 r2 r3
  pp (SUB r1 r2 r3) = triOpPP "SUB" r1 r2 r3
  pp (DIV r1 r2 r3) = triOpPP "DIV" r1 r2 r3
  pp (AND r1 r2 r3) = triOpPP "AND" r1 r2 r3
  pp (OR r1 r2 r3) = triOpPP "OR" r1 r2 r3
  pp (XOR r1 r2 r3) = triOpPP "XOR" r1 r2 r3
  pp (MOD r1 r2 r3) = triOpPP "MOD" r1 r2 r3
  
  pp (CMP r1 r2) = PP.text "CMP" <+> pp r1 <*> pp r2
  pp (CMPU r1 r2) = PP.text "CMPU" <+> pp r1 <*> pp r2
  pp (NOT r1 r2) = PP.text "NOT" <+> pp r1 <*> pp r2
  
  pp (JSRR r) = PP.text "JSRR" <+> pp r
  pp (JMPR r) = PP.text "JMPR" <+> pp r
  
  pp (ADDI r1 r2 i) = triOpImmPP "ADD" r1 r2 i
  pp (ANDI r1 r2 i) = triOpImmPP "AND" r1 r2 i
  pp (LDR r1 r2 i) = triOpImmPP "LDR" r1 r2 i
  pp (STR r1 r2 i) = triOpImmPP "STR" r1 r2 i
  pp (SLL r1 r2 i) = triOpImmPP "SLL" r1 r2 i
  pp (SRA r1 r2 i) = triOpImmPP "SRA" r1 r2 i
  pp (SRL r1 r2 i) = triOpImmPP "SRL" r1 r2 i
  
  pp (CMPI r i) = PP.text "CMPI" <+> pp r <*> PP.int i
  pp (CMPIU r i) = PP.text "CMPIU" <+> pp r <*> PP.int i
  pp (CONST r i) = PP.text "CONST" <+> pp r <*> PP.int i
  pp (HICONST r i) = PP.text "HICONST" <+> pp r <*> PP.int i
  
  pp (TRAP i) = PP.text "TRAP 0x" <> PP.int i
  pp (LEA r l) = PP.text "LEA" <+> pp r <*> PP.text l
  pp (JSR l) = PP.text "JSR" <+> PP.text l
  pp (JMP l) = PP.text "JMP" <+> PP.text l
  
-- | Given a PP instance type, convert to string.
display :: PP a => a -> String
display = show . pp
