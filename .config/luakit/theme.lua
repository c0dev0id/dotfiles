--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "22px Terminus"
theme.fg   = "#D8D8D8"
theme.bg   = "#181818"

-- Genaral colours
theme.success_fg = "#00FF00"
theme.loaded_fg  = "#33AADD"
theme.error_fg   = "#CCCCCC"
theme.error_bg   = "#FF0000"

-- Warning colours
theme.warning_fg = "#FF0000"
theme.warning_bg = "#FFFFFF"

-- Notification colours
theme.notif_fg = "#444444"
theme.notif_bg = "#FFFFFF"

-- Menu colours
theme.menu_fg                 = "#D8D8D8"
theme.menu_bg                 = "#001800"
theme.menu_selected_fg        = "#181818"
theme.menu_selected_bg        = "#FFFF00"
theme.menu_title_bg           = "#D8D8D8"
theme.menu_primary_title_fg   = "#FF0000"
theme.menu_secondary_title_fg = "#666666"

theme.menu_disabled_fg = "#999999"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg  = theme.menu_fg
theme.menu_enabled_bg  = theme.menu_bg
theme.menu_active_fg   = "#006600"
theme.menu_active_bg   = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg   = '#181818'
theme.proxy_active_menu_bg   = '#CCCCCC'
theme.proxy_inactive_menu_fg = '#888888'
theme.proxy_inactive_menu_bg = '#CCCCCC'

-- Statusbar specific
theme.sbar_fg       = "#D8D8D8"
theme.sbar_bg       = "#181818"

-- Downloadbar specific
theme.dbar_fg       = "#D8D8D8"
theme.dbar_bg       = "#181818"
theme.dbar_error_fg = "#F00"

-- Input bar specific
theme.ibar_fg       = "#D8D8D8"
theme.ibar_bg       = "#181818"

-- Tab label
theme.tab_fg          = "#888888"
theme.tab_bg          = "#000000"
theme.tab_hover_bg    = "#292929"
theme.tab_ntheme      = "#DDDDDD"
theme.selected_fg     = "#ff7800"
theme.selected_bg     = "#1C1C1C"
theme.selected_ntheme = "#33AADD"
theme.loading_fg      = "#33AADD"
theme.loading_bg      = "#181818"

theme.selected_private_tab_bg = "#3D295B"
theme.private_tab_bg          = "#22254A"

-- Trusted/untrusted ssl colours
theme.trust_fg   = "#00FF00"
theme.notrust_fg = "#FF0000"

-- General colour pairings
theme.ok    = { fg = "#FFFFFF", bg = "#181818" }
theme.warn  = { fg = "#FFFF00", bg = "#181818" }
theme.error = { fg = "#FF0000", bg = "#181818" }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#E8E8E8", fg = "#17181C", link = "#03678D" }
theme.gopher_dark  = { bg = "#17181C", fg = "#E8E8E8", link = "#FF9900" }

-- vim: et:sw=4:ts=8:sts=4:tw=80
return theme
