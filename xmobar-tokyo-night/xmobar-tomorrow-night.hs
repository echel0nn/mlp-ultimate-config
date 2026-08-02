Config { font = "xft:JetBrainsMono NF:weight=bold:antialias=true:hinting=true:pixelsize=14"
       , additionalFonts = ["FontAwesome 5:weight=bold:pixelsize=14"]
       , borderColor = "#88c0d0"
       , bgColor = "#1d1f21"
       , fgColor = "#c5c8c6"
       , alpha = 255
       , position = Static {xpos = 0, ypos = 0, width = 1920, height = 30}
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = False
       , pickBroadest = False
       , persistent = True
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [
                      Run Com "uname" ["-r"] "" -1
                    , Run Com "echo" ["<fn=3>\xf17c</fn>"] "penguin" 3600
                    , Run Com "echo" ["<fn=3>\xf0aa</fn>"] "up" 3600
                    , Run Com "echo" ["<fn=2>\xf053</fn>"] "sep" 10000
                    , Run Date "<fc=#b77ee0>\xf053 \xf073 %a %b %_d %Y </fc><fc=#81a2be>\xf053 \xf017 %H:%M:%S</fc>" "date"  10
                    , Run Com "bash" ["/home/rd/.config/xmobar/scripts/brightness.sh"] "brightness"    10
                    , Run Com "echo" ["<fn=2>\xf241</fn>"] "baticon" 10000
                    , Run BatteryP ["BAT0"] ["-t", "<left>%"] 360
                    , Run Com "bash" ["/home/rd/.local/bin/pacupdate"] "check-updates" 1800
                    , Run Com ".config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 20
                    , Run DiskU [("/", "<fn=2>\xf0a0</fn> <free>")] [] 60
                    , Run Network "wlp3s0" ["-t", "<fn=2>\xf1eb</fn> <rx>kb <fn=2>\xf063</fn><fn=2>\xf062</fn> <tx>kb"] 20
                    , Run Cpu ["-t", "<fn=2>\xf2db</fn> <total>%","-H","50","--high","red"] 20
                    , Run Memory ["-t", "<fn=2>\xf233</fn> <used>M (<usedratio>%)"] 20

		    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %UnsafeStdinReader%}{<fc=#cc6666> %cpu% </fc><fc=#54ced6>%sep% %memory% </fc><fc=#dfdfdf>%sep% %wlp3s0% </fc> <fc=#b294bb>%sep% %penguin% %uname%</fc><fc=#b5bd68> %sep% %up% %check-updates%</fc> <fc=#e6c547>%sep% %baticon% %battery%</fc> %date% <fc=#666666>%sep%</fc>%trayerpad%"


       }
