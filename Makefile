EXECUTABLE=helloga

all: helloga.hs genetics.hs
	ghc --make -O2 -fforce-recomp helloga.hs

clean:
	-rm $(EXECUTABLE)
	-rm *.o
	-rm *.hi