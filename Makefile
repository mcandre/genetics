all: hellogenetics.hs genetics.hs
	ghc --make -O2 -fforce-recomp -optl"-Wl,-no_compact_unwind" hellogenetics.hs -package base -package random-extras -package random-fu

profile: hellogenetics.hs genetics.hs clean
	ghc --make -O2 -fforce-recomp -prof -auto-all -caf-all -rtsopts hellogenetics.hs -package base -package random-extras -package random-fu
	time ./hellogenetics time ./hellogenetics +RTS -p -hc
	hp2ps -e8in -c hellogenetics.hp
	ps2pdf hellogenetics.ps hellogenetics.pdf
	open hellogenetics.pdf

clean:
	-rm hellogenetics.pdf
	-rm hellogenetics.ps
	-rm hellogenetics.aux
	-rm hellogenetics.hp
	-rm hellogenetics.prof
	-rm hellogenetics
	-rm *.o
	-rm *.hi

install: hellogenetics.hs genetics.hs
	cabal install --prefix=$$HOME --user

uninstall:
	-rm $$HOME/bin/hellogenetics