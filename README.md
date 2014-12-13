# genetics - A Genetic Algorithm library in Haskell

# EXAMPLE

```
$ cabal update
$ cabal install -p random-fu
$ make
./hellogenetics +RTS -N
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
* [Guard](http://guardgem.org/) 1.8.2+

Use `bundle` to install Guard.

# DEVELOPMENT

## Guard

Start Guard in a shell, and it will automatically run unit tests when the source code changes:

```
$ guard
...
```

## Lint

Keep the code tidy with HLint:

```
$ cabal install hlint
$ make lint
```

# Profiling

```
$ make profile
```

If profiling shows an error message, resolve by reinstalling the dependency libraries with `cabal install -p <library>`, as [lambdor](http://lambdor.net/?p=258) recommends.

# Coverage

```
$ make coverage
```
