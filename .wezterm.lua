local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
local mux = wezterm.mux
local session_manager = require("wezterm-session-manager/session-manager")
wezterm.on("save_session", function(window) session_manager.save_state(window) end)
wezterm.on("load_session", function(window) session_manager.load_state(window) end)
wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)


wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

-- This is where you actually apply your config choices
config.font = wezterm.font('Hasklug Nerd Font Mono')
config.color_scheme = 'Dark Pastel (Gogh)'
config.keys = {
  {
    key = 'q',
    mods = 'CTRL',
    action = act.CloseCurrentTab { confirm = false },
  },
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = act.ToggleFullScreen,
  },
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = act.ToggleAlwaysOnTop,
  },
  {
    key = 'a',
    mods = 'ALT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'e',
    mods = 'ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'o',
    mods = 'ALT',
    action = act.CloseCurrentPane { confirm = false },
  },
  {
    key = 'A',
    mods = 'SHIFT|CTRL',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'E',
    mods = 'SHIFT|CTRL',
    action = act.ActivatePaneDirection 'Down',
  },
  { key = 'U', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  {
    key = 'O',
    mods = 'SHIFT|CTRL',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'A',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Left', 1 },
  },
  {
    key = 'O',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Right', 1 },
  },
  {
    key = 'U',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Up', 1 },
  },
  {
    key = 'E',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Down', 1 },
  },
  {
    key = "S",
    mods = "CTRL|SHIFT",
    action = wezterm.action { EmitEvent = "save_session" }
  },
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = wezterm.action { EmitEvent = "load_session" }
  },
  {
    key = "R",
    mods = "CTRL|SHIFT",
    action = wezterm.action { EmitEvent = "restore_session" }
  }

}

-- For example, changing the color scheme:

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
return config
