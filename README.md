# genetics - a Genetic Algorithm library in Haskell

# EXAMPLE

```console
$ hellogenetics
Hello World!
```

# DOCUMENTATION

http://hackage.haskell.org/package/genetics

# RUNTIME REQUIREMENTS

(None)

# BUILDTIME REQUIREMENTS

* [Haskell](http://www.haskell.org/)

## Recommended

* [shake](https://shakebuild.com/) (e.g., `cabal install shake`)
* [hlint](https://hackage.haskell.org/package/hlint) (e.g., `cabal install happy; cabal install hlint`)

# BUILD

```console
$ cabal install --only-dependencies --enable-tests
$ shake
```

# LINT

Keep the code tidy:

```console
$ shake lint
```

# TEST

```console
$ shake test
```
