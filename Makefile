EXECUTABLE=helloga

all: helloga.hs genetics.hs
	ghc --make -O2 -fforce-recomp helloga.hs -package random-extras

profile: helloga.hs genetics.hs clean
	ghc --make -O2 -fforce-recomp -prof -auto-all -caf-all -rtsopts helloga.hs -package random-extras
	time ./helloga time ./helloga +RTS -p -hc
	hp2ps -e8in -c helloga.hp
	ps2pdf helloga.ps helloga.pdf
	open helloga.pdf

clean:
	-rm helloga.pdf
	-rm helloga.ps
	-rm helloga.aux
	-rm helloga.hp
	-rm helloga.prof
	-rm $(EXECUTABLE)
	-rm *.o
	-rm *.hi