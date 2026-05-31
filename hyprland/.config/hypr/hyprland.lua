-- ############################
-- ######## VARIABLES #########
--
-- ############################
local mainMod = "SUPER"

-- Set programs that you use

local terminal = ghostty
local terminalStart = "ghostty --working-directory=$HOME"
local fileManager = "thunar"
local browser = "brave-browser"
local menu = "wofi --show drun -I"

-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- force wayland
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Use XCompose file
hl.env("XCOMPOSEFILE", "~/.XCompose")

-- ################
-- ### MONITORS ###
-- ################

local primaryMonitor = "DP-3"
local secondaryMonitor = "HDMI-A-1"

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = secondaryMonitor,
    mode = "preferred",
    position = "auto-left",
    scale = 1,
    transform = 1,
})


-- workspace assignments

hl.workspace_rule({
    workspace = "1",
    monitor = primaryMonitor,
    default = true,
})
hl.workspace_rule({
    workspace = "3",
    monitor = primaryMonitor,
})
hl.workspace_rule({
    workspace = "5",
    monitor = primaryMonitor,
})
hl.workspace_rule({
    workspace = "7",
    monitor = primaryMonitor,
})
hl.workspace_rule({
    workspace = "9",
    monitor = primaryMonitor,
})
hl.workspace_rule({
    workspace = "2",
    monitor = secondaryMonitor,
    default = true,
})
hl.workspace_rule({
    workspace = "4",
    monitor = secondaryMonitor,
})
hl.workspace_rule({
    workspace = "6",
    monitor = secondaryMonitor,
})
hl.workspace_rule({
    workspace = "8",
    monitor = secondaryMonitor,
})

-- application rules

hl.window_rule({
    name = "Discord",
    match = { class = "discord" },
    workspace = "6",
})

-- #################
-- ### AUTOSTART ###
-- #################

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar &")
    hl.exec_cmd("awww-daemon")
end)

-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- base binds
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminalStart))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd("/bin/bash ~/.config/rofi/powermenu/powermenu.sh"))
hl.bind(mainMod .. " + Control_L", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))

-- Move focus with HJKL
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces with nubmer keys and move windows to workspaces with number keys
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({workspace = i}))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true, drag = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }, { repeating = true }))
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }, { repeating = true }))
hl.bind(mainMod .. " + SHIFT +  code:20", hl.dsp.window.resize({ x = 0, y = 100, relative = true }, { repeating = true }))
hl.bind(mainMod .. " + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = -100, relative = true }, { repeating = true }))


-- NOT ACTIVELY USED CURRENTLY. LEFT AS AN EXAMPLE FOR FUTURE USE IF NEEDED (carried over during lua migration) [

-- --  Laptop multimedia keys for volume and LCD brightness
-- bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
-- bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
-- bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
-- bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
-- bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
-- bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

-- -- Requires playerctl
-- bindl = , XF86AudioNext, exec, playerctl next
-- bindl = , XF86AudioPause, exec, playerctl play-pause
-- bindl = , XF86AudioPlay, exec, playerctl play-pause
-- bindl = , XF86AudioPrev, exec, playerctl previous

-- ]

-- #####################
-- ### LOOK AND FEEL ###
-- #####################

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 15,
        border_size = 1,

        col = {
            active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 12,

        active_opacity = 1.0,
        inactive_opacity = 0.9,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- #####################
-- ##### Animations ####
-- #####################

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23,1},{0.32,1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65,0.05},{0.36,1} } })
hl.curve("linear", { type = "bezier", points = { {0,0}, {1,1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5,0.5}, {0.75,1.0} } })
hl.curve("quick", { type = "bezier", points = { {0.15,0}, {0.1,1} } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true , speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- #############
-- ### INPUT ###
-- #############

hl.config({
    input = {
        kb_layout = "us",
        kb_options = "caps:escape",

        numlock_by_default = true,

        repeat_rate = 40,
        repeat_delay = 600,

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            clickfinger_behavior = true,
            tap_to_click = false,
            natural_scroll = false,
        },
    }
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- #############
-- ## Various ##
-- #############

hl.config({
    ecosystem = {
        no_update_news = true, 
        no_donation_nag = true,
    },
})
