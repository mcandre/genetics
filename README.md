# genetics - A Genetic Algorithm library in Haskell

# REQUIREMENTS

 - [Haskell](http://www.haskell.org/)
 - [random-fu](http://hackage.haskell.org/package/random-fu)

## OPTIONAL

* [Ruby](https://www.ruby-lang.org/) 1.9+
* [Guard](http://guardgem.org/) 1.8.2+

Use `bundle` to install Guard.

# DEVELOPMENT

## Guard

Start Guard in a shell, and it will automatically run unit tests when the source code changes:

    $ guard
        ...

## Lint

Keep the code tidy with HLint:

    $ cabal install hlint
    $ make lint

# EXAMPLE

    $ cabal update
    $ cabal install random-fu
    $ make
    ./hellogenetics +RTS -N
    Hello World!

To perform profiling, run `make profile`.

To perform coverage, run `make coverage`.
