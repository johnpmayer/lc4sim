import Test.HUnit
import LC4Parser
import Parser
import ParserCombinators

runTests :: IO Counts
runTests = runTestTT allTests

allTests :: Test
allTests = TestList [tInsnCorrect,
                     tCommentCorrect,
                     tIntCorrect,
                     tDirectiveCorrect,
                     tMisc
                    ]
           
checkInsn x = succeed (parse insnP x)
checkCmmt x = succeed (parse commentP x)
checkDir x = succeed (parse directiveP x)
succeed (Left _) = assert False
succeed (Right _) = assert True

testMy :: Parser a -> String -> IO ()
testMy p x = succeed (parse p x)

-- | Tests insnP's parse correct things.
tInsnCorrect :: Test
tInsnCorrect = TestList ["i1" ~: checkInsn "NOP",
                "i2" ~: checkInsn "BRn label",
                "i3" ~: checkInsn "BRnz label",
                "i4" ~: checkInsn "BRp label",
                "i5" ~: checkInsn "BRnzp label",
                "i6" ~: checkInsn "ADD R5, R3, R5",
                "i7" ~: checkInsn "ADD R1, R0, #12",
                "i8" ~: checkInsn "CMP R0, R7",
                "i9" ~: checkInsn "CMPI R1, #4570",
                "i10" ~: checkInsn "JSR label_label",
                "i11" ~: checkInsn "JSRR R4",
                "i12" ~: checkInsn "AND R0, R4, R3",
                "i13" ~: checkInsn "XOR R7, R6, R5",
                "i14" ~: checkInsn "AND R2, R4, #34",
                "i15" ~: checkInsn "LDR R4, R1, #11",
                "i16" ~: checkInsn "RTI",
                "i17" ~: checkInsn "CONST R4, #33",
                "i18" ~: checkInsn "JMP label_",
                "i19" ~: checkInsn "HICONST R4, #66",
                "i20" ~: checkInsn "LEA R0, global_array"
               ]
  
tCommentCorrect :: Test
tCommentCorrect = TestList ["c1" ~: checkCmmt ";;this is a comment",
                            "c2" ~: checkCmmt "; also a 4739 comment",
                            "c3" ~: checkCmmt ";;;;;",
                            "c4" ~: checkCmmt ";;;;;bola jdkle dkaljd;deifjkd"
                            ]
                  
tIntCorrect :: Test
tIntCorrect = TestList ["z1" ~: succeed $ parse intP "0x2432",
                        "z2" ~: succeed $ parse intP "#19", 
                        "z3" ~: succeed $ parse intP "#-23",
                        "z4" ~: succeed $ parse intP "x4324"
                       ]

tDirectiveCorrect :: Test
tDirectiveCorrect = TestList ["d1" ~: checkDir ".DATA",
                              "d2" ~: checkDir ".ADDR 0x0473",
                              "d3" ~: checkDir ".BLKW #44",
                              "d4" ~: checkDir ".FILL #-1",
                              "d5" ~: succeed $ parse unLblDirectiveP ".FILL 0x458",
                              "d6" ~: succeed $ parse lblDirectiveP "LABEL_DIRECTIVE .FILL #-1"
                              ]

tMisc :: Test
tMisc = TestList ["e1" ~: testMy lineP "",
                  "e2" ~: testMy lineP "    ",
                  "e3" ~: testMy lineP ".DATA",
                  "e4" ~: testMy lineP ".ADDR x2000",
                  "e5" ~: testMy lineP "    .ADDR 0x4573",
                  "e6" ~: testMy lineP "    BRnzp label_blah ;;comment here"]