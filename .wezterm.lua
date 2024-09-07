local wezterm = require('wezterm')
local config = wezterm.config_builder()
local act = wezterm.action

-- Launch as PowerShell
config.default_prog = { 'powershell.exe' }

-- Color
-- config.color_scheme = 'OneHalfLight'
-- config.color_scheme = 'One Light (base16)'

-- color_01: '#EEEEEE'    # Black (Host)
-- color_02: '#AF0000'    # Red (Syntax string)
-- color_03: '#008700'    # Green (Command)
-- color_04: '#5F8700'    # Yellow (Command second)
-- color_05: '#0087AF'    # Blue (Path)
-- color_06: '#878787'    # Magenta (Syntax var)
-- color_07: '#005F87'    # Cyan (Prompt)
-- color_08: '#444444'    # White
--
-- color_09: '#BCBCBC'    # Bright Black
-- color_10: '#D70000'    # Bright Red (Command error)
-- color_11: '#D70087'    # Bright Green (Exec)
-- color_12: '#8700AF'    # Bright Yellow
-- color_13: '#D75F00'    # Bright Blue (Folder)
-- color_14: '#D75F00'    # Bright Magenta
-- color_15: '#005FAF'    # Bright Cyan
-- color_16: '#005F87'    # Bright White

 -- "#15161e",
 --        "#f7768e",
 --        "#9ece6a",
 --        "#e0af68",
 --        "#7aa2f7",
 --        "#bb9af7",
 --        "#7dcfff",
 --        "#a9b1d6"

-- -- Color Scheme
-- local papercolor = wezterm.color.get_builtin_schemes()['Papercolor Light (Gogh)']
-- papercolor.cursor_bg = '#444444'
-- papercolor.cursor_fg = '#444444'
-- papercolor.cursor_border = '#D70000'
-- papercolor.brights[4] = '#444444'
-- papercolor.brights[1] = '#0087af'
-- papercolor.brights[8] = '#d70087'
-- config.color_schemes = { ['PaperColor'] = papercolor }
-- config.color_scheme = 'PaperColor'
-- local scheme = wezterm.color.get_builtin_schemes()['VibrantInk']
-- scheme.cursor_bg = '#444444'
-- scheme.cursor_fg = '#444444'
-- scheme.cursor_border = '#D70000'
-- config.color_schemes = { ['Roy'] = scheme }
-- config.color_scheme = 'Roy'
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').dawn
config.colors = theme.colors()
config.colors.cursor_bg = '#D70000'
config.window_frame = theme.window_frame()

-- Font
config.font = wezterm.font('CaskaydiaCove Nerd Font Mono' )

-- Key Binding
config.keys = {
  -- New Pane
  { key = 'd', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain'} },
  { key = 's', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain'} },

  -- Close Pane
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true } },

  -- Focus Pane
  { key = 'h', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },

  -- Copy & Paste
  { key = 'C', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection', },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

  -- Rename Tab
  {
    key = 'm',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  }
}

-- Go To Tabs
for i = 1, 6 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = act.ActivateTab(i - 1)
  })
end

-- Move Tabs
for i = 1, 6 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|SHIFT',
    action = act.MoveTab(i - 1)
  })
end

return config
