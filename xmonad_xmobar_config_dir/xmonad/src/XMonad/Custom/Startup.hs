module XMonad.Custom.Startup (myStartupHook) where

import XMonad
import qualified XMonad.Custom.Colors.TokyoNight as C
import XMonad.Util.SpawnOnce
import XMonad.Hooks.SetWMName

myStartupHook :: X ()
myStartupHook = do
  spawn "killall trayer"
  spawnOnce "setxkbmap intl"
  -- spawnOnce "feh -z --bg-fill --no-fehbg /home/rd/wallpapers/pics/TokyoNight"
  spawnOnce "feh -zr --bg-fill --no-fehbg /home/rd/wallpapers/pics/fav"
  spawnOnce "lxsession"
  spawnOnce "picom"
  spawnOnce "nm-applet"
  spawnOnce "xrandr -s 1920x1200"
  -- spawnOnce "sleep 3 && volumeicon"
  spawnOnce "/usr/bin/emacs --daemon"
  spawnOnce "dunst"
  spawnOnce "flameshot"
--  spawnOnce "/home/rd/.cargo/bin/eww daemon"
--  spawn "sleep 3 && /home/rd/.config/eww/launch_eww"
  -- spawnOnce "sxhkd"
  spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 " ++ C.colorTrayer ++ " --height 24")
  -- spawnOnce "nitrogen --restore &"
  setWMName "XMonad"
