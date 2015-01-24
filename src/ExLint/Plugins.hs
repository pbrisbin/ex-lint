{-# LANGUAGE OverloadedStrings #-}
module ExLint.Plugins
    ( pluginForBlock
    , module X
    ) where

import ExLint.Parse (Block(..))
import ExLint.Plugins.Haskell as X
import ExLint.Types (Language(..), Plugin)

pluginForBlock :: Block a -> Maybe Plugin
pluginForBlock = pluginForLanguage . blockLanguage

pluginForLanguage :: Language -> Maybe Plugin
pluginForLanguage Haskell = Just $ haskellPlugin
pluginForLanguage _ = Nothing

blockLanguage :: Block a -> Language
blockLanguage (BlockCode (Just "hs") _) = Haskell
blockLanguage _ = Unknown
