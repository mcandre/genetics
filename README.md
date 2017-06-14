# genetics - a Genetic Algorithm library in Haskell

# EXAMPLE

```
$ cabal update
$ cabal install
$ cabal build
$ ./hellogenetics +RTS -N
Hello World!
```

See [HelloGenetics.hs](https://github.com/mcandre/genetics/blob/master/HelloGenetics.hs) for more information.

# HACKAGE

http://hackage.haskell.org/package/genetics

# REQUIREMENTS

* [Haskell](http://www.haskell.org/)
* [random-fu](http://hackage.haskell.org/package/random-fu)

## OPTIONAL

* [ruby](https://www.ruby-lang.org/) 2.3+
* [coreutils](https://www.gnu.org/software/coreutils/coreutils.html)
* [editorconfig-cli](https://github.com/amyboyd/editorconfig-cli) (e.g. `go get github.com/amyboyd/editorconfig-cli`)
* [flcl](https://github.com/mcandre/flcl) (e.g. `go get github.com/mcandre/flcl/...`)

# DEVELOPMENT

## Lint

Keep the code tidy:

```
$ cabal install hlint
$ hlint .
$ bundle install
$ lili .
```
