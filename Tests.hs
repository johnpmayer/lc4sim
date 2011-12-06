import Test.HUnit
import LC4Parser
import Parser
import ParserCombinators

runTests :: IO Counts
runTests = runTestTT allTests

allTests :: Test
allTests = TestList [tInsnCorrect,
                     tCommentCorrect,
                     tDirectiveCorrect]

check x = succeed (parse insnP x)
succeed (Left _) = assert False
succeed (Right _) = assert True

-- | Tests insnP's parse correct things.
tInsnCorrect :: Test
tInsnCorrect = TestList ["i1" ~: check "NOP",
                "i2" ~: check "BRn label",
                "i3" ~: check "BRnz label",
                "i4" ~: check "BRp label",
                "i5" ~: check "BRnzp label",
                "i6" ~: check "ADD R5, R3, R5",
                "i7" ~: check "ADD R1, R0, #12",
                "i8" ~: check "CMP R0, R7",
                "i9" ~: check "CMPI R1, #4570",
                "i10" ~: check "JSR label_label",
                "i11" ~: check "JSRR R4",
                "i12" ~: check "AND R0, R4, R3",
                "i13" ~: check "XOR R7, R6, R5",
                "i14" ~: check "AND R2, R4, #34",
                "i15" ~: check "LDR R4, R1, #11",
                "i16" ~: check "RTI",
                "i17" ~: check "CONST R4, #33",
                "i18" ~: check "JMP label_",
                "i19" ~: check "HICONST R4, #66"
               ]
  
tCommentCorrect :: Test
tCommentCorrect = TestList ["c1" ~: check ";;this is a comment",
                            "c2" ~: check "; also a 4739 comment"
                            ]
                  
tDirectiveCorrect :: Test
tDirectiveCorrect = TestList ["d1" ~: check ".DATA",
                              "d2" ~: check ".ADDR x0473",
                              "d3" ~: check ".BLKW #44",
                              "d4" ~: check ".FILL #-1"
                              ]

