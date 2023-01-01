-- look_brownsteel.lua drawing engine configuration file for Notion.

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = "#404040",
    highlight_colour = "#707070",
    background_colour = "#121212",
    foreground_colour = "#FFA600",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    font = "xft:FuraCodeNerdFont:size=18",
    text_align = "center",
})

de.defstyle("frame", {
    shadow_colour = "#404040",
    highlight_colour = "#121212",
    padding_colour = "#505050",
    background_colour = "#000000",
    foreground_colour = "#FFA600",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    spacing = 0,
})

de.defstyle("tab", {
    de.substyle("active-selected", {
        shadow_colour = "#1c1c1c",
        highlight_colour = "#1c1c1c",
        background_colour = "#242424",
        foreground_colour = "#FFA600",
    }),
    de.substyle("active-unselected", {
        shadow_colour = "#121212",
        highlight_colour = "#121212",
        background_colour = "#121212",
        foreground_colour = "#6f6f6f",
    }),
    de.substyle("inactive-selected", {
        shadow_colour = "#080808",
        highlight_colour = "#181818",
        background_colour = "#121212",
        foreground_colour = "#804C00",
    }),
    -- de.substyle("inactive-unselected", {
        shadow_colour = "#080808",
        highlight_colour = "#080808",
        background_colour = "#080808",
        foreground_colour = "#4c4c4c",
    -- }),
    text_align = "center",
})


de.defstyle("input", {
    shadow_colour = "#404040",
    highlight_colour = "#707070",
    background_colour = "#1c1c1c",
    foreground_colour = "#FFA600",
    padding_pixels = 1,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    de.substyle("*-cursor", {
        background_colour = "#1c1c1c",
        foreground_colour = "#FFA600",
    }),
    de.substyle("*-selection", {
        background_colour = "#121212",
        foreground_colour = "#ffffff",
    }),
})

de.defstyle("input-menu", {
    de.substyle("active", {
        shadow_colour = "#304050",
        highlight_colour = "#708090",
        background_colour = "#1c1c1c",
        foreground_colour = "#ffffff",
    }),
})


-- Common stdisp settings for the "emboss" styles

de.defstyle("stdisp", {
    shadow_pixels = 0,
    highlight_pixels = 0,
    text_align = "left",

    de.substyle("important", {
        foreground_colour = "green",
    }),

    de.substyle("critical", {
        foreground_colour = "red",
    }),
})

-- Common tab settings for the "emboss" styles

de.defstyle("actnotify", {
    shadow_colour = "#600808",
    highlight_colour = "#c04040",
    background_colour = "#b03030",
    foreground_colour = "#ffffff",
})

de.defstyle("tab-frame", {
    -- TODO: some kind of amend option. It should not be necessary to
    -- duplicate this definition for both tab-frame and tab-menuentry,
    -- or for each style, nor use more complex hacks to communicate
    -- this stuff otherwise.
    de.substyle("*-*-*-unselected-activity", {
        shadow_colour = "#600808",
        highlight_colour = "#c04040",
        background_colour = "#901010",
        foreground_colour = "#eeeeee",
    }),

    de.substyle("*-*-*-selected-activity", {
        shadow_colour = "#600808",
        highlight_colour = "#c04040",
        background_colour = "#b03030",
        foreground_colour = "#ffffff",
    }),

    de.substyle("*-*-*-tabnumber", {
        background_colour = "black",
        foreground_colour = "green",
    }),
})

de.defstyle("tab-frame-tiled", {
    spacing = 0,
})

de.defstyle("tab-menuentry", {
    text_align = "left",
    highlight_pixels = 0,
    shadow_pixels = 0,

    de.substyle("*-*-*-unselected-activity", {
        shadow_colour = "#600808",
        highlight_colour = "#c04040",
        background_colour = "#901010",
        foreground_colour = "#eeeeee",
    }),

    de.substyle("*-*-*-selected-activity", {
        shadow_colour = "#600808",
        highlight_colour = "#c04040",
        background_colour = "#b03030",
        foreground_colour = "#ffffff",
    }),
})

de.defstyle("tab-menuentry-big", {
    padding_pixels = 7,
})

de.defstyle("frame-tiled", {
    border_style = "inlaid",
    padding_pixels = 0,
    spacing = 0,
})

de.defstyle("frame-floating", {
    border_style = "ridge",
    bar = "shaped"
})

de.defstyle("frame-tiled-alt", {
    bar = "none",
})

de.defstyle("dock", {
    border = 7,
    outline_style = "each",
    tile_size = {
        width = "640",
        height= "800",
    },
})

gr.refresh()

