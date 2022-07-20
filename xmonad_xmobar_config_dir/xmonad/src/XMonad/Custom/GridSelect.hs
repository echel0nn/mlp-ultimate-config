{-# LANGUAGE LambdaCase #-}

module XMonad.Custom.GridSelect (spawnSelected', myAppGrid, myGridConfig, myColorizer) where

import XMonad
import XMonad.Custom.Variables
import XMonad.Actions.GridSelect


myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x1a,0x1b,0x29) -- lowest inactive bg
                  (0x1a,0x1b,0x29) -- highest inactive bg
                  (0xc7,0x92,0xea) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0x1a,0x1b,0x29) -- active fg

-- gridSelect menu layout
myGridConfig :: p -> GSConfig Window
myGridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 40
    , gs_cellwidth    = 200
    , gs_cellpadding  = 6
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 200
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }



myAppGrid = [ ("Kitty", "alacritty")
                 , ("Brave", "brave")
                 , ("Emacs", "emacsclient -c -a emacs")
                 , ("Firefox", "firefox")
                 , ("Geany", "geany")
                 , ("Qutebrowser", "qutebrowser")
                 , ("Gimp", "gimp")
                 , ("Kdenlive", "kdenlive")
                 , ("LibreOffice Impress", "loimpress")
                 , ("LibreOffice Writer", "lowriter")
                 , ("Libreoffice", "loffice")
                 , ("Libreoffice Calc", "localc")
                 , ("Libreoffice Base", "lobase")
                 , ("Libreoffice Math", "lomath")
                 , ("Libreoffice Draw", "lodraw")
                 , ("OBS", "obs")
                 , ("Teams", "teams")
                 , ("PCManFM", "pcmanfm")
                 , ("Alacritty", "alacritty")
                 , ("htop", myTerminal ++ " -e htop")
                 , ("Neovim", myTerminal ++ " -e nvim")
                 , ("Kakoune", myTerminal ++ " -e kak")
                 , ("gtop", myTerminal ++ " -e gtop")
                 , ("Change Theme", myTerminal ++ " -e ./.local/bin/changetheme")
                 , ("Network", myTerminal ++ " -e nmtui")
                 ]
