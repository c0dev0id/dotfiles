--
-- Notion statusbar module configuration file
--

-- Create a statusbar
mod_statusbar.create {

    -- First screen, tl left corner
    screen=0,
    pos='br',

    -- Set this to true if you want a full-width statusbar
    fullsize=true,

    -- Swallow systray windows
    systray=true,

    --  %workspace_name
    --  %workspace_frame
    --  %workspace_pager
    --  %workspace_name_pager
    --  %workspace_num_name_pager

    template="%workspace_pager %filler %systray %shellbar %date",
}

-- Launch ion-statusd. This must be done after creating any statusbars
-- for necessary statusd modules to be parsed from the templates.
-- mod_statusbar.launch_statusd {
--     shellbar,
--     date={ date_format='%a %Y-%m-%d %H:%M', },
-- }
