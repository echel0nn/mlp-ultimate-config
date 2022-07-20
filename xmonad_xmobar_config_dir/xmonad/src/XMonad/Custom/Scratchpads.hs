module XMonad.Custom.Scratchpads (myScratchPads) where

import XMonad
import XMonad.Util.NamedScratchpad
import XMonad.ManageHook (className, title, doShift)
import qualified XMonad.StackSet as W
import qualified XMonad.Custom.Variables as C
import qualified XMonad.Custom.Workspaces as C

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "ncmpcpp" spawnMus findMus manageMus
                , NS "calculator" spawnCalc findCalc manageCalc
                , NS "fm" spawnFM findFM manageFM
                ]
  where
    spawnTerm  = C.myTerminalRaw ++ " -t tscratchpad"
    findTerm   = title =? "tscratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMus  = C.myTerminalRaw ++ " -t mus-scratchpad -e ncmpcpp"
    findMus   = title =? "mus-scratchpad"
    manageMus = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w
    spawnFM    = C.myFileManager2
    findFM     = className =? "pcmanfm-qt"
    manageFM   = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w


