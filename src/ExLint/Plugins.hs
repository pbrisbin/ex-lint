{-# LANGUAGE OverloadedStrings #-}
module ExLint.Plugins
    ( pluginForBlock
    ) where

import ExLint.Plugins.Haskell
import ExLint.Types

pluginForBlock :: Block a -> Maybe Plugin
pluginForBlock = pluginForLanguage . blockLanguage

pluginForLanguage :: Language -> Maybe Plugin
pluginForLanguage Haskell = Just $ haskellPlugin
pluginForLanguage _ = Nothing

blockLanguage :: Block a -> Language
blockLanguage (BlockCode (Just "hs") _) = Haskell
blockLanguage _ = Unknown
