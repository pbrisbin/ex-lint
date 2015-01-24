module ExLint.Types
    ( Block(..)
    , Language(..)
    , Example(..)
    , CheckResult(..)
    , Plugin(..)
    ) where

import Data.Monoid ((<>))
import Data.Text (Text)
import Text.Markdown.Block (Block(..))

data Language
    = Haskell
    | Unknown
    deriving Show

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
