# purescript-interpolate

[![Latest release](http://img.shields.io/github/release/jordanmartinez/purescript-interpolate.svg)](https://github.com/jordanmartinez/purescript-interpolate/releases)
[![Build Status](https://travis-ci.com/jordanmartinez/purescript-interpolate.svg?branch=master)](https://travis-ci.com/jordanmartinez/purescript-interpolate)

Enables string interpolation for PureScript for values of 5 different types: `String`, `Boolean`, `Int`, `Number`, and `Char`. Credit goes to @natefaubion for original implementation. This project is a modified version of that implementation.

```purescript
i "there are " 52 " apples." == "there are 52 apples."
i 52 " apples and " 0 " oranges." == "52 apples and 0 oranges."

value :: String
value =
  let
    variableName = 42
  in
    i "There are " variableName " apples."
```

## Installation

### Bower

```
bower install jordanmartinez/purescript-interpolate
```

### Spago

```dhall
-- Until this package is included in the latest package set,
-- add the following in the `additions` part of your `packages.dhall` file.
  interpolate =
    { dependencies = [ "prelude" ]
    , repo = "https://github.com/jordanmartinez/purescript-interpolate.git"
    , version = "v2.0.1"
    }
```

## Using this library as a dependency

See [#1](https://github.com/JordanMartinez/purescript-interpolate/issues/1) for more context, but your `bower.json` file will need to look like this:

```
  "dependencies": {
    "purescript-a": "^1.0.0",
    "purescript-b": "^2.0.0",
    "purescript-interpolate": "jordanmartinez/purescript-interpolate#^2.0.1"
}
```

## Documentation

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-interpolate).
