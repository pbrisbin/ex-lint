module ExLint.Types where

import Data.Monoid ((<>))
import Data.Text (Text)

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
    , examplePreamble :: Text
    , exampleExpression :: Text
    , exampleResult :: Text
    }
    deriving Show

data CheckResult
    = Match
    | MisMatch Text Text Text
    deriving Show

data Plugin = Plugin
    { pluginLanguage :: Language
    , pluginSigil :: Text
    , pluginCheck :: Example -> IO CheckResult
    }

instance Show Plugin where
    show (Plugin l _ _) = "ExLint.Plugin for " <> show l
