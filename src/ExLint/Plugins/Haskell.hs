{-# LANGUAGE OverloadedStrings #-}
module ExLint.Plugins.Haskell
    ( haskellPlugin
    ) where

import ExLint.Types

import Control.Monad (unless)
import Data.Digest.Pure.MD5 (md5)
import Data.Text (Text)
import Data.Monoid ((<>))
import System.Directory (doesFileExist)
import System.Process (readProcess)

import qualified Data.ByteString.Lazy.Char8 as C8
import qualified Data.Text as T
import qualified Data.Text.IO as T

haskellPlugin :: Plugin
haskellPlugin = Plugin
    { pluginLanguage = Haskell
    , pluginSigil = "-- =>"
    , pluginCheck = haskellCheck
    }

haskellCheck :: Example -> IO CheckResult
haskellCheck (Example _ preamble input expected) = do
    let fn = "/tmp/ex-lint-" <> md5sum preamble <> ".hs"

    e <- doesFileExist fn
    unless e $ T.writeFile fn preamble

    actual <- fmap T.strip $ readProcessText "ghci" ["-v0", fn] input

    return $ if actual == expected
        then Match
        else MisMatch input expected actual

md5sum :: Text -> String
md5sum = show . md5 . C8.pack . T.unpack

readProcessText :: FilePath -> [String] -> Text -> IO Text
readProcessText x y z = fmap T.pack $ readProcess x y (T.unpack z)
