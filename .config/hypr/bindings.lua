-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- === Migrado desde bindings.conf:32-79 ===

-- Keybindings customizations – rebind SUPER+I for keybindings overlay
hl.unbind("SUPER + K")
o.bind("SUPER + I", "Show key bindings", "omarchy-menu-keybindings")

-- Tiling navigation: remap from arrow keys to HJKL (vim-style)
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + DOWN")
hl.unbind("SUPER + L")
hl.unbind("SUPER + J")

o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + H", hl.dsp.window.bring_to_top())

o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + L", hl.dsp.window.bring_to_top())

o.bind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + K", hl.dsp.window.bring_to_top())

o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + J", hl.dsp.window.bring_to_top())

-- Move layout toggle to SUPER+TAB, overriding existing TAB bindings
hl.unbind("SUPER + TAB")
o.bind("SUPER + TAB", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Toggle window split
o.bind("SUPER + U", "Toggle window split", hl.dsp.layout("togglesplit"))

-- Group navigation (focus) – changegroupactive b/f → hl.dsp.group.prev/next
hl.unbind("SUPER + CTRL + LEFT")
hl.unbind("SUPER + CTRL + RIGHT")
o.bind("SUPER + N", "Previous window in group", hl.dsp.group.prev())
o.bind("SUPER + M", "Next window in group", hl.dsp.group.next())

-- Group navigation (reorder) – movegroupwindow b/f → hl.dsp.group.move_window
o.bind("SUPER + ALT + N", "Reorder window backward", hl.dsp.group.move_window({ direction = "b" }))
o.bind("SUPER + ALT + M", "Reorder window forward", hl.dsp.group.move_window({ direction = "f" }))

-- Emoji picker (Logitech MX Keys) – omarchy-launch-walker fue reemplazado por omarchy-shell
o.bind("SUPER + PERIOD", "Emoji picker", "omarchy-shell shell toggle omarchy.emojis")

-- Application bindings (restaurados desde bindings.conf:8-13)
o.bind("SUPER + SHIFT + CTRL + M", "Music TUI", "omarchy-launch-or-focus-tui cliamp")
hl.unbind("SUPER + SHIFT + M") -- desactiva Spotify (default) que interfiere con Strawberry
o.bind("SUPER + SHIFT + M", "Strawberry", "uwsm-app -- strawberry")
hl.unbind("SUPER + SHIFT + O") -- desactiva Obsidian (default) que ocupa SUPER+SHIFT+O
o.bind("SUPER + SHIFT + O", "Notion", "notion-app")
o.bind("SUPER + SHIFT + I", "Gemini", { webapp = "https://gemini.google.com/app?hl=es" })
hl.unbind("SUPER + SHIFT + G") -- desactiva Signal (default) que ocupa SUPER+SHIFT+G
o.bind("SUPER + SHIFT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = "WhatsApp" })
hl.unbind("SUPER + SHIFT + ALT + G") -- desactiva WhatsApp duplicado en SUPER+SHIFT+ALT+G (default)
