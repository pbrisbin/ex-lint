module ExLint.Example
    ( getExamples
    ) where

import ExLint.Types (Example(..), Plugin(..))
import ExLint.Plugins (pluginForBlock)

import Data.List (findIndex, isPrefixOf)
import Data.Maybe (mapMaybe)
import Text.Pandoc.Definition (Block(..), Pandoc(..))

getExamples :: Pandoc -> [Example]
getExamples (Pandoc _ blks) = mapMaybe blockToExample blks

blockToExample :: Block -> Maybe Example
blockToExample b@(CodeBlock _ code) =
    pluginForBlock b >>= linesToExample (lines code)

blockToExample _ = Nothing

linesToExample :: [String] -> Plugin -> Maybe Example
linesToExample lns p =
    case findIndex (sigil `isPrefixOf`) $ lns of
        Just idx | idx /= 0 -> Just $ Example
            { examplePlugin = p
            , examplePreamble = unlines $ take (idx - 1) lns
            , exampleExpression = lns !! (idx - 1)
            , exampleResult = drop (length sigil + 1) $ lns !! idx
            }
        _ -> Nothing

    where
        sigil :: String
        sigil = pluginSigil p
