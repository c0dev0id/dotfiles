-----------------------------------------------------------------------
-- luakit configuration file, more information at http://luakit.org/ --
-----------------------------------------------------------------------

require "lfs"

local unique_instance = require "unique_instance"
unique_instance.open_links_in_new_window = true

-- Set the number of web processes to use. A value of 0 means 'no limit'.
luakit.process_limit = 8

-- Load library of useful functions for luakit
local lousy = require "lousy"

-- Cookie acceptance policy
soup.accept_policy = "always" -- always, never, no_third_party

-- Cookie storage location
soup.cookies_storage = luakit.data_dir .. "/cookies.db"

-- Load users theme
lousy.theme.init(lousy.util.find_config("theme.lua"))
assert(lousy.theme.get(), "failed to load theme")

-- Load users window class
local window = require "window"

-- Load users webview class
local webview = require "webview"

-- Add luakit://log/ chrome page
local log_chrome = require "log_chrome"

window.add_signal("build", function (w)
    local widgets, l, r = require "lousy.widget", w.sbar.l, w.sbar.r

    -- Left-aligned status bar widgets
    l.layout:pack(widgets.zoom())
    l.layout:pack(widgets.uri())
    l.layout:pack(widgets.hist())
    l.layout:pack(widgets.progress())

    -- Right-aligned status bar widgets
    r.layout:pack(widgets.buf())
    r.layout:pack(log_chrome.widget())
    r.layout:pack(widgets.ssl())
    r.layout:pack(widgets.tabi())
    r.layout:pack(widgets.scroll())
end)

-- Load luakit binds and modes
local modes = require "modes"
local binds = require "binds"

-- Settings (the commented ones do not [yet] work)
local settings = require "settings"
local settings_chrome = require "settings_chrome"

settings.window.home_page           = "luakit://newtab"
settings.window.scroll_step         = 20
settings.window.zoom_step           = 0.2
settings.webview.zoom_level         = 150
settings.window.close_with_last_tab = true

-- search engines
settings.window.search_engines.duckduckgo = "https://duckduckgo.com/?q=%s"
settings.window.search_engines.default    = settings.window.search_engines.duckduckgo

----------------------------------
-- Optional user script loading --
----------------------------------

-- Add adblock
-- local adblock = require "adblock"
-- local adblock_chrome = require "adblock_chrome"

-- Enable Developer Tools
local webinspector = require "webinspector"

-- Add uzbl-like form filling
-- local formfiller = require "formfiller"
-- formfiller.extend({
--     pass = function(s) return io.popen("pass " .. s):read() end
-- })

-- Add proxy support & manager
local proxy = require "proxy"

-- Add quickmarks support & manager
-- local quickmarks = require "quickmarks"

-- Add session saving/loading support
-- local session = require "session"

-- Enable Gopher protocol support
local gopher = require "gopher"

-- Delete website data
local clear_data = require "clear_data"

-- Add command to list closed tabs & bind to open closed tabs
local undoclose = require "undoclose"

-- Add command to list tab history items
-- local tabhistory = require "tabhistory"

-- Add greasemonkey-like javascript userscript support
-- local userscripts = require "userscripts"

-- Add bookmarks support
-- local bookmarks = require "bookmarks"
-- local bookmarks_chrome = require "bookmarks_chrome"

-- Add download support
local downloads = require "downloads"
local downloads_chrome = require "downloads_chrome"
downloads.default_dir = os.getenv("HOME") .. "/Downloads"

-- Add automatic PDF downloading and opening
local viewpdf = require "viewpdf"

-- Add vimperator-like link hinting & following
local follow = require "follow"

-- Add command history
local cmdhist = require "cmdhist"

-- Add search mode & binds
local search = require "search"

-- Add ordering of new tabs
local taborder = require "taborder"

-- Save web history
local history = require "history"
local history_chrome = require "history_chrome"

-- :help pages
local help_chrome = require "help_chrome"
local binds_chrome = require "binds_chrome"

-- Add command completion
local completion = require "completion"

-- Press Control-E while in insert mode to edit the contents of the currently
-- focused <textarea> or <input> element, using `xdg-open`
-- local open_editor = require "open_editor"
-- local editor = require "editor"
-- editor.editor_cmd = "hterm vim {file}"

