local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
local mux = wezterm.mux

wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)
-- This is where you actually apply your config choices
config.font =wezterm.font('Hasklug Nerd Font Mono')
config.color_scheme = 'Dark Pastel (Gogh)'
config.keys = {  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = act.ToggleFullScreen,
  },  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = act.ToggleAlwaysOnTop,
  },
    {
        key='a',
        mods ='ALT',
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
      action = act.CloseCurrentPane { confirm = true },
    },
      {
    key ='A',
    mods = 'SHIFT|CTRL',
    action = act.ActivatePaneDirection  'Left' ,
  },
  {
    key = 'E',
    mods = 'SHIFT|CTRL',
    action = act.ActivatePaneDirection  'Down' ,
  },
  { key = 'U', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection  'Up'  },
  {
    key = 'O',
    mods = 'SHIFT|CTRL',
    action = act.ActivatePaneDirection  'Right' ,
  }, 
  {
    key = 'A',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Left', 1 },
  },
  {
    key = 'O',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Right', 1},
  },
  {
    key = 'U',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Up', 1},
  },
  {
    key = 'E',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Down', 1},
  },

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