module XMonad.Custom.Keys (myKeys) where

import XMonad
import XMonad.Util.SpawnOnce
import System.Exit (exitSuccess)
import Data.Maybe

import XMonad.Prompt.OrgMode
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Workspace
import XMonad.Prompt.Input
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Man
import XMonad.Prompt.Window
import XMonad.Prompt.XMonad
import XMonad.Prompt.Pass
import XMonad.Prompt.Ssh

import qualified XMonad.StackSet as W
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

import XMonad.Operations

import XMonad.Util.NamedScratchpad

import XMonad.Actions.FloatKeys
import XMonad.Actions.Submap
import XMonad.Actions.Navigation2D
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.GridSelect
import XMonad.Actions.Promote
import XMonad.Actions.Minimize
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen, nextWS, prevWS)
import qualified XMonad.Actions.Search as S

import XMonad.Layout.LimitWindows
import XMonad.Layout.SubLayouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))

import XMonad.Hooks.ManageDocks

import qualified XMonad.Custom.Variables as C
import qualified XMonad.Custom.Scratchpads as C
import qualified XMonad.Custom.GridSelect as C
import qualified XMonad.Custom.XPrompt as C

-- START_KEYS
myKeys :: [(String, X ())]
myKeys =
    -- KB_GROUP WM
  [ ("M-q e", spawn "xmonad --recompile")           -- Recompile XMonad
  , ("M-q r", spawn "xmonad --restart")             -- Restart XMonad
  , ("M-S-r", spawn "xmonad --restart")             -- Restart XMonad
  , ("M-q f", spawn "xrefresh")
  , ("M-S-q", io exitSuccess)                       -- Exit XMonad
  , ("M-S-/", spawn "/home/rd/.config/xmonad/bin/xmonad-keys") -- View keybindings
  , ("M-M1-t", spawn "/home/rd/.local/bin/changetheme")    -- Change theme (script in .local/bin/changetheme)
  , ("M-/ s", spawn "sleep 3 && /home/rd/.config/eww/launch_eww")
  , ("M-/ c", spawn "eww open calendar")
  , ("M-/ k", spawn "killall eww") 
  , ("M-M1-S-/", spawn "feh -z --bg-fill /home/rd/wallpapers/pics/TokyoNight")
  , ("M-M1-/", spawn "feh --bg-fill -z -r /home/rd/wallpapers/pics/fav")
  , ("M-0", spawn "/home/rd/.config/xmonad/bin/xmonadctl 19") -- Horrible way to do it, but I couldn't find anything else
  , ("M-S-0", spawn "/home/rd/.config/xmonad/bin/xmonadctl 20")

  -- KB_GROUP Exit
  , ("M-x M-x", spawn "arcolinux-logout")
  , ("M-x l", spawn ".local/bin/lock")

  -- KB_GROUP Prompts
  , ("M-r <Space>", shellPrompt C.myXPConfig)
  , ("M-r o", orgPrompt C.myXPConfig "TODO" "/home/rd/org-mode/todo.org")
  , ("M-r M-r", shellPrompt C.myXPConfig)
  , ("M-r x", xmonadPrompt C.myXPConfig)
  , ("M-r m", manPrompt C.myXPConfig)
  , ("M-r S-s", sshPrompt C.myXPConfig)
  , ("M-r p p", passPrompt C.myXPConfig)
  , ("M-r p g", passGeneratePrompt C.myXPConfig)
  , ("M-r p r", passRemovePrompt C.myXPConfig)
  , ("M-r c", C.calcPrompt C.myXPConfig "calc")
  , ("M-r w", C.whereisPrompt C.myXPConfig "whereis")
  , ("M-r h", C.shPrompt C.myXPConfig "exec")
  , ("M-r S-o", workspacePrompt C.myXPConfig (windows . W.greedyView))
  
  -- KB_GROUP Floating Windows
  , ("M-M1-<Left>",  withFocused (keysResizeWindow (10,0) (1,1)))
  , ("M-M1-<Right>", withFocused (keysResizeWindow (-10,0) (1,1)))
  , ("M-M1-<Up>",    withFocused (keysResizeWindow (0,10) (1,1)))
  , ("M-M1-<Down>",  withFocused (keysResizeWindow (0,-10) (1,1)))
  , ("M-M1-S-<Left>",   withFocused (keysMoveWindow (-10,0)))
  , ("M-M1-S-<Right>",  withFocused (keysMoveWindow (10,0)))
  , ("M-M1-S-<Up>",     withFocused (keysMoveWindow (0,-10)))
  -- spawnOnce "feh -z --bg-fill --no-fehbg /home/rd/wallpapers/pics/TokyoNight"
  , ("M-M1-S-<Down>",   withFocused (keysMoveWindow (0,10)))


  -- KB_GROUP Run Scripts
  , ("M-p <Space>", spawn "/home/rd/run-scripts/dm-hub")
  , ("M-p <Return>", spawn "/home/rd/run-scripts/dm-calc")
  , ("M-p b", spawn "/home/rd/run-scripts/dm-bookmarks")    -- Run script to go to web bookmark
  , ("M-p S-w", spawn "/home/rd/run-scripts/dm-wifi")
  , ("M-p m", spawn "/home/rd/run-scripts/dm-commands")     -- Run script to run common commands
  , ("M-p e", spawn "/home/rd/run-scripts/dm-confedit")  -- Run script to edit config
  , ("M-p c", spawn "/home/rd/run-scripts/dm-currencies")
  , ("M-p x", spawn "/home/rd/run-scripts/dm-xmonad")
  , ("M-p h", spawn "/home/rd/run-scripts/dm-history")
  , ("M-p /", spawn "/home/rd/run-scripts/dm-help")
  , ("M-p i", spawn "/home/rd/run-scripts/dm-kill")
  , ("M-p l", spawn "/home/rd/run-scripts/dm-lg")
  , ("M-p o", spawn "/home/rd/run-scripts/dm-maim")
  , ("M-p S-d", spawn "/home/rd/run-scripts/dm-man")
  , ("M-p d", spawn "/home/rd/run-scripts/dm-man2")
  , ("M-p n", spawn "/home/rd/run-scripts/dm-note")
  , ("M-p r", spawn "/home/rd/run-scripts/dm-rec")
  , ("M-p t", spawn "/home/rd/run-scripts/dm-translate")
  , ("M-p g", spawn "/home/rd/run-scripts/dm-wall")
  , ("M-p w", spawn "/home/rd/run-scripts/dm-weather")
  , ("M-p s", spawn "/home/rd/run-scripts/dm-websearch")
  , ("M-p a", spawn "/home/rd/run-scripts/dm-archwiki xdg-open")
  , ("M-p M-a", spawn "/home/rd/run-scripts/dm-archwiki \"alacritty -e lynx\"")
  , ("M-p k", spawn "rofi -show keys")
  , ("M-p f", spawn "rofi -show filebrowser")

  -- KB_GROUP Run Launcher
  , ("M-M1-<Return>", spawn "rofi -show drun -show-icons")              -- Run Launcher (Only GUI)
  , ("M-S-<Return>", shellPrompt C.myXPConfig)
  , ("M-e <Return>", spawn "emacsclient -e '(emacs-run-launcher)'")
  , ("M-e S-<Return>", spawn "emacsclient -e '(emacs-web-page-selector)'")
  , ("M-C-<Return>", spawn "rofi -show run -display-run 'Run' -theme /home/rd/.config/rofi/themes/top-tn.rasi")       -- Run Launcher (traditional)
  , ("M1-S-<Return>", spawn "rofi -show window -display-run") -- Show open windows
  , ("M-S-<Space>", spawn "dmenu_run")

  -- KB_GROUP Application launchers
  , ("M-<Return>", spawn (C.myTerminal))                        -- Spawn terminal
  , ("M-d", spawn (C.myTerminal2))                               -- Spawn alt terminal
  , ("M-b w", spawn (C.myTerminal ++ " -e nmtui"))                  -- Spawn nmtui (for network management) in terminal
  , ("M-b p", spawn "pavucontrol")
  , ("M-b M-b", spawn (C.myBrowser))                         -- Spawn browser
  , ("M-b S-b", spawn "nyxt")                         -- Spawn nyxt browser
  , ("M-b b", spawn (C.myBrowser2))                        -- Spawn alt browser
  , ("M-b n", spawn (C.myBrowser ++ " --incognito"))       -- Spawn private window in browser (only in chromium)
  , ("M-b t", spawn ("brave --tor"))                     -- Spawn brave with tor window
  , ("M-b z", spawn "zulip")                          -- Spawn Zulip GUI
  , ("M-b S-z", spawn (C.myTerminal ++ " -e zulip-term"))             -- Spawn Zulip TUI
  , ("M-b M-f", spawn (C.myFileManager))                     -- Spawn alt file manager
  , ("M-b f", spawn (C.myFileManager2))                    -- Spawn file manager
  , ("M-b S-f", spawn (C.myTerminal ++ " -e lf"))

  -- KB_GROUP Panel
  , ("M-M1-b p", spawn "./.config/xmonad/to-polybar.sh")
  , ("M-M1-b S-p", spawn "killall polybar")
  , ("M-M1-b x", spawn "./.config/xmonad/to-xmobar.sh")
  , ("M-M1-b b", spawn "./.config/xmonad/kill-bars.sh")
  , ("M-M1-b M1-b", spawn "./.config/xmonad/to-polybar.sh")
  , ("M-M1-b S-b", spawn "./.config/xmonad/to-xmobar.sh")

  -- KB_GROUP Kill
  , ("M-S-c", kill1)    -- Kill selected window
  , ("M-S-a", killAll)  -- Kill all windows in workspace

  -- KB_GROUP Float/Tile
  , ("M-f", sendMessage (T.Toggle "Floats")) -- Toggle floating layout
  , ("M-t", withFocused $ windows . W.sink)  -- Tile selected floating window
  , ("M-S-t", sinkAll)                 -- Tile all floating windows

  -- KB_GROUP App Grid
  , ("M-g g", C.spawnSelected' C.myAppGrid)                  -- Spawn app grid to launch app
  , ("M-g t", goToSelected $ C.myGridConfig C.myColorizer)   -- Spawn app grid to switch to app
  , ("M-g b", bringSelected $ C.myGridConfig C.myColorizer)  -- Spawn app grid to bring app to current workspace

  -- KB_GROUP Clients
  , ("M-m", windows W.focusMaster)                    -- Move focus to the master window
  , ("M-M1-C-j", windowGo D False)                         -- Move focus down
  , ("M-M1-C-k", windowGo U False)                         -- Move focus up
  , ("M-h", windowGo L False)                         -- Move focus left
  , ("M-l", windowGo R False)                         -- Move focus right
  , ("M-S-m", windows W.swapMaster)              -- Swap the focused window and the master window
  , ("M-M1-C-j", windowSwap D False)                -- Swap focused window down
  , ("M-S-k", windowSwap U False)                -- Swap focused window up
  , ("M-S-h", windowSwap L False)                -- Swap focused window left
  , ("M-S-l", windowSwap R False)                -- Swap focused window right
  , ("M-k", windows W.focusUp)                -- Focus up by id
  , ("M-j", windows W.focusDown)            -- Focus down by id
  , ("M-S-k", windows W.swapUp)               -- Swap up by id
  , ("M-S-j", windows W.swapDown)            -- Swap down by id
  , ("M-<Backspace>", promote)                   -- Moves focused window to master, others maintain order
  , ("M-M1-<Tab>", rotSlavesDown)                     -- Rotate all windows except master and keep focus in place
  , ("M-C-<Tab>", rotAllDown)                        -- Rotate all the windows in the current stack
  , ("M-S-<Up>", sendMessage (IncMasterN 1))        -- Increase # of clients master pane
  , ("M-S-<Down>", sendMessage (IncMasterN (-1)))     -- Decrease # of clients master pane
  , ("M-C-<Up>", increaseLimit)                     -- Increase # of windows
  , ("M-C-<Down>", decreaseLimit)                     -- Decrease # of windows
  , ("M-M1-h", sendMessage Shrink)                        -- Shrink horiz window width
  , ("M-M1-l", sendMessage Expand)                        -- Expand horiz window width
  , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
  , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width
  , ("M-C-h", sendMessage $ pullGroup L)
  , ("M-C-l", sendMessage $ pullGroup R)
  , ("M-C-k", sendMessage $ pullGroup U)
  , ("M-C-j", sendMessage $ pullGroup D)
  , ("M-C-m", withFocused (sendMessage . MergeAll))
  , ("M-C-u", withFocused (sendMessage . UnMerge))
  , ("M-C-/", withFocused (sendMessage . UnMergeAll))
  , ("M-C-.", onGroup W.focusUp')    -- Switch focus to next tab
  , ("M-C-,", onGroup W.focusDown')  -- Switch focus to prev tab
  , ("M-n", withFocused minimizeWindow)
  , ("M-S-n", withLastMinimized maximizeWindowAndFocus)

  -- KB_GROUP Scratchpads
  , ("M-s t", namedScratchpadAction C.myScratchPads "terminal")
  , ("M-s f", namedScratchpadAction C.myScratchPads "fm")
  , ("M-s n", namedScratchpadAction C.myScratchPads "ncmpcpp")
  , ("M-s s", namedScratchpadAction C.myScratchPads "sysmon")
  , ("M-s c", namedScratchpadAction C.myScratchPads "calculator")

  -- KB_GROUP Window Spacing
  , ("M-C-S-k", decWindowSpacing 4)         -- Decrease window spacing
  , ("M-C-S-j", incWindowSpacing 4)         -- Increase window spacing

  -- KB_GROUP Layouts
  , ("M1-<Tab>", sendMessage NextLayout)                                     -- Go to next layout
  , ("M1-S-<Tab>", sendMessage FirstLayout)                                     -- Go to next layout
  , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggle struts
  , ("M-C-b", sendMessage (MT.Toggle NBFULL))
  , ("M-S-b", sendMessage ToggleStruts)                                                                                          

   -- KB_GROUP Workspace
  , ("M-<Tab>", nextWS) -- Go to next workspace
  , ("M-S-<Tab>", prevWS) -- Go to previous workspace

  -- KB_GROUP Emacs
  , ("M-e e", spawn (C.myEmacs))
  , ("M-e t", spawn (C.myEmacs ++ ("--eval '(org-agenda)'")))                                   -- emacs dashboard
  , ("M-e M-e", spawn (C.myEmacs ++ ("--eval '(dashboard-refresh-buffer)'")))                   -- emacs dashboard
  , ("M-e b", spawn (C.myEmacs ++ ("--eval '(ibuffer)'")))                                      -- list buffers
  , ("M-e d", spawn (C.myEmacs ++ ("--eval '(dired nil)'")))                                    -- dired
  , ("M-e i", spawn (C.myEmacs ++ ("--eval '(erc)'")))                                          -- erc irc client
  , ("M-e n", spawn (C.myEmacs ++ ("--eval '(elfeed)'")))                                       -- elfeed rss
  , ("M-e s", spawn (C.myEmacs ++ ("--eval '(eshell)'")))                                       -- eshell
  , ("M-e v", spawn (C.myEmacs ++ ("--eval '(+vterm/here nil)'")))                              -- vterm if on Doom Emacs
  , ("M-e m", spawn (C.myEmacs ++ ("--eval '(mu4e)'")))                                         -- mu4e email
  , ("M-e w", spawn (C.myEmacs ++ ("--eval '(doom/window-maximize-buffer(eww \"gnu.org\"))'"))) -- eww browser


  -- KB_GROUP Media
  , ("M-u <Space>", spawn "playerctl pause")
  , ("M-u S-<Space>", spawn "playerctl play")
  , ("M-u p", spawn "playerctl previous")
  , ("M-u n", spawn "playerctl next")
  , ("M-u m", spawn "pamixer -t")
  , ("M-u j", spawn "xbacklight -dec 1")
  , ("M-u k", spawn "xbacklight -inc 1")
  , ("M-u <Left>", spawn "pamixer -i 1")
  , ("M-u <Right>", spawn "pamixer -d 1")
  , ("M-u <Up>", spawn "pamixer -i 10")
  , ("M-u <Down>", spawn "pamixer -d 10")
  , ("M-u b", spawn "xbacklight -inc 20")
  , ("M-u S-b", spawn "xbacklight -dec 20")
  , ("<XF86AudioPlay>", spawn "playerctl play-pause")
  , ("<XF86AudioPrev>", spawn "playerctl previous")
  , ("<XF86AudioNext>", spawn "playerctl next")
  , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 5%")
  , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5%")
  , ("<XF86AudioMute>", spawn "pamixer -t")
  , ("<XF86AudioRaiseVolume>", spawn "pamixer -i 5")
  , ("<XF86AudioLowerVolume>", spawn "pamixer -d 5")
  , ("M-w <Space>", spawn "mpc toggle")
  , ("M-w n", spawn "mpc next")
  , ("M-w p", spawn "mpc prev")

  -- KB_GROUP Screenshots
  , ("M-S-f f f", spawn "flameshot full -p ~/ScreenShots")
  , ("M-S-f c f", spawn "flameshot full -c")
  , ("M-S-f f s", spawn "flameshot gui")
  , ("M-S-f g", spawn "flameshot launcher")
  , ("<XF86LaunchB>", spawn "flameshot gui")
  , ("M-S-f x", spawn "xfce4-screenshooter")

  -- KB_GROUP Keyboard
  -- Run script at ~/.local/bin/install_keyboards in dotfiles repo for this to work.
  , ("M-M1-<Space> 1", spawn "setxkbmap intl")
  , ("M-M1-<Space> 2", spawn "setxkbmap hmk")
  , ("M-M1-<Space> 3", spawn "setxkbmap wmn -variant intl")
  , ("M-M1-<Space> 4", spawn "setxkbmap fi")
  , ("M-M1-<Space> 5", spawn "setxkbmap dk")
  , ("M-M1-<Space> 6", spawn "setxkbmap in -variant kn")
  , ("M-M1-<Space> 7", spawn "setxkbmap in -variant hi")
  ]
   ++ [("M-r s " ++ k, S.promptSearch C.myXPConfig f) | (k,f) <- C.searchList ]
   ++ [("M-r M-s " ++ k, S.selectSearch f) | (k,f) <- C.searchList ]
   where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
         nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

-- END_KEYS
