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

Install random-fu with `cabal install -p random-fu`.

Recommend configuring cabal to default to profiled libraries:

https://github.com/mcandre/dotfiles/blob/master/.cabal/config#L24

## OPTIONAL

* [Ruby](https://www.ruby-lang.org/) 1.9+

# DEVELOPMENT

## Lint

Keep the code tidy:

```
$ cabal install hlint
$ hlint .
$ bundle install
$ lili .
```
