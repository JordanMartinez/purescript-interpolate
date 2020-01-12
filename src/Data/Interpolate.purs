-- | PureScript does not have language-level support for string interpolation.
-- | Instead, one uses this type classes to enable similar ergonomics.
-- |
-- | ```
-- | -- each outputs "There are 42 apples."
-- | i "There are " 42 " apples."
-- |
-- | let
-- |   variableName = 42
-- | in
-- |   i "There are " variableName " apples."
-- | ```
module Data.Interpolate where

import Data.Show (class Show, show)
import Data.Semigroup ((<>))

-- | Enables string interpolation by rendering values using their Show
-- | typeclass instance.
-- |
-- | **Note:** Use the derived function `i` rather than `Interp`'s `interp`
-- | function as the latter requires the first argument to be a `String`
-- | whereas the former does not.
-- |
-- | Example output
-- | ```
-- | i "there are " 52 "apples." == "there are 52 apples"
-- | i 52 " apples and " 0 " oranges." == "52 apples and 0 oranges."
-- | ```
class Interp a where
  -- | Use the derived function, `i`, instead of this function to do
  -- | string interpolation. Otherwise, you will get a compiler error
  -- | if the first value is not a `String`:
  -- | ```
  -- | interp "a" 42 true == "a42true"
  -- | i      "a" 42 true == "a42true"
  -- |
  -- | interp 42 "a" -- does not compile!
  -- | i      42 "a" -- compiles!
  -- | ```
  interp :: String -> a

instance interpString :: Interp String where
  interp a = a
else instance interpFunction :: Interp a => Interp (String -> a) where
  interp a b = interp (a <> b)
else instance interpShow :: (Show b, Interp a) => Interp (b -> a) where
  interp a b = interp (a <> show b)

-- | Enables string interpolation using the following syntax:
-- |
-- | ```
-- | i "there are " 52 "apples." == "there are 52 apples"
-- | i 52 " apples and " 0 " oranges." == "52 apples and 0 oranges."
-- | i true 4 42.0 'c' "string" [1] [2,3] == "true442.0'c'string[1][2,3]"
-- | ```
i :: forall a. Interp a => a
i = interp ""
