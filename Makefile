all: test

test: hellogenetics
	./hellogenetics

COMPILE=ghc --make -O2 -threaded -rtsopts hellogenetics.hs -package base -package random-fu -package monad-par

hellogenetics: hellogenetics.hs genetics.hs
	$(COMPILE) -optl"-Wl,-no_compact_unwind"

profile: hellogenetics.hs genetics.hs clean
	$(COMPILE) -prof -auto-all -caf-all
	time ./hellogenetics time ./hellogenetics +RTS -N1 -p -hc
	hp2ps -c hellogenetics.hp
	ps2pdf hellogenetics.ps hellogenetics.pdf
	open hellogenetics.pdf

clean:
	-rm *.pdf
	-rm *.ps
	-rm *.aux
	-rm *.hp
	-rm *.prof
	-rm *.exe
	-rm hellogenetics
	-rm *.o
	-rm *.hi

install: hellogenetics.hs genetics.hs
	cabal install --prefix=$$HOME --user

uninstall:
	-rm $$HOME/bin/hellogenetics
