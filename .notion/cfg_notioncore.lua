-- WScreen context bindings
-- The bindings in this context are available all the time.

defbindings("WScreen", {
    bdoc("Switch to n:th object (workspace, full screen client window) within current screen."),
    kpress(META.."1", "WScreen.switch_nth(_, 0)"),
    kpress(META.."2", "WScreen.switch_nth(_, 1)"),
    kpress(META.."3", "WScreen.switch_nth(_, 2)"),
    kpress(META.."4", "WScreen.switch_nth(_, 3)"),
    kpress(META.."5", "WScreen.switch_nth(_, 4)"),
    kpress(META.."6", "WScreen.switch_nth(_, 5)"),
    kpress(META.."7", "WScreen.switch_nth(_, 6)"),
    kpress(META.."8", "WScreen.switch_nth(_, 7)"),
    kpress(META.."9", "WScreen.switch_nth(_, 8)"),
    kpress(META.."0", "WScreen.switch_nth(_, 9)"),

    bdoc("Switch to last active object within current screen."),
    kpress(META.."Tab", "ioncore.goto_previous_workspace()"),
    submap(META.."K", {
        bdoc("Go to first region demanding attention or previously active one."),
        kpress("K", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
        bdoc("Go to first object on activity/urgency list."),
        kpress("A", "ioncore.goto_activity()"),
    }),

    bdoc("Switch to next/previous object within current screen."),
    kpress(META.."Shift+Next", "WScreen.switch_next(_)"),
    kpress(META.."Shift+Prior", "WScreen.switch_prev(_)"),

    bdoc("Go to n:th screen on multihead setup."),
    kpress(META.."Shift+1", "ioncore.goto_nth_screen(0)"),
    kpress(META.."Shift+2", "ioncore.goto_nth_screen(1)"),
    kpress(META.."Shift+3", "ioncore.goto_nth_screen(2)"),

    kpress(META.."Shift+Left", "ioncore.goto_prev_screen()"),
    kpress(META.."Shift+Right", "ioncore.goto_next_screen()"),

    bdoc("Create a new workspace of chosen default type."),
    kpress(META.."F12", "ioncore.create_ws(_)"),
    kpress(META.."Shift+F12", "mod_query.query_workspace(_)"),

    bdoc("Display the main menu."),
    --kpress(ALTMETA.."F12", "mod_query.query_menu(_, _sub, 'mainmenu', 'Main menu:')"),
    kpress("Super_L", "mod_menu.menu(_, _sub, 'mainmenu', {big=true})"),

    -- mpress("Button3", "mod_menu.pmenu(_, _sub, 'mainmenu')"),

    bdoc("Display the window list menu."),
    mpress("Button2", "mod_menu.pmenu(_, _sub, 'windowlist')"),

})


-- Client window bindings
--
-- These bindings affect client windows directly.

defbindings("WClientWin", {
     bdoc("Kill client owning the client window."),
     kpress(META.."Q", "WRegion.rqclose(_)"),
      submap(META.."K", {
         kpress("Q", "WClientWin.kill(_)"),
      }),
})


-- Client window group bindings

defbindings("WGroupCW", {
    bdoc("Toggle client window group full-screen mode"),
    kpress(META.."F", "WGroup.set_fullscreen(_, 'toggle')"),
})


-- WMPlex context bindings
--
-- These bindings work in frames and on screens. The innermost of such
-- contexts/objects always gets to handle the key press. 

defbindings("WMPlex", {
     bdoc("Close current object."),
     kpress(META.."Shift+Q", "WRegion.rqclose(_)"),
})

-- Frames for transient windows ignore this bindmap
defbindings("WMPlex.toplevel", {

     bdoc("Toggle tag of current object."),
     kpress(META.."T", "WRegion.set_tagged(_sub, 'toggle')", "_sub:non-nil"),
 --
    bdoc("Query for manual page to be displayed."),
    kpress(META.."M", "mod_query.query_man(_, '::man')"),

    bdoc("Run a small terminal emulator."),
    kpress(META.."Return", "ioncore.exec_on(_, 'sterm')"),

    bdoc("Run a big terminal emulator."),
    kpress(META.."Shift+Return", "ioncore.exec_on(_, 'bterm')"),

    bdoc("Run a huge terminal emulator."),
    kpress(META.."Control+Return", "ioncore.exec_on(_, 'hterm')"),

    bdoc("Screenshot."),
    kpress(META.."Print", "ioncore.exec_on(_, 'sshot')"),

    bdoc("Screenshot selection."),
    kpress(META.."Shift+Print", "ioncore.exec_on(_, 'xpick_copy')"),

    bdoc("Query for command line to execute."),
    kpress(META.."D", "ioncore.exec_on(_, 'dexec')"),

    bdoc("Port list viewer"),
    kpress(META.."S", "ioncore.exec_on(_, 'bterm goport')"),

    bdoc("cscope /usr/src/sys"),
    kpress(META.."Shift+L", "ioncore.exec_on(_, 'dsys')"),

    bdoc("dcont"),
    kpress(META.."Shift+D", "ioncore.exec_on(_, 'sterm dev-continue')"),

    bdoc("Show SSH Menu"),
    kpress(META.."plus", "ioncore.exec_on(_, 'dexec_ssh_favs')"),

    bdoc("Show APPS Menu"),
    kpress(META.."A", "ioncore.exec_on(_, 'dexec_apps')"),

    bdoc("Start Browser"),
    kpress(META.."Shift+F", "ioncore.exec_on(_, 'dexec_browser')"),
    kpress(META.."Shift+M", "ioncore.exec_on(_, 'dexec_man')"),

    bdoc("Start Passmenu"),
    kpress(META.."Shift+P", "ioncore.exec_on(_, 'dexec_pass')"),

    bdoc("Start personal information menu"),
    kpress(META.."P", "ioncore.exec_on(_, 'dexec_pim')"),

    bdoc("Query for Lua code to execute."),
    kpress(META.."L", "mod_query.query_lua(_)"),

    bdoc("Query for a client window to go to."),
    kpress(META.."G", "mod_query.query_gotoclient(_)"),

    bdoc("Detach (float) or reattach an object to its previous location."),
    kpress(META.."space", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),

    bdoc("Show Notion 'live docs'.", "help"),
    kpress(META.."ssharp", "notioncore.show_live_docs(_)"),

})


-- WFrame context bindings
--
-- These bindings are common to all types of frames. Some additional
-- frame bindings are found in some modules' configuration files.

defbindings("WFrame", {
    bdoc("Display context menu."),
    mpress("Button3", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),

    bdoc("Begin move/resize mode."),
    kpress(META.."R", "WFrame.begin_kbresize(_)"),

    bdoc("Switch the frame to display the object indicated by the tab."),
    mclick("Button1@tab", "WFrame.p_switch_tab(_)"),
    mclick("Button2@tab", "WFrame.p_switch_tab(_)"),

    bdoc("Resize the frame."),
    mdrag("Button1@border", "WFrame.p_resize(_)"),
    mdrag(META.."Button3", "WFrame.p_resize(_)"),

    bdoc("Move the frame."),
    mdrag(META.."Button1", "WFrame.p_move(_)"),

    bdoc("Move objects between frames by dragging and dropping the tab."),
    mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),
    mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
})

