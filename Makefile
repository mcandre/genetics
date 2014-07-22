all: test

SOURCES=HelloGenetics.hs Genetics.hs

FLAGS=-O2 -Wall -fwarn-tabs --make -fforce-recomp -threaded -rtsopts -main-is HelloGenetics HelloGenetics.hs -package base -package random-fu -package random-source

hellogenetics: $(SOURCES)
	ghc $(FLAGS) -o hellogenetics

hellogenetics-profile: $(SOURCES)
	ghc $(FLAGS) -prof -auto-all -caf-all -o hellogenetics-profile

hellogenetics-coverage: $(SOURCES)
	ghc $(FLAGS) -fhpc -o hellogenetics-coverage

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

churn:
	bundle exec churn

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

install: HelloGenetics.hs Genetics.hs
	cabal install --prefix=$$HOME --user

uninstall:
	-rm $$HOME/bin/hellogenetics
