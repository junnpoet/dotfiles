-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.envs")
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
o.window("^(org.gnome.clocks)$", { float = true, size = "900 600" })
o.window("^(xdg-desktop-portal-gtk)$", { float = true, size = "850 650" })
o.window("^(org.strawberrymusicplayer.strawberry)$", { float = true, size = "1000 600" })
o.window("^(strawberry)$", { float = true, size = "850 550" })
o.window("^(PacketTracer)$", { float = true, no_follow_mouse = true })

hl.on("window.open", function(win)
  if win and win.class == "PacketTracer" then
    local width = (win.size and (win.size.x or win.size[1] or win.size.w)) or 0
    if width > 500 then
      hl.dispatch(hl.dsp.window.center({ window = win }))
    end
  end
end)
