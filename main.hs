{-# LANGUAGE OverloadedStrings #-}
module Main where

import ExLint

import Control.Monad ((<=<))
import System.Environment (getArgs)

import qualified Data.Text.Lazy.IO as TL

main :: IO ()
main = run =<< getArgs

run :: [String] -> IO ()
run [] = printResults =<< lintMarkdown =<< TL.getContents
run fs = mapM_ (printResults <=< lintFile) fs
