{-# LANGUAGE OverloadedStrings #-}
module ExLint
    ( lintFile
    , lintMarkdown
    , lintExample
    ) where

import ExLint.Parse
import ExLint.Example
import ExLint.Types

import Data.Text.Lazy (Text)

import qualified Data.Text.Lazy.IO  as T

lintFile :: FilePath -> IO [CheckResult]
lintFile fp = lintMarkdown =<< T.readFile fp

lintMarkdown :: Text -> IO [CheckResult]
lintMarkdown = mapM lintExample . getExamples . parseBlocks

lintExample :: Example -> IO CheckResult
lintExample ex = pluginCheck (examplePlugin ex) ex
