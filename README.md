# genetics - a Genetic Algorithm library in Haskell

# EXAMPLE

```console
$ hellogenetics
Hello World!
```

# DOCUMENTATION

http://hackage.haskell.org/package/genetics

# INSTALL (HACKAGE)

```console
$ cabal install genetics
```

# RUNTIME REQUIREMENTS

(None)

# BUILDTIME REQUIREMENTS

* [GHC Haskell](http://www.haskell.org/) 8+
* [happy](https://hackage.haskell.org/package/happy) (e.g., `cabal install happy`)

# BUILD

```console
$ cabal update
$ cabal install --force-reinstalls --only-dependencies --enable-documentation
$ cabal install --force-reinstalls --only-dependencies --enable-tests
$ shake
```

# INSTALL (LOCAL REPOSITORY)

```console
$ shake install
```

# UNINSTALL

```console
$ shake uninstall
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

# PUBLISH

```console
$ shake publish
```
