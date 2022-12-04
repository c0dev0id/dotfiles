-- look_clean.lua drawing engine configuration file for Ion.

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    shadow_colour = "#233340",
    highlight_colour = "#233340",
    background_colour = "#233340",
    foreground_colour = "grey",
    padding_pixels = 0,
    highlight_pixels = 1,
    shadow_pixels = 1,
    border_style = "elevated",
    font = "-misc-fixed-medium-r-*-*-13-*-*-*-*-60-*-*",
    text_align = "center",
})
de.defstyle("tab", {
    font = "-misc-fixed-medium-r-*-*-13-*-*-*-*-60-*-*",

	de.substyle("*", {
        shadow_colour = "grey15",
        highlight_colour = "grey15",
        background_colour = "black",
        foreground_colour = "grey50",
	}),

    de.substyle("active-selected", {
        shadow_colour = "#233340",
        highlight_colour = "#233340",
        background_colour = "#233340",
        foreground_colour = "grey90",
    }),

    de.substyle("active-unselected", {
        shadow_colour = "grey15",
        highlight_colour = "grey15",
        background_colour = "grey15",
        foreground_colour = "grey",
    }),

    de.substyle("inactive-selected", {
        shadow_colour = "#2A3D4D",
        highlight_colour = "#2A3D4D",
        background_colour = "black",
        foreground_colour = "grey70",
    }),

    de.substyle("inactive-unselected", {
        shadow_colour = "grey15",
        highlight_colour = "grey15",
        background_colour = "black",
        foreground_colour = "grey50",
    }),

    text_align = "center",
})

de.defstyle("input", {
    foreground_colour = "white",
    de.substyle("*-cursor", {
        background_colour = "white",
        foreground_colour = "#405d75",
    }),
    de.substyle("*-selection", {
        background_colour = "#aaaaaa",
        foreground_colour = "black",
    }),
    font = "-misc-fixed-medium-r-*-*-13-*-*-*-*-60-*-*",
})


-- Common settings for the "clean" styles

de.defstyle("frame", {
    background_colour = "#000000",

    de.substyle("active", {
        -- Something detached from the frame is active
--        padding_colour = "#314759",
        --padding_colour = "#233340",
		padding_colour = "grey40",
    }),
    de.substyle("quasiactive", {
        -- Something detached from the frame is active
--		padding_colour = "#FF0000", // XXX ask tuomo about this, how to make it work in reverse?
       padding_colour = "#233340",
    }),
    de.substyle("userattr1", {
        -- For user scripts
        padding_colour = "#009010",
    }),
    padding_pixels = 1,
})

de.defstyle("frame-tiled", {
    shadow_pixels = 0,
    highlight_pixels = 0,
    spacing = 1,
})

de.defstyle("frame-tiled-alt", {
    bar = "none",
})

de.defstyle("frame-floating", {
    bar = "shaped",
    padding_pixels = 0,
})

de.defstyle("frame-transient", {
    bar = "none",
    padding_pixels = 0,
})


de.defstyle("actnotify", {
    shadow_colour = "#c04040",
    highlight_colour = "#c04040",
    background_colour = "#901010",
    foreground_colour = "#eeeeee",
})

de.defstyle("tab", {
    de.substyle("*-*-*-unselected-activity", {
        shadow_colour = "#c04040",
        highlight_colour = "#c04040",
        background_colour = "#901010",
        foreground_colour = "#eeeeee",
    }),
    
    de.substyle("*-*-*-selected-activity", {
        shadow_colour = "#c04040",
        highlight_colour = "#c04040",
        background_colour = "#b03030",
        foreground_colour = "#ffffff",
    }),
    
    de.substyle("*-*-*-tabnumber", {
        background_colour = "black",
        foreground_colour = "green",
    }),
})

de.defstyle("tab-frame", {
    spacing = 1,
})

de.defstyle("tab-frame-floating", {
    spacing = 0,
})

de.defstyle("tab-menuentry", {
    text_align = "left",
	de.substyle("inactive-selected", {
		background_colour = "#233340",
	}),
})

de.defstyle("tab-menuentry-big", {
    font = "-*-helvetica-medium-r-normal-*-17-*-*-*-*-*-*-*",
    padding_pixels = 7,
})


de.defstyle("stdisp", {
    shadow_pixels = 0,
    highlight_pixels = 0,
    text_align = "left",
    background_colour = "#000000",
    foreground_colour = "grey",
    font="-misc-fixed-medium-r-*-*-13-*-*-*-*-60-*-*",
    
    de.substyle("important", {
        foreground_colour = "green",
    }),

    de.substyle("critical", {
        foreground_colour = "red",
    }),
	
	de.substyle("separator", {
	--	foreground_colour = "#405d75",
		foreground_colour = "blue",
	--	foreground_colour = "#8a999e",
	}),
})

de.defstyle("tab-menuentry-big", {
    padding_pixels = 7,
    font = "-misc-fixed-medium-r-*-*-18-*-*-*-*-*-*-*",
})

gr.refresh()


