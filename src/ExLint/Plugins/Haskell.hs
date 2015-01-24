{-# LANGUAGE OverloadedStrings #-}
module ExLint.Plugins.Haskell
    ( haskellPlugin
    ) where

import ExLint.Types (Example(..), Language(..), Plugin(..))

haskellPlugin :: Plugin
haskellPlugin = Plugin
    { pluginLanguage = Haskell
    , pluginSigil = "-- =>"
    , pluginCheck = \_ -> return True
    }
