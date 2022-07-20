module Main where

import XMonad
import System.IO (hPutStrLn)

import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.Minimize
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks -- (docks)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.InsertPosition

import XMonad.Layout.NoBorders

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.NamedScratchpad

import qualified XMonad.Custom.ManageHook as C
import qualified XMonad.Custom.Variables as C
import qualified XMonad.Custom.Colors.TokyoNight as C
import qualified XMonad.Custom.Startup as C
import qualified XMonad.Custom.Layouts as C
import qualified XMonad.Custom.Workspaces as C
import qualified XMonad.Custom.Keys as C

main :: IO ()
main = do
  xmproc <- spawnPipe ("xmobar $HOME/.config/xmobar/xmobar-" ++ C.colorScheme ++".hs")
  xmonad $ docks $ ewmhFullscreen $ ewmh def
        { manageHook = insertPosition End Newer 
                       <+> C.myManageHook 
        , handleEventHook = serverModeEventHookCmd
                        <+> serverModeEventHook 
                        <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
                        <+> minimizeEventHook
        , modMask = C.myModMask
        , startupHook = C.myStartupHook
        , layoutHook = C.myLayouts
        , workspaces = C.myWorkspaces
        , borderWidth = C.myBorderWidth
        , normalBorderColor = C.myNormColor
        , focusedBorderColor = C.myFocusColor
        , logHook = dynamicLogWithPP $ filterOutWsPP [scratchpadWorkspaceTag] $ xmobarPP
              { ppOutput = \x -> hPutStrLn xmproc x
              , ppCurrent = xmobarColor C.color06 "" -- . wrap "[" "]"
              , ppVisible = xmobarColor C.color05 "" . C.clickable
              , ppHidden = xmobarColor C.color04 "" . wrap
                           ("<fc=" ++ C.color05 ++ ">") "</fc>" . C.clickable
              , ppHiddenNoWindows = xmobarColor "#666666" ""  . C.clickable
              , ppTitle = xmobarColor C.color14 "" . shorten 60
              , ppSep =  "<fc=" ++ C.color09 ++ "> <fn=1>|</fn> </fc>"
              , ppUrgent = xmobarColor C.color02 "" . wrap "!" "!"
              , ppExtras = [C.windowCount]
              , ppOrder  = \(ws:l:t:ex) -> ["<fn=4>" ++ ws ++ "</fn>"] ++ ex ++ ["<fc=" ++ C.color06 ++ ">[" ++ l ++ "]</fc> " ++ t ]
              }

        } `additionalKeysP` C.myKeys

