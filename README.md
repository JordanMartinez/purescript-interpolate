# purescript-interpolate

[![Latest release](http://img.shields.io/github/release/jordanmartinez/purescript-interpolate.svg)](https://github.com/jordanmartinez/purescript-interpolate/releases)
[![Build Status](https://travis-ci.org/jordanmartinez/purescript-interpolate.svg?branch=master)](https://travis-ci.org/jordanmartinez/purescript-interpolate)

Enables string interpolation for PureScript by rendering values using their `Show` typeclass instance. Credit goes to @natefaubion for original implementation.

```purescript
i "there are " 52 "apples." == "there are 52 apples"
i 52 " apples and " 0 " oranges." == "52 apples and 0 oranges."

value :: String
value =
  let
    variableName = 42
  in
    i "There are " variableName " apples."
```

## Installation

```
bower install purescript-interpolate
```

## Documentation

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-interpolate).