-- Frames for transient windows ignore this bindmap

defbindings("WFrame.toplevel", {
    -- bdoc("Query for a client window to attach."),
    -- kpress(META.."A", "mod_query.query_attachclient(_)"),

    bdoc("Switch to next/previous object within the frame."),
    kpress(META.."Next", "WFrame.switch_next(_)"),
    kpress(META.."Prior", "WFrame.switch_prev(_)"),

    kpress(META.."XF86Forward", "WFrame.switch_next(_)"),
    kpress(META.."XF86Back", "WFrame.switch_prev(_)"),

    bdoc("Rename Workspace"),
    kpress(META.."Shift+R", "mod_query.query_renameworkspace(nil, _)"),

    submap(META.."K", {
        bdoc("Switch to n:th object within the frame."),
        kpress("1", "WFrame.switch_nth(_, 0)"),
        kpress("2", "WFrame.switch_nth(_, 1)"),
        kpress("3", "WFrame.switch_nth(_, 2)"),
        kpress("4", "WFrame.switch_nth(_, 3)"),
        kpress("5", "WFrame.switch_nth(_, 4)"),
        kpress("6", "WFrame.switch_nth(_, 5)"),
        kpress("7", "WFrame.switch_nth(_, 6)"),
        kpress("8", "WFrame.switch_nth(_, 7)"),
        kpress("9", "WFrame.switch_nth(_, 8)"),
        kpress("0", "WFrame.switch_nth(_, 9)"),

        bdoc("Attach tagged objects to this frame."),
        kpress("T", "ioncore.tagged_attach(_)"),

        bdoc("Rename Workspace"),
        kpress("R", "mod_query.query_renameframe(_)"),
    }),
})

