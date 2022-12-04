--
-- Ion main configuration file
--

-- Meta key that can be use in key bindings (xmodmap)
META="Mod1+"

-- Editor command
EDIT_COMMAND="bterm -e vim"

-- Display command (used to display keyboard layout reference)
VIEW_COMMAND="firefox"

-- Configure global notion core settings
ioncore.set{

    -- Fast clicks are considered double-clicks (default: 250)
    --dblclick_delay=250,

    -- Quit resize mode timeout (default: 1500)
    --kbresize_delay=1500,

    -- Display frame content while resizing (default: false)
    opaque_resize=false,

    -- float dialog type windows
    window_dialog_float=true,

    -- Mouse cursor moves with focus changes (default: true)
    warp=true,

    -- Switch frames to display newly mapped windows (default: true)
    --switchto=true,

    -- On frame close, switch to this frame (default: next)
    -- Possible values: next, last
    --frame_default_index='next',

    -- Auto-unsqueeze transients/menus/queries (default: true)
    -- unsqueeze=false,

    -- Display tooltips for activity on hidden workspace (default: true)
    --screen_notify=true,
    --
    -- Show Workspace after switch
    --workspace_indicator_timeout=1000,
    --
    --
    framed_transients=true,
    window_stacking_request="activate",
}

-- Load configuration of the Ion 'core'. Most bindings are here.
dopath("cfg_notioncore")

-- Load some kludges to make apps behave better.
dopath("cfg_kludges")

-- Define some layouts.
dopath("cfg_layouts")
dopath("cfg_layout_dev")

-- Load modules
-- Module mod_$module loads cfg_$module
dopath("mod_query")
dopath("mod_menu")
dopath("mod_tiling")
dopath("mod_statusbar")
dopath("mod_dock")
dopath("mod_sp")
dopath("mod_float-sb")
-- dopath("min_tabs")

-- dopath("net_client_list") 
dopath("mod_xrandr")
