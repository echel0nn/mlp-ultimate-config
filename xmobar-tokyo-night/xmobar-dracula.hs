Config { font            = "xft:JetBrainsMono NF:weight=bold:pixelsize=14:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=14"
                           ,"xft:Font Awesome 6 Free Solid:pixelsize=14"
                           , "xft:Font Awesome 6 Brands:pixelsize=14"
                           ]
       , bgColor      = "#282a36"
       , fgColor      = "#f8f8f2"
       , position       = TopSize L 100 30
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , iconRoot     = ".config/xmonad/xpm/"  -- default: "."
       , commands = [ Run Com "uname" ["-r"] "" -1
                    , Run Com "echo" ["<fn=2>\xf2f9</fn>"] "up" 3600
                    , Run Com "echo" ["<fc=#666666><fn=2>\xf053</fn></fc>"] "sep" 10000
                    , Run Date "<fc=#ff92d0><fc=#666666><fn=2>\xf053</fn></fc> <fn=2>\xf073</fn> %a %m/%_d/%y </fc>" "date"  100000
                    , Run Date "<fc=#bd93f9><fc=#666666><fn=2>\xf053</fn></fc> <fn=2>\xf017</fn> %H:%M:%S</fc>" "time"  10
                    -- , Run Com "echo" ["<fn=2>\xf241</fn>"] "baticon" 10000
                    -- , Run BatteryP ["BAT0"] ["-t", "<left>%"] 360
                    , Run BatteryP       [ "BAT0" ]
                    [ "--template" , "<acstatus>"
                    , "--Low"      , "10"        -- units: %
                    , "--High"     , "80"        -- units: %
                    , "--low"      , "#ff5555" -- #ff5555
                    , "--normal"   , "#f4f99d"
                    , "--high"     , "#50fa7b"

                    , "--" -- battery specific options
                              -- discharging status
                              , "-o"   , "<fn=2>\xf241</fn> <left>% (<timeleft>)"
                              -- AC "on" status
                              , "-O"   , "<fn=2>\xf241</fn> <left>% <fc=#98be65><fn=2>\xf062</fn></fc>" -- 50fa7b
                              -- charged status
                              , "-i"   , "<fn=2>\xf240</fn> <fc=#50fa7b>Full</fc>"
                    ] 50
                    , Run Com "bash" ["/home/rd/.config/xmobar/scripts/mycheckupdates"] "check-updates" 1800
                    , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                    , Run Network "wlp3s0" ["-t", "<fn=2>\xf1eb</fn> <rx>kb <fn=2>\xf063</fn><fn=2>\xf062</fn> <tx>kb"] 20
                    -- , Run Cpu ["-t", "<fn=2>\xf2db</fn> <total>%","-H","50","--high","red"] 20
                    , Run Cpu [ "--template", "<fc=#8be7fd><fn=2>\xf2db</fn> <total>%</fc>"
                              , "--Low","3"
                              , "--High","50"
                              , "--low","#8be7fd"
                              , "--normal","#8be7fd"
                              , "--high","#ff5555"] 50

		    , Run UnsafeStdinReader

                    ]
       , sepChar = "%"
       , alignSep = "}{"
--       , template =  " %UnsafeStdinReader%}{<fc=><fc=#dfdfdf>%sep% %wlp3s0% </fc> <fc=#c678dd>%sep% %penguin% %uname%</fc><fc=#98be65> %sep% %up% %check-updates% updates</fc> <fc=#da8548>%sep% %baticon% %battery%</fc>  %date% <fc=#666666>%sep%</fc>%trayerpad%"
       , template = " <action=`alacritty`><icon=haskell_20.xpm/></action> <fc=#666666>|</fc> %UnsafeStdinReader%}{ <action=`alacritty -e btop`>%cpu%</action> <fc=#e6e6e6>%sep% %wlp3s0%</fc><fc=#f1fa8c> %sep% <action=`alacritty -e doas pacman -Syu --noconfirm`>%up% %check-updates%</action></fc> <fc=#f1fa8c>%sep% %battery%</fc> <action=`emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(cfw:open-org-calendar))'`>%date%</action>%time% <fc=#666666>%sep%</fc>%trayerpad%"
      }

