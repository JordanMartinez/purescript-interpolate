module Test.Main where

import Prelude

import Data.Interpolate (i)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "Interpolation works" do
    it "Interpolating ints works" do
      i 1 2 3 `shouldEqual` "123"
    it "Interpolating numbers works" do
      i 1.0 2.0 `shouldEqual` "1.02.0"
    it "Interpolating booleans works" do
      i true false `shouldEqual` "truefalse"
    it "Interpolating characters works" do
      i 'a' 'b' 'c' `shouldEqual` "'a''b''c'"
    it "Interpolating strings works" do
      i "a" "b" "c" `shouldEqual` "abc"
    it "Interpolating values with different types works" do
      i 0 1.0 true 'a' "a" `shouldEqual` "01.0true'a'a"

    -- Intentional: this will fail to compile
    -- it "Interpolating values from unaccepted types will produce a compiler error" do
    --   i [1, 2, 3] `shouldEqual` "[1, 2, 3]"
