-- Authors: Unknown
-- License: Unknown
-- Last Changed: Unknown
--
-- Example of floating toggleable statusbar
--

local floatsbscr=ioncore.find_screen_id(0)
local floatsb

floatsb=floatsbscr:attach_new{
    type="WStatusBar",
    unnumbered=true,
    sizepolicy='southwest',
    template='%workspace_pager',
    passive=false,
    level=2
}

local function toggle_floatsb()
    floatsbscr:set_hidden(floatsb, 'toggle')
end

ioncore.defbindings("WScreen", {
    kpress(META.."B", toggle_floatsb)
})
