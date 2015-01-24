module ExLint.Types where

import Data.Monoid ((<>))

data Language
    = Haskell
    | Unknown
    deriving Show

-- | Example pulled from a code block
--
-- Current limitations:
--
-- 1. One example per block
-- 3. One line result
-- 2. One line example directly before result
--
data Example = Example
    { examplePlugin :: Plugin
    , examplePreamble :: String
    , exampleExpression :: String
    , exampleResult :: String
    }
    deriving Show

data Plugin = Plugin
    { pluginLanguage :: Language
    , pluginSigil :: String
    , pluginCheck :: Example -> IO () -- TODO
    }

instance Show Plugin where
    show (Plugin l _ _) = "ExLint.Plugin for " <> show l
