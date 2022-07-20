Config { font            = "xft:JetBrainsMono NF:weight=bold:pixelsize=14:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=14"
                           , "xft:Font Awesome 6 Free Solid:pixelsize=14"
                           , "xft:Font Awesome 6 Brands:pixelsize=14"
                           , "xft:JetBrainsMono NF:weight=bold:pixelsize=35:antialias=true:hinting=true"
                           ]
       , bgColor      = "#1a1b26"
       , fgColor      = "#a9b1d6"
       , position       = TopSize L 100 30
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , iconRoot     = ".config/xmonad/xpm/"  -- default: "."
       , commands = [ Run Com "uname" ["-r"] "" -1
                    , Run Com "echo" ["<fn=2>\xf0aa</fn>"] "up" 3600
                    , Run Com "echo" ["<fn=2>\xf11c</fn>"] "keyicon" 3600
                    , Run Com "echo" ["<fc=#777777><fn=2>\xf053</fn></fc>"] "sep" 10000
                    , Run Date "<fc=#73daca><fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf073</fn> %a %m/%d/%y </fc>" "date"  100000
                    , Run Date "<fc=#7dcfff><fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf017</fn> %H:%M:%S</fc>" "time"  10
                    , Run Memory ["-t", "<fc=#b4f9f8><fn=2>\xf233</fn> <used>M (<usedratio>%)</fc>"] 20


                    -- , Run Com "echo" ["<fn=2>\xf241</fn>"] "baticon" 10000
                    -- , Run BatteryP ["BAT0"] ["-t", "<left>%"] 360
                    , Run Com "echo" ["<fn=3>\xf17c</fn>"] "penguin" 3600
                    , Run Com ".config/xmobar/scripts/kernel" [] "kernel" 36000

                    , Run BatteryP       [ "BAT0" ]
                    [ "--template" , "<acstatus>"
                    , "--Low"      , "10"        -- units: %
                    , "--High"     , "80"        -- units: %
                    , "--low"      , "#f7768e" -- #ff5555
                    , "--normal"   , "#7aa2f7"
                    , "--high"     , "#9ece6a"

                    , "--" -- battery specific options
                              -- discharging status
                              -- , "-o"   , " <fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf241</fn> <left>% (<timeleft>)"
                              , "-o"   , " <fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf241</fn> <left>%"
                              -- AC "on" status
                              , "-O"   , " <fc=#777777><fn=2>\xf053</fn></fc> <fn=2>\xf241</fn> <left>% <fc=#9ece6a><fn=2>\xf062</fn></fc>" -- 50fa7b
                              -- charged status
		              , "-i"   , ""
                    ] 50
                    , Run Com "bash" ["/home/rd/.config/xmobar/scripts/mycheckupdates"] "check-updates" 1800
                    , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                    , Run Network "wlp3s0" ["-t", "<fn=2>\xf1eb</fn> <rx>kb <fn=2>\xf063</fn><fn=2>\xf062</fn> <tx>kb"] 20
                    -- , Run Cpu ["-t", "<fn=2>\xf2db</fn> <total>%","-H","50","--high","red"] 20
                    , Run Cpu [ "--template", "<fc=#2ac3de><fn=2>\xf2db</fn> <total>%</fc>"
                              , "--Low","3"
                              , "--High","50"
                              , "--low","#2ac3de"
                              , "--normal","#3bc3de"
                              , "--high","#f7768e"] 50
		    , Run Com "bash" ["/home/rd/.config/xmobar/scripts/keyboard"] "keyboard" 10
		    , Run Com "bash" ["/home/rd/.config/xmobar/scripts/volume"] "volume" 10
		    , Run UnsafeStdinReader

                    ]
       , sepChar = "%"
       , alignSep = "}{"
--       , template =  " %UnsafeStdinReader%}{<fc=><fc=#dfdfdf>%sep% %wlp3s0% </fc> <fc=#c678dd>%sep% %penguin% %uname%</fc><fc=#98be65> %sep% %up% %check-updates% updates</fc> <fc=#da8548>%sep% %baticon% %battery%</fc>  %date% <fc=#777777>%sep%</fc>%trayerpad%"
       , template = " <action=`alacritty`><icon=haskell_20.xpm/></action> <fc=#777777>|</fc> %UnsafeStdinReader%}{ <fc=#a9b1d6>%wlp3s0%</fc><fc=#ff9e64> %sep% <action=`alacritty -e doas pacman -Syu --noconfirm`>%up% %check-updates%</action></fc>%battery% <fc=#7aa2f7>%sep% <action=`pamixer -t`>%volume%</action></fc> <fc=#cfc9c2>%sep% <action=`setxkbmap intl`>%keyicon% %keyboard%</action></fc> <action=`emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(cfw:open-org-calendar))'`>%date%</action>%time% <fc=#777777>%sep%</fc>%trayerpad%"
      }


