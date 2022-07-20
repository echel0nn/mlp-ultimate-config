module XMonad.Custom.XPrompt (searchList, myXPConfig, calcPrompt, whereisPrompt, shPrompt) where

import XMonad
import XMonad.Prompt
import XMonad.Prompt.Input
import Data.Char
import XMonad.Hooks.StatusBar.PP (trim)
import XMonad.Util.Run
import Control.Arrow (first)
import qualified Data.Map as M
import qualified XMonad.Actions.Search as S
import qualified XMonad.Custom.Colors.TokyoNight as C
import qualified XMonad.StackSet as W

myXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
myXPKeymap = M.fromList $
  map (first $ (,) controlMask)   -- control + <key>
  [ (xK_z, killBefore)            -- kill line backwards
  , (xK_k, killAfter)             -- kill line fowards
  , (xK_a, startOfLine)           -- move to the beginning of the line
  , (xK_e, endOfLine)             -- move to the end of the line
  , (xK_m, deleteString Next)     -- delete a character foward
  , (xK_b, moveCursor Prev)       -- move cursor forward
  , (xK_f, moveCursor Next)       -- move cursor backward
  , (xK_BackSpace, killWord Prev) -- kill the previous word
  , (xK_y, pasteString)           -- paste a string
  , (xK_g, quit)                  -- quit out of prompt
  , (xK_bracketleft, quit)
  ] ++
  map (first $ (,) mod4Mask)       -- meta key + <key>
  [ (xK_BackSpace, killWord Prev) -- kill the prev word
  , (xK_f, moveWord Next)         -- move a word forward
  , (xK_b, moveWord Prev)         -- move a word backward
  , (xK_d, killWord Next)         -- kill the next word
  , (xK_n, moveHistory W.focusUp')
  , (xK_p, moveHistory W.focusDown')
  ]
  ++
  map (first $ (,) 0) -- <key>
  [ (xK_Return, setSuccess True >> setDone True)
  , (xK_KP_Enter, setSuccess True >> setDone True)
  , (xK_BackSpace, deleteString Prev)
  , (xK_Delete, deleteString Next)
  , (xK_Left, moveCursor Prev)
  , (xK_Right, moveCursor Next)
  , (xK_Home, startOfLine)
  , (xK_End, endOfLine)
  , (xK_Down, moveHistory W.focusUp')
  , (xK_Up, moveHistory W.focusDown')
  , (xK_Escape, quit)
  ]

myXPConfig :: XPConfig
myXPConfig = def
      { font                  = "xft:JetBrainsMono NF:antialias=true:hinting=true:size=14"
        , bgColor             = C.colorBack
        , fgColor             = C.colorFore
        , bgHLight            = C.color06
        , fgHLight            = "#000000"
        , borderColor         = C.colorBack
        , promptBorderWidth   = 1
        , promptKeymap        = myXPKeymap
        , position            = Top
        , height              = 28
        , historySize         = 256
        , historyFilter       = id
        , defaultText         = []
        , autoComplete        = Nothing
        , showCompletionOnTab = False
        , searchPredicate     = S.isPrefixOf
        , alwaysHighlight     = True
        , maxComplRows        = Nothing
        }


calcPrompt :: XPConfig -> String -> X ()
calcPrompt c ans =
    inputPrompt c (trim ans) ?+ \input ->
        liftIO(runProcessWithInput "qalc" [input] "") >>= calcPrompt c
    where
        trim  = f . f
            where f = reverse . dropWhile isSpace



whereisPrompt :: XPConfig -> String -> X ()
whereisPrompt c ans =
  inputPrompt c (trim ans) ?+ \input ->
        liftIO(runProcessWithInput "whereis" [input] "") >>= whereisPrompt c
      where f = reverse . dropWhile isSpace

shPrompt :: XPConfig -> String -> X ()
shPrompt c ans =
  inputPrompt c (trim ans) ?+ \input ->
        liftIO(runProcessWithInput "alacritty -e" [input] "") >>= shPrompt c
      where f = reverse . dropWhile isSpace

archwiki, news, reddit, urban :: S.SearchEngine

archwiki = S.searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
news     = S.searchEngine "news" "https://news.google.com/search?q="
reddit   = S.searchEngine "reddit" "https://www.reddit.com/search/?q="
urban    = S.searchEngine "urban" "https://www.urbandictionary.com/define.php?term="

searchList :: [(String, S.SearchEngine)]
searchList = [ ("a", archwiki)
             , ("d", S.duckduckgo)
             , ("g", S.google)
             , ("h", S.hoogle)
             , ("i", S.images)
             , ("n", news)
             , ("r", reddit)
             , ("s", S.stackage)
             , ("t", S.thesaurus)
             , ("v", S.vocabulary)
             , ("b", S.wayback)
             , ("u", urban)
             , ("w", S.wikipedia)
             , ("y", S.youtube)
             , ("z", S.amazon)
             ]


