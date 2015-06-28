{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Applicative ((<$>))
import qualified Data.Text as T
import Graphics.Vty

import Brick.Main
import Brick.Util
import Brick.AttrMap
import Brick.Widgets.Core
import Brick.Widgets.Center
import Brick.Widgets.Border
import Brick.Widgets.Border.Style

styles :: [(T.Text, BorderStyle)]
styles =
    [ ("ascii", ascii)
    , ("unicode", unicode)
    , ("unicode bold", unicodeBold)
    , ("unicode rounded", unicodeRounded)
    ]

borderDemos :: [Widget]
borderDemos = mkBorderDemo <$> styles

mkBorderDemo :: (T.Text, BorderStyle) -> Widget
mkBorderDemo (styleName, sty) =
    withBorderStyle sty $
    border $
    hLimit 20 $
    vLimit 5 $
    center $
    txt styleName

borderMappings :: [(AttrName, Attr)]
borderMappings =
    [ (borderAttr,         yellow `on` black)
    , (vBorderAttr,        green `on` red)
    , (hBorderAttr,        white `on` green)
    , (hBorderLabelAttr,   fg blue)
    , (tlCornerAttr,       bg red)
    , (trCornerAttr,       bg blue)
    , (blCornerAttr,       bg yellow)
    , (brCornerAttr,       bg green)
    ]

colorDemo :: Widget
colorDemo =
    withAttrMappings borderMappings $
    borderWithLabel "title" $
    hLimit 20 $
    vLimit 5 $
    center $
    "body"

ui :: Widget
ui =
    hBox borderDemos
    <=> hBorder
    <=> colorDemo
    <=> hBorderWithLabel "horizontal border"
    <=> (center "Left" <+> vBorder <+> center "Right")

main :: IO ()
main = simpleMain [] [ui]