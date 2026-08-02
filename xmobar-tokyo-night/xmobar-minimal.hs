Config { font            = "xft:JetBrainsMono NF:weight=bold:pixelsize=14:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=14"
                           ,"xft:Font Awesome 6 Free Solid:pixelsize=14"
                           , "xft:Font Awesome 6 Brands:pixelsize=14"
                           ]
       , bgColor      = "#282c34"
       , fgColor      = "#ff6c6b"
       , position       = TopSize L 100 30
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , iconRoot     = ".config/xmonad/xpm/"  -- default: "."
       , commands = [ Run Com "echo" ["<fn=3>\xf17c</fn>"] "tux" 3600
                    , Run Com "uname" ["-r"] "" -1
                    , Run Com "echo" ["<fn=3>\xf17c</fn>"] "penguin" 3600
                    , Run Com "echo" ["<fn=2>\xf2f9</fn>"] "up" 3600
                    , Run Com "echo" ["<fc=#666666>|</fc>"] "sep" 10000
                    , Run Date "<fc=#a9a1e1><fc=#666666>|</fc> <fn=2>\xf073</fn> %m/%_d/%y </fc><fc=#51afef><fc=#666666>|</fc> <fn=2>\xf017</fn> %H:%M</fc>" "date"  10
                    , Run Com "echo" ["<fn=2>\xf241</fn>"] "baticon" 10000
                    , Run BatteryP ["BAT0"] ["-t", "<left>%"] 360
                    , Run Com "bash" ["/home/rd/.config/xmobar/scripts/mycheckupdates"] "check-updates" 1800
                    , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                    , Run DiskU [("/", "<fn=2>\xf0a0</fn> <free>")] [] 60
                    , Run Network "wlp3s0" ["-t", "<fn=2>\xf1eb</fn> <rx>kb <fn=2>\xf063</fn><fn=2>\xf062</fn> <tx>kb"] 20
                    , Run Cpu ["-t", "<fn=2>\xf2db</fn> <total>%","-H","50","--high","red"] 20
                    , Run Memory ["-t", "<fn=2>\xf233</fn> <used>M (<usedratio>%)"] 20

		    , Run UnsafeStdinReader

                    ]
       , sepChar = "%"
       , alignSep = "}{"
--       , template =  " %UnsafeStdinReader%}{<fc=><fc=#dfdfdf>%sep% %wlp3s0% </fc> <fc=#c678dd>%sep% %penguin% %uname%</fc><fc=#98be65> %sep% %up% %check-updates% updates</fc> <fc=#da8548>%sep% %baticon% %battery%</fc>  %date% <fc=#666666>%sep%</fc>%trayerpad%"
       , template = " %UnsafeStdinReader%}{<fc=#dfdfdf>%wlp3s0% </fc><fc=#98be65> %sep% %up% %check-updates%</fc> <fc=#da8548>%sep% %baticon% %battery%</fc> %date% <fc=#666666>%sep%</fc>%trayerpad%"
      }

