-- #################
-- ### AUTOSTART ###
-- #################

hl.on("hyprland.start", function ()
    hl.exec_once("waybar &")
    hl.exec_once("awww-daemon")
end)
