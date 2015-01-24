module ExLint.Plugins
    ( pluginForBlock
    , module X
    ) where

import Text.Pandoc.Definition (Block(..))

import ExLint.Plugins.Haskell as X
import ExLint.Types (Language(..), Plugin)

pluginForBlock :: Block -> Maybe Plugin
pluginForBlock = pluginForLanguage . blockLanguage

pluginForLanguage :: Language -> Maybe Plugin
pluginForLanguage Haskell = Just $ haskellPlugin
pluginForLanguage _ = Nothing

blockLanguage :: Block -> Language
blockLanguage (CodeBlock (_, ("hs":_), _) _) = Haskell
blockLanguage _ = Unknown
