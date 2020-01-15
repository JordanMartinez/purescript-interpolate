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
main = runSuite [benchFoldl]

benchFoldl :: Benchmark
benchFoldl = mkBenchmark
  { slug: "accumulator-comparison-via-foldl"
  , title: "`foldl acc "" array` where `acc` is `a <> b` or `i a b`"
  , sizes: (1..20)
  , sizeInterpretation: "Number of elements in the array"
  , inputsPerSize: 1
  , gen: \n -> vectorOf n (arbitrary :: Gen Int)
  , functions: [ benchFn "a <> b" (\array -> foldl (\a b -> show a <> show b) "" array)
               , benchFn "i a b" (\array -> foldl i "" array)
               ]
  }
