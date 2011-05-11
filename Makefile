EXECUTABLE=helloga

all: helloga.hs genetics.hs
	ghc --make -O2 -fforce-recomp helloga.hs

profile: helloga.hs genetics.hs
	ghc --make -O2 -fforce-recomp -prof -auto-all -caf-all -rtsopts helloga.hs
	time ./helloga time ./helloga +RTS -p -hc
	hp2ps -e8in -c helloga.hp
	open helloga.ps

clean:
	-rm helloga.ps
	-rm helloga.aux
	-rm helloga.hp
	-rm helloga.prof
	-rm $(EXECUTABLE)
	-rm *.o
	-rm *.hi