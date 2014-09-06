all: test

SOURCES=HelloGenetics.hs Genetics.hs

FLAGS=-O2 -Wall -fwarn-tabs --make -fforce-recomp -threaded -rtsopts -main-is HelloGenetics HelloGenetics.hs -package base -package random-fu -package random-source

bin/hellogenetics: $(SOURCES)
	mkdir -p bin/
	ghc $(FLAGS) -o bin/hellogenetics

bin/hellogenetics-profile: $(SOURCES)
	mkdir -p bin/
	ghc $(FLAGS) -prof -auto-all -caf-all -o bin/hellogenetics-profile

bin/hellogenetics-coverage: $(SOURCES)
	mkdir -p bin/
	ghc $(FLAGS) -fhpc -o bin/hellogenetics-coverage

test: bin/hellogenetics
	bin/hellogenetics +RTS -N

hellogenetics-profile.hp: cleanprofile bin/hellogenetics-profile
	time bin/hellogenetics-profile +RTS -N1 -p -hc

profile: hellogenetics-profile.hp
	hp2ps -c hellogenetics-profile.hp
	ps2pdf hellogenetics-profile.ps hellogenetics-profile.pdf
	open hellogenetics-profile.pdf

hellogenetics-coverage.tix: bin/hellogenetics-coverage
	time bin/hellogenetics-coverage +RTS -N

coverage: hellogenetics-coverage.tix
	hpc report bin/hellogenetics-coverage

hlint:
	hlint .

lili:
	bundle exec lili .

lint: hlint lili

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
	-rm -rf bin/
	-rm *.o
	-rm *.hi
	-rm -rf dist/*

install: HelloGenetics.hs Genetics.hs
	cabal install --prefix=$$HOME --user

uninstall:
	-rm $$HOME/bin/hellogenetics
