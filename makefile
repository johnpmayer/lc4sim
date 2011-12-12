all: Main

SRC=Parser.hs 
SRC+=ParserCombinators.hs
SRC+=Tests.hs
SRC+=immediate.hs
SRC+=lc4PP.hs
SRC+=lc4draw.hs
SRC+=lc4parser.hs
SRC+=lc4vm.hs
SRC+=simulator.hs
SRC+=vmLoader.hs
SRC+=Main.hs

Main: $(SRC)
	ghc --make Main.hs

clean : 
	rm -f *.o *.hi Main