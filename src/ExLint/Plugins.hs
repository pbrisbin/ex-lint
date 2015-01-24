{-# LANGUAGE OverloadedStrings #-}
module ExLint.Plugins
    ( pluginForBlock
    ) where

import ExLint.Plugins.Haskell
import ExLint.Types

pluginForBlock :: Block a -> Maybe Plugin
pluginForBlock (BlockCode (Just "hs") _) = Just haskellPlugin
pluginForBlock (BlockCode (Just "haskell") _) = Just haskellPlugin
pluginForBlock _ = Nothing