-- Bindings for floating frames.

defbindings("WFrame.floating", {
    bdoc("Toggle shade mode"),
    mdblclick("Button1@tab", "WFrame.set_shaded(_, 'toggle')"),

    bdoc("Raise the frame."),
    mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
    mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
    mclick(META.."Button1", "WRegion.rqorder(_, 'front')"),

    bdoc("Lower the frame."),
    mclick(META.."Button3", "WRegion.rqorder(_, 'back')"),

    bdoc("Move the frame."),
    mdrag("Button1@tab", "WFrame.p_move(_)"),
})


-- WMoveresMode context bindings
--
-- These bindings are available keyboard move/resize mode. The mode
-- is activated on frames with the command begin_kbresize (bound to
-- META.."R" above by default).

defbindings("WMoveresMode", {
    bdoc("Cancel the resize mode."),
    kpress("AnyModifier+Escape","WMoveresMode.cancel(_)"),

    bdoc("End the resize mode."),
    kpress("AnyModifier+Return","WMoveresMode.finish(_)"),

    bdoc("Grow in specified direction."),
    kpress("Left",  "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("Right", "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",    "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("Down",  "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    bdoc("Shrink in specified direction."),
    kpress("Shift+Left",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+Right", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+Up",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+Down",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    bdoc("Move in specified direction."),
    kpress(META.."Left",  "WMoveresMode.move(_,-1, 0)"),
    kpress(META.."Right", "WMoveresMode.move(_, 1, 0)"),
    kpress(META.."Up",    "WMoveresMode.move(_, 0,-1)"),
    kpress(META.."Down",  "WMoveresMode.move(_, 0, 1)"),
})


--
-- Menu definitions
--

-- Main menu
defmenu("mainmenu", {
    menuentry("Lock screen",    "ioncore.exec_on(_, 'slock')"),
    menuentry("Run...",         "mod_query.query_exec(_)"),
    submenu("Session",          "sessionmenu"),
    menuentry("Restart",        "ioncore.restart()"),
})


-- Session control menu
defmenu("sessionmenu", {
    menuentry("Save",           "ioncore.snapshot()"),
    submenu("Styles",           "stylemenu"),
    menuentry("Exit",           "ioncore.shutdown()"),
})


-- Context menu (frame actions etc.)
defctxmenu("WFrame", "Frame", {
    -- Note: this propagates the close to any subwindows; it does not
    -- destroy the frame itself, unless empty. An entry to destroy tiled
    -- frames is configured in cfg_tiling.lua.
    menuentry("Close",          "WRegion.rqclose_propagate(_, _sub)"),
    -- Low-priority entries
    menuentry("Attach tagged", "ioncore.tagged_attach(_)", { priority = 0 }),
    menuentry("Clear tags",    "ioncore.tagged_clear()", { priority = 0 }),
    menuentry("Window info",   "mod_query.show_tree(_, _sub)", { priority = 0 }),
})


-- Context menu for groups (workspaces, client windows)
defctxmenu("WGroup", "Group", {
    menuentry("Toggle tag",     "WRegion.set_tagged(_, 'toggle')"),
    menuentry("De/reattach",    "ioncore.detach(_, 'toggle')"), 
})


-- Context menu for workspaces
defctxmenu("WGroupWS", "Workspace", {
    menuentry("Close",          "WRegion.rqclose(_)"),
    menuentry("Rename",         "mod_query.query_renameworkspace(nil, _)"),
    menuentry("Attach tagged",  "ioncore.tagged_attach(_)"),
})


-- Context menu for client windows
defctxmenu("WClientWin", "Client window", {
    menuentry("Kill",           "WClientWin.kill(_)"),
})
