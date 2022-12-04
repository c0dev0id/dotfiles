--
-- Ion mod_sp configuration file
--

mod_sp.set_size(1600, 800);

defbindings("WScreen", {
    bdoc("Toggle scratchpad."),
    kpress(META.."minus", "mod_sp.set_shown_on(_, 'toggle')"),
})

