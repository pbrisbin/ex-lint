{-# LANGUAGE OverloadedStrings #-}
module ExLint
    ( lintFile
    , lintMarkdown
    , lintExample
    , printResults
    ) where

import ExLint.Parse
import ExLint.Example
import ExLint.Types

import Data.Monoid ((<>))
import Data.Text.Lazy (Text)

import qualified Data.Text.IO  as T
import qualified Data.Text.Lazy.IO  as TL

lintFile :: FilePath -> IO [CheckResult]
lintFile fp = lintMarkdown =<< TL.readFile fp

lintMarkdown :: Text -> IO [CheckResult]
lintMarkdown = mapM lintExample . getExamples . parseBlocks

lintExample :: Example -> IO CheckResult
lintExample ex = pluginCheck (examplePlugin ex) ex

printResults :: [CheckResult] -> IO ()
printResults [] = return ()
printResults (Match:ms) = printResults ms
printResults ((MisMatch i e a):ms) = do
    T.putStrLn   "Mismatch in example"
    T.putStrLn $ "  Expression: " <> i
    T.putStrLn $ "  Expected:   " <> e
    T.putStrLn $ "  Actual:     " <> a

    printResults ms
