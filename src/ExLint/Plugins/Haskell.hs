{-# LANGUAGE OverloadedStrings #-}
module ExLint.Plugins.Haskell
    ( haskellPlugin
    ) where

import ExLint.Types

import Data.Text (Text)
import System.Process (readProcess)

import qualified Data.Text as T
import qualified Data.Text.IO as T

haskellPlugin :: Plugin
haskellPlugin = Plugin
    { pluginLanguage = Haskell
    , pluginSigil = "-- =>"
    , pluginCheck = haskellCheck
    }

haskellCheck :: Example -> IO CheckResult
haskellCheck ex = do
    let fn = "/tmp/ex-lint.hs"

    T.writeFile fn $ examplePreamble ex

    --fmap (== expected) $ readProcessText "ghci" [fn] input
    actual <- fmap T.strip $ readProcessText "ghci" ["-v0", fn] input

    return $ if actual == expected
        then Match
        else MisMatch input expected actual

  where
    input = exampleExpression ex
    expected = exampleResult ex

readProcessText :: FilePath -> [String] -> Text -> IO Text
readProcessText x y z = fmap T.pack $ readProcess x y (T.unpack z)
