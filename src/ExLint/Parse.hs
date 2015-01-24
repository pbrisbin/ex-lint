{-# LANGUAGE OverloadedStrings #-}
module ExLint.Parse
    ( Block(..)
    , parseBlocks
    ) where

import Data.Conduit (($$), (=$))
import Data.Functor.Identity (runIdentity)
import Data.Text (Text)
import Text.Markdown (def)
import Text.Markdown.Block (Block(..), toBlocks)

import qualified Data.Conduit.List as CL
import qualified Data.Text.Lazy as T

parseBlocks :: T.Text -> [Block Text]
parseBlocks md = runIdentity
    $ CL.sourceList (T.toChunks md)
    $$ toBlocks def =$ CL.consume
