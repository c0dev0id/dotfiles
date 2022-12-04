--
-- Options to get some programs work more nicely (or at all)
--

defwinprop{
    class          = "mpv",
    instance       = "selfcam",
    target         = "*dock*",
    -- float          = true,
    ignore_cfgrq    = false,
    ignore_min_size = false,
    min_size = { w = 640, h = 480 }
}

defwinprop{
    name          = "Crack Attack!",
    float          = true,
    ignore_cfgrq   = true,
    transient_mode = true
}
defwinprop{
    class          = "RawTherapee",
    name           = "RawTherapee",
    float          = false,
}

defwinprop{
    class          = "Xpdf",
    instance       = "openDialog_popup",
    ignore_cfgrq   = true
}

defwinprop {
   class     = "stalonetray",
   instance  = "stalonetray",
   statusbar = "systray",
}

-- Define some additional title shortening rules to use when the full
-- title doesn't fit in the available space. The first-defined matching 
-- rule that succeeds in making the title short enough is used.
-- ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
-- ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<...")
-- ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
-- ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<...")
-- ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*)", "$1$|$1$<...")
