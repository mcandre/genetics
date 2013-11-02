all: test

SOURCES = hellogenetics.hs genetics.hs

COMPILE = ghc --make -O2 -threaded -rtsopts hellogenetics.hs -package base -package random-fu -package random-source -Wall

hellogenetics: $(SOURCES)
	$(COMPILE)

hellogenetics-profile: $(SOURCES)
	$(COMPILE) -prof -auto-all -caf-all -o hellogenetics-profile

hellogenetics-coverage: $(SOURCES)
	$(COMPILE) -fhpc -o hellogenetics-coverage

test: hellogenetics
	./hellogenetics +RTS -N

hellogenetics-profile.hp: cleanprofile hellogenetics-profile
	time ./hellogenetics-profile +RTS -N1 -p -hc

profile: hellogenetics-profile.hp
	hp2ps -c hellogenetics-profile.hp
	ps2pdf hellogenetics-profile.ps hellogenetics-profile.pdf
	open hellogenetics-profile.pdf

hellogenetics-coverage.tix: hellogenetics-coverage
	time ./hellogenetics-coverage +RTS -N

coverage: hellogenetics-coverage.tix
	hpc report hellogenetics-coverage

lint:
	hlint .

package:
	cabal configure
	cabal sdist

publish: package
	cabal upload dist/genetics-*.tar.gz

cleanprofile:
	-rm *.hp
	-rm *.prof
	-rm *.pdf
	-rm *.ps
	-rm *.aux
	-rm *-profile

clean: cleanprofile
	-rm -rf .hpc
	-rm *.tix
	-rm *.exe
	-rm hellogenetics
	-rm *-coverage
	-rm *.o
	-rm *.hi
	-rm -rf dist/*

install: hellogenetics.hs genetics.hs
	cabal install --prefix=$$HOME --user

uninstall:
	-rm $$HOME/bin/hellogenetics
