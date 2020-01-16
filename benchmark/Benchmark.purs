module Benchmark where

import Prelude
import Effect (Effect)
import Data.Array ((..))
import Data.Foldable (foldl)
import Data.Interpolate (i)
import Test.QuickCheck.Arbitrary (arbitrary)
import Test.QuickCheck.Gen (Gen, vectorOf)
import Benchotron.Core (Benchmark, benchFn, mkBenchmark)
import Benchotron.UI.Console (runSuite)

main :: Effect Unit
main = runSuite
  [ benchFoldlBoth
  ]

benchFoldlBoth :: Benchmark
benchFoldlBoth = mkBenchmark
  { slug: "foldl-compare-append-and-i"
  , title: """`foldl acc "" arrayOfInts` where `acc` is `a <> show b` or `i`"""
  , sizes: (1..5) <#> (_ * 1000)
  , sizeInterpretation: "Number of elements in the array"
  , inputsPerSize: 1
  , gen: \n -> vectorOf n (arbitrary :: Gen Int)
  , functions: [ benchFn "a <> b" (foldl (\acc next -> acc <> show next) "")
               , benchFn "i a b" (foldl i "")
               ]
  }
