module ExLint.Plugins.Haskell where

import ExLint.Types

haskellPlugin :: Plugin
haskellPlugin = Plugin
    { pluginLanguage = Haskell
    , pluginSigil = "-- =>"
    , pluginCheck = \_ -> return ()
    }
