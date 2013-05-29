all: time

hellogenetics: hellogenetics.hs genetics.hs
	ghc --make -O2 -threaded -rtsopts hellogenetics.hs -package base -package random-fu -package monad-par -optl"-Wl,-no_compact_unwind" -prof -auto-all -caf-all -fhpc

time: hellogenetics
	time ./hellogenetics +RTS -N1 -p -hc

profile: clean time
	hp2ps -c hellogenetics.hp
	ps2pdf hellogenetics.ps hellogenetics.pdf
	open hellogenetics.pdf

coverage: time
	hpc report hellogenetics

clean:
	-rm -rf .hpc
	-rm *.tix
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
