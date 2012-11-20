-- This content is released under the (Link Goes Here) MIT License.

{-# LANGUAGE GADTs #-}

module Immediate where

data I5 = I5
data I6
data I7
data I9
data I16
data U4
data U7
data U8
data U16

data Imm n where
  IMM5   :: Int -> Imm I5
  IMM6   :: Int -> Imm I6
  IMM7   :: Int -> Imm I7
  IMM9   :: Int -> Imm I9
  IMM16  :: Int -> Imm I16
  UIMM4  :: Int -> Imm U4
  UIMM7  :: Int -> Imm U7
  UIMM8  :: Int -> Imm U8
  UIMM16 :: Int -> Imm U16

instance Eq (Imm n) where
  (IMM5 n1) == (IMM5 n2) = n1 == n2
  (IMM6 n1) == (IMM6 n2) = n1 == n2
  (IMM7 n1) == (IMM7 n2) = n1 == n2
  (IMM9 n1) == (IMM9 n2) = n1 == n2
  (IMM16 n1) == (IMM16 n2) = n1 == n2
  (UIMM4 n1) == (UIMM4 n2) = n1 == n2
  (UIMM7 n1) == (UIMM7 n2) = n1 == n2
  (UIMM8 n1) == (UIMM8 n2) = n1 == n2
  (UIMM16 n1) == (UIMM16 n2) = n1 == n2

instance Ord (Imm n) where
  (IMM16 n1) `compare` (IMM16 n2) = n1 `compare` n2

