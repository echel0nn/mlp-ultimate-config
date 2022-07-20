Config { font            = "xft:JetBrainsMono NF:weight=bold:pixelsize=14:antialias=true:hinting=true"
       , additionalFonts = [ "xft:Mononoki:pixelsize=14"
                           ,"xft:Font Awesome 6 Free Solid:pixelsize=14"
                           , "xft:Font Awesome 6 Brands:pixelsize=14"
                           ]
       , bgColor      = "#282c34"
       , fgColor      = "#bbc2cf"
       , position       = TopSize L 100 30
       , lowerOnStart = True
       , hideOnStart  = False
       , allDesktops  = True
       , persistent   = True
       , iconRoot     = ".config/xmonad/xpm/"  -- default: "."
       , commands = [ Run UnsafeStdinReader ]
       , sepChar = "%"
       , alignSep = "}{"
--       , template =  " %UnsafeStdinReader%}{<fc=><fc=#dfdfdf>%sep% %wlp3s0% </fc> <fc=#c678dd>%sep% %penguin% %uname%</fc><fc=#98be65> %sep% %up% %check-updates% updates</fc> <fc=#da8548>%sep% %baticon% %battery%</fc>  %date% <fc=#666666>%sep%</fc>%trayerpad%"
       , template = " %UnsafeStdinReader%}{"
      }