-- NoScript plugin, toggle scripts and or plugins on a per-domain basis.
-- `,ts` to toggle scripts, `,tp` to toggle plugins, `,tr` to reset.
-- If you use this module, don't use any site-specific `enable_scripts` or
-- `enable_plugins` settings, as these will conflict.
require "noscript"

local follow_selected = require "follow_selected"
local go_input = require "go_input"
local go_next_prev = require "go_next_prev"
local go_up = require "go_up"

-- Filter Referer HTTP header if page domain does not match Referer domain
-- require_web_module("referer_control_wm")

local error_page = require "error_page"

-- Add userstyles loader
local styles = require "styles"
follow.stylesheet = follow.stylesheet .. [===[
  #luakit_select_overlay .hint_label {
      background-color: #f8f8f8;
      border: 1px solid #f00;
      padding: 1px;
      color: #181818;
      font-size: 18px;
      opacity: 1;
   }
]===]

-- Hide scrollbars on all pages
-- local hide_scrollbars = require "hide_scrollbars"

-- local vertical_tabs = require "vertical_tabs"

-- Add a stylesheet when showing images
-- local image_css = require "image_css"

-- Add a new tab page
local newtab_chrome = require "newtab_chrome"
newtab_chrome.new_tab_src = [==[
<html>
    <head><title>New Tab</title></head>
    <body bgcolor=black></body>
</html>
]==]

-- Add tab favicons mod
-- local tab_favicons = require "tab_favicons"
-- local tab = require("lousy.widget.tab")
-- tab.label_format = ""


-- Add :view-source command
local view_source = require "view_source"

-- Use "asdfqwerzxcv" for generating labels
local select = require "select"
select.label_maker = function (s)
    return s.trim(s.sort(s.reverse(s.charset("qwertzuiopasfghjklyxcvbnm"))))
end
follow.pattern_maker = follow.pattern_styles.match_label

-- social media enhancer
local webview = require "webview"
webview.add_signal('init', function (view)
    view:add_signal('navigation-request', function(v, uri)
        if v.uri:match('https://www.reddit.com') then
            v.uri = v.uri:gsub('%www.reddit.com', 'libreddit.kylrth.com')
            return true
        end
        if v.uri:match('https://old.reddit.com') then
            v.uri = v.uri:gsub('%old.reddit.com', 'libreddit.kylrth.com')
            return true
        end
        if v.uri:match('https://old.reddit.com') then
            v.uri = v.uri:gsub('%old.reddit.com', 'libreddit.kylrth.com')
            return true
        end
        if v.uri:match('https://www.twitter.com') then
            v.uri = v.uri:gsub('%www.twitter.com', 'nitter.net')
            return true
        end
        if v.uri:match('https://twitter.com') then
            v.uri = v.uri:gsub('%twitter.com', 'nitter.net')
            return true
        end
        if v.uri:match('https://www.youtube.com') then
            v.uri = v.uri:gsub('%www.youtube.com', 'tube.cadence.moe')
            return true
        end
        if v.uri:match('https://youtube.com') then
            v.uri = v.uri:gsub('%youtube.com', 'tube.cadence.moe')
            return true
        end
        if v.uri:match('https://youtu.be') then
            v.uri = v.uri:gsub('%youtu.be/', 'tube.cadence.moe/watch?v=')
            return true
        end
    end)
end)

-- social media blocker
local webview = require "webview"
webview.add_signal('init', function (view)
    view:add_signal('navigation-request', function(v, uri)
        local blocklist_pattern = {
            "facebook.com",
            ".fb.com",
            ".fbcdn.com",
            ".fbsbx.com",
            ".fbcdn.net",
            ".tfbnw.net",
            "whatsapp.com",
            "online-metrix.net",
            ".fb.me",
            "facebook-web-clients.appspot.com",
            "fbcdn-profile-a.akamaihd.net"
        }
        for key,value in ipairs(blocklist_pattern)
        do
            if v.uri:match(value) then
                print("Navigation request to " .. v.uri .. " blocked.")
                return false
            end
        end
    end)
end)

-----------------------------
-- End user script loading --
-----------------------------

-- Open window
window.new(uris)

-- vim: et:sw=4:ts=8:sts=4:tw=80
