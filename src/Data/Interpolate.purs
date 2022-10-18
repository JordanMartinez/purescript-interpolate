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
-- |
-- | **Note:** string interpolation only works for the following types:
-- | - String
-- | - Boolean
-- | - Int
-- | - Number
-- | - Char
-- |
-- | This restriction is intentional for two reasons:
-- | 1. It avoids "instance wars" since orphan instances are not allowed in PureScript.
-- | 2. It avoids unexpected `String` outputs when dealing with newtypes.
module Data.Interpolate (class Interp, interp, i) where

import Data.Semigroup ((<>))
import Data.Show (show)
import Partial.Unsafe (unsafeCrashWith)
import Prim.TypeError (class Fail, Text)

-- | Enables string interpolation on values for only the following types:
-- | `String`, `Boolean`, `Int`, `Number`, and `Char`. Values for all other
-- | types will need to be converted into one of the above types first.
-- |
-- | **Note:** Use the derived function `i` rather than `Interp`'s `interp`
-- | function as the latter requires the first argument to be a `String`
-- | whereas the former does not.
-- |
-- | Example output
-- | ```
-- | i "there are " 52 "apples." == "there are 52 apples"
-- | i 52 " apples and " 0 " oranges." == "52 apples and 0 oranges."
-- |
-- | -- `Maybe Int` must be converted into an `Int` before interpolation works.
-- | let example1 maybeInt = i (fromMaybe 0 maybeInt) " apples."
-- | example1 Nothing == "0 apples."
-- | example1 (Just 4) == "4 apples."
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
else instance interpStringFunction :: Interp a => Interp (String -> a) where
  interp a b = interp (a <> b)
else instance interpBooleanFunction :: Interp a => Interp (Boolean -> a) where
  interp a b = interp (a <> show b)
else instance interpIntFunction :: Interp a => Interp (Int -> a) where
  interp a b = interp (a <> show b)
else instance interpNumberFunction :: Interp a => Interp (Number -> a) where
  interp a b = interp (a <> show b)
else instance interpCharFunction :: Interp a => Interp (Char -> a) where
  interp a b = interp (a <> show b)
-- | String interpolation only works for the following types:
-- | - String
-- | - Boolean
-- | - Int
-- | - Number
-- | - Char
-- |
-- | This restriction is intentional for two reasons:
-- | 1. It avoids "instance wars" since orphan instances are not allowed in PureScript.
-- | 2. It avoids unexpected `String` outputs when dealing with newtypes.
else instance interpFailEverythingElse :: Fail (
  Text "String interpolation only works on the following primitive values: \
       \`String`, `Boolean`, `Int`, `Number`, and `Char`. Moreover, using \
       \newtypes to get around this will fail. These restrictions are \
       \intentional. Please use a function to render your type's value into \
       \a value of one of these types before it gets passed as an argument \
       \into the `i` function."
  ) => Interp anythingElse where
  interp _ = unsafeCrashWith "A compiler error will prevent this from running."

-- | Enables string interpolation using the following syntax:
-- |
-- | ```
-- | i "there are " 52 " apples." == "there are 52 apples"
-- | i 52 " apples and " 0 " oranges." == "52 apples and 0 oranges."
-- | i true 4 42.0 'c' "string" == "true442.0'c'string"
-- | ```
i :: forall a. Interp a => a
i = interp ""
