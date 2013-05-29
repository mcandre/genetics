all: test

SOURCES = hellogenetics.hs genetics.hs

COMPILE = ghc --make -O2 -threaded -rtsopts hellogenetics.hs -package base -package random-fu

hellogenetics: $(SOURCES)
	$(COMPILE)

hellogenetics-profile: $(SOURCES)
	$(COMPILE) -prof -auto-all -caf-all -o hellogenetics-profile

hellogenetics-coverage: $(SOURCES)
	$(COMPILE) -fhpc -o hellogenetics-coverage

test: hellogenetics
	./hellogenetics +RTS -N

time: hellogenetics-profile
	time ./hellogenetics-profile +RTS -N1 -p -hc

profile: clean time
	hp2ps -c hellogenetics-profile.hp
	ps2pdf hellogenetics-profile.ps hellogenetics-profile.pdf
	open hellogenetics-profile.pdf

coverage: hellogenetics-coverage
	./hellogenetics-coverage +RTS -N
	hpc report hellogenetics-coverage

clean:
	-rm -rf .hpc
	-rm *.tix
	-rm *.hp
	-rm *.prof
	-rm *.pdf
	-rm *.ps
	-rm *.aux
	-rm *.exe
	-rm hellogenetics
	-rm *-profile
	-rm *-coverage
	-rm *.o
	-rm *.hi

install: hellogenetics.hs genetics.hs
	cabal install --prefix=$$HOME --user

uninstall:
	-rm $$HOME/bin/hellogenetics
