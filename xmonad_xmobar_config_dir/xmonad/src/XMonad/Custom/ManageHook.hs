module XMonad.Custom.ManageHook (myManageHook) where

import XMonad
import qualified XMonad.Custom.Workspaces as C
import qualified XMonad.Custom.Scratchpads as C
import XMonad.ManageHook (doShift, className, title)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Util.NamedScratchpad
import Data.Monoid
import XMonad.Core

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [ className =? "confirm"                   --> doFloat
     , className =? "file_progress"             --> doFloat
     , className =? "dialog"                    --> doFloat
     , className =? "download"                  --> doFloat
     , className =? "error"                     --> doFloat
     , className =? "notification"              --> doFloat
     , className =? "pinentry-gtk-2"            --> doFloat
     , className =? "splash"                    --> doFloat
     , className =? "toolbar"                   --> doFloat
     , className =? "Pavucontrol"               --> doCenterFloat
     , title     =? "Bluetooth"                 --> doFloat
     , title     =? "emacs-run-launcher"        --> doCenterFloat
     , title     =? "emacs-web-page-selector"        --> doCenterFloat
     , className =? "Godot_Engine"              --> doFloat
     , className =? "Yad"                       --> doCenterFloat
     , className =? "Microsoft Teams - Preview" --> doShift (C.myWorkspaces !! 4)
     , className =? "Microsoft Teams - Preview" --> hasBorder True
     , className =? "Gimp"                      --> doShift (C.myWorkspaces !! 7)
     , className =? "zoom"                      --> doShift (C.myWorkspaces !! 6)
     , isFullscreen -->  doFullFloat
     ] 
     <+> namedScratchpadManageHook C.myScratchPads
     <+> manageDocks

