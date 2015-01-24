module ExLint.Example
    ( getExamples
    ) where

import ExLint.Types (Example(..), Plugin(..))
import ExLint.Parse (Block(..))
import ExLint.Plugins (pluginForBlock)

import Data.List (findIndex)
import Data.Maybe (mapMaybe)
import Data.Text (Text)

import qualified Data.Text as T

getExamples :: [Block a] -> [Example]
getExamples = mapMaybe blockToExample

blockToExample :: Block a -> Maybe Example
blockToExample b@(BlockCode _ code) =
    pluginForBlock b >>= linesToExample (T.lines code)

blockToExample _ = Nothing

linesToExample :: [Text] -> Plugin -> Maybe Example
linesToExample lns p =
    case findIndex (sigil `T.isPrefixOf`) $ lns of
        Just idx | idx /= 0 -> Just $ Example
            { examplePlugin = p
            , examplePreamble = T.unlines $ take (idx - 1) lns
            , exampleExpression = lns !! (idx - 1)
            , exampleResult = T.drop (T.length sigil + 1) $ lns !! idx
            }
        _ -> Nothing

    where
        sigil :: Text
        sigil = pluginSigil p
