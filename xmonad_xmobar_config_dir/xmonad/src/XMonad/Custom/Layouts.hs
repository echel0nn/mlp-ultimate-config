module XMonad.Custom.Layouts (myLayouts) where

import XMonad
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation
import XMonad.Layout.LimitWindows
import XMonad.Layout.Minimize
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.MultiToggle
import XMonad.Layout.Magnifier
import XMonad.Layout.SimplestFloat
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.WindowArranger
import XMonad.Layout.LayoutModifier
import XMonad.Hooks.ManageDocks
import XMonad.Actions.MouseResize
import XMonad.Layout.SubLayouts
import XMonad.Layout.Simplest
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

import qualified XMonad.Custom.Workspaces as C
import qualified XMonad.Custom.Colors.TokyoNight as C
import qualified XMonad.Custom.Variables as C

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True


tall     = renamed [Replace "Tall"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing' 5
           $ minimize
           $ ResizableTall 1 (3/100) (1/2) [] 
tallR    = renamed [Replace "TallR"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing' 5
           $ reflectHoriz
           $ minimize
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "Magnify"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ minimize
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "Monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ minimize
           $ limitWindows 20 Full
floats   = renamed [Replace "Floats"]
           $ smartBorders
           $ minimize
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "Grid"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing' 8
           $ mkToggle (single MIRROR)
           $ minimize
           $ Grid (16/10)
threeCol = renamed [Replace "ThreeCol"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 15
           $ mySpacing' 2
           $ minimize
           $ ThreeCol 1 (3/100) (5/12)
tabs     = renamed [Replace "Tabs"]
           $ minimize
           $ tabbed shrinkText myTabTheme

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = C.myFont
                 , activeColor         = C.color06
                 , inactiveColor       = C.color08
                 , activeBorderColor   = C.color06
                 , inactiveBorderColor = C.colorBack
                 , activeTextColor     = C.colorBack
                 , inactiveTextColor   = C.color16
                 }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder C.myBorderWidth tall
                                 ||| withBorder C.myBorderWidth tallR
                                 ||| noBorders monocle
                                 ||| XMonad.Custom.Layouts.magnify
                                 ||| noBorders tabs
                                 ||| withBorder C.myBorderWidth grid
                                 ||| withBorder C.myBorderWidth threeCol

myLayoutHook2 = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     noBorders monocle
                                 ||| XMonad.Custom.Layouts.magnify
                                 ||| noBorders tabs
                                 ||| withBorder C.myBorderWidth grid
                                 ||| withBorder C.myBorderWidth threeCol
                                 ||| withBorder C.myBorderWidth tall
                                 ||| withBorder C.myBorderWidth tallR

myLayoutHook3 = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder C.myBorderWidth grid
                                 ||| withBorder C.myBorderWidth threeCol
                                 ||| withBorder C.myBorderWidth tall
                                 ||| withBorder C.myBorderWidth tallR
                                 ||| noBorders monocle
                                 ||| XMonad.Custom.Layouts.magnify
                                 ||| noBorders tabs

myLayoutHook4 = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder C.myBorderWidth threeCol
                                 ||| withBorder C.myBorderWidth tall
                                 ||| withBorder C.myBorderWidth tallR
                                 ||| noBorders monocle
                                 ||| XMonad.Custom.Layouts.magnify
                                 ||| noBorders tabs
                                 ||| withBorder C.myBorderWidth grid

myLayoutHook5 = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     noBorders tabs 
                                 ||| withBorder C.myBorderWidth grid
                                 ||| withBorder C.myBorderWidth threeCol
                                 ||| withBorder C.myBorderWidth tall
                                 ||| withBorder C.myBorderWidth tallR
                                 ||| noBorders monocle
                                 ||| XMonad.Custom.Layouts.magnify

myLayouts = onWorkspace (C.myWorkspaces !! 0) myLayoutHook4
          $ onWorkspace (C.myWorkspaces !! 5) myLayoutHook5
	  $ onWorkspace (C.myWorkspaces !! 6) myLayoutHook2
	  $ onWorkspace (C.myWorkspaces !! 8) myLayoutHook5
	  $ onWorkspace (C.myWorkspaces !! 4) myLayoutHook2
	  $ onWorkspace (C.myWorkspaces !! 3) myLayoutHook2
	  $ myLayoutHook
