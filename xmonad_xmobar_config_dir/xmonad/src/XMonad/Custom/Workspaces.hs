module XMonad.Custom.Workspaces where

import qualified Data.Map as M

import Data.Maybe

-- myWorkspaces = [" dev ", " www ", " sys ", " sch ", " bse ", " bg ", " meet ", " edit ", " misc ", " oth "]
-- myWorkspaces = ["dev", "www", "sys", "sch", "bse", "bg", "meet", "edit", "irc", "oth"]
-- myWorkspaces = ["DEV", "WWW", "SYS", "SCH", "BSE", "BG", "MEET", "EDIT", "IRC", "OTH"]
myWorkspaces = [ "\xf121", "\xfa9e", "\xf120", "\xf973", "\xf7db", "\xf53e", "\xf03d", "\xf03e", "\xf086", "\xf02b"]


myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices
