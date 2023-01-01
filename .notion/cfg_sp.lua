--
-- Ion mod_sp configuration file
--

mod_sp.set_size(2400, 1200);

defbindings("WScreen", {
    bdoc("Toggle scratchpad."),
    kpress(META.."minus", "mod_sp.set_shown_on(_, 'toggle')"),
})

