-- =============================================================================
-- WezTerm Configuration - Obsidian · Sapphire · Tyrian Theme
-- =============================================================================
--
-- This file configures the WezTerm terminal emulator.
-- Documentation: https://wezfurlong.org/wezterm/config/lua/general.html
--
-- LUA BASICS FOR BEGINNERS:
-- • Lines starting with -- are comments (ignored by the program)
-- • 'local' creates a variable only accessible in this file
-- • 'require' imports a module (like Python's import)
-- • Tables {} are Lua's arrays/dictionaries (like Python dicts)
-- • Strings can use 'single' or "double" quotes
-- =============================================================================

-- Import the wezterm module (required for all wezterm configs)
local wezterm = require 'wezterm'

-- Create a config builder - this is the modern way to build wezterm configs
-- It provides better error messages and autocompletion support
local config = wezterm.config_builder()

-- =============================================================================
-- COLOR SCHEME
-- =============================================================================
-- We define our custom colors matching the Obsidian · Sapphire · Tyrian palette
-- These get used for the terminal's 16 ANSI colors and UI elements

config.colors = {
    -- The default text color (Platinum)
    foreground = '#E5E4E2',
    -- The default background color (Obsidian)
    background = '#1B1B1B',

    -- Cursor colors
    cursor_bg = '#F7E7CE',      -- Champagne Gold - visible against dark bg
    cursor_fg = '#1B1B1B',      -- Obsidian - text under cursor
    cursor_border = '#F7E7CE',  -- Champagne Gold

    -- Selection colors (when you highlight text)
    selection_bg = '#353535',   -- Slate
    selection_fg = '#E5E4E2',   -- Platinum

    -- The 16 ANSI colors that terminal programs use
    -- These are organized as: black, red, green, yellow, blue, magenta, cyan, white
    -- Then "bright" versions of each
    ansi = {
        '#0E0E0E',  -- black (Void Black)
        '#8B2F3A',  -- red (Muted Crimson)
        '#2F6F6B',  -- green (Deep Teal)
        '#EED9B7',  -- yellow (Pale Gold)
        '#0F52BA',  -- blue (Sapphire)
        '#550255',  -- magenta (Imperial Amethyst)
        '#0B3F91',  -- cyan (Deep Sapphire)
        '#C6C6C6',  -- white (Silver)
    },
    brights = {
        '#474747',  -- bright black (Ash)
        '#791B4D',  -- bright red (Tyrian Rose)
        '#2F6F6B',  -- bright green (Deep Teal)
        '#F7E7CE',  -- bright yellow (Champagne Gold)
        '#0F52BA',  -- bright blue (Sapphire)
        '#791B4D',  -- bright magenta (Tyrian Rose)
        '#0F52BA',  -- bright cyan (Sapphire)
        '#E5E4E2',  -- bright white (Platinum)
    },

    -- Tab bar colors (when using tabs)
    tab_bar = {
        background = '#161616',  -- Abyss
        active_tab = {
            bg_color = '#202020',   -- Carbon
            fg_color = '#E5E4E2',   -- Platinum
        },
        inactive_tab = {
            bg_color = '#161616',   -- Abyss
            fg_color = '#919191',   -- Steel
        },
        inactive_tab_hover = {
            bg_color = '#2A2A2A',   -- Graphite
            fg_color = '#C6C6C6',   -- Silver
        },
        new_tab = {
            bg_color = '#161616',   -- Abyss
            fg_color = '#919191',   -- Steel
        },
        new_tab_hover = {
            bg_color = '#550255',   -- Imperial Amethyst
            fg_color = '#E5E4E2',   -- Platinum
        },
    },
}

-- =============================================================================
-- FONT SETTINGS
-- =============================================================================
-- JetBrains Mono is your designated font

config.font = wezterm.font('JetBrains Mono', {
    weight = 'Regular',  -- Options: Thin, Light, Regular, Medium, Bold, etc.
})

-- Font size in points
config.font_size = 12.0

-- Disable ligatures if you find them distracting (JetBrains Mono has ligatures)
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- =============================================================================
-- WINDOW APPEARANCE
-- =============================================================================

-- Slight transparency for that modern look
config.window_background_opacity = 0.85

-- Padding around the terminal content (in pixels)
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

-- Remove the title bar for a cleaner look (uses Hyprland's decorations instead)
config.window_decorations = 'RESIZE'  -- Options: FULL, RESIZE, NONE

-- Disable the tab bar if you prefer a minimal look (uncomment to disable)
-- config.enable_tab_bar = false

-- If keeping tabs, put them at the bottom
config.tab_bar_at_bottom = true

-- Use the fancy tab bar style (more customizable)
config.use_fancy_tab_bar = false

-- =============================================================================
-- CURSOR SETTINGS
-- =============================================================================

-- Cursor style: SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline,
--               SteadyBar, BlinkingBar
config.default_cursor_style = 'SteadyBar'

-- Cursor blink rate in milliseconds (if using a Blinking style)
config.cursor_blink_rate = 500

-- =============================================================================
-- KEYBINDINGS
-- =============================================================================
-- WezTerm keybinds use a similar format to Hyprland
-- CTRL, SHIFT, ALT, SUPER (Windows key) are modifiers
--
-- The 'action' tells WezTerm what to do when the key combo is pressed

local act = wezterm.action  -- Shorthand for wezterm.action

config.keys = {
    -- Split panes (terminal multiplexing like tmux)
    -- CTRL+SHIFT+| = Split horizontally (side by side)
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- CTRL+SHIFT+_ = Split vertically (stacked)
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Navigate between panes with arrow keys
    {
        key = 'LeftArrow',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Down',
    },

    -- Close current pane
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = act.CloseCurrentPane { confirm = true },
    },

    -- New tab
    {
        key = 't',
        mods = 'CTRL|SHIFT',
        action = act.SpawnTab 'CurrentPaneDomain',
    },

    -- Font size adjustments
    {
        key = '+',
        mods = 'CTRL|SHIFT',
        action = act.IncreaseFontSize,
    },
    {
        key = '-',
        mods = 'CTRL',
        action = act.DecreaseFontSize,
    },
    {
        key = '0',
        mods = 'CTRL',
        action = act.ResetFontSize,
    },

    -- Copy/Paste (standard terminal shortcuts)
    {
        key = 'c',
        mods = 'CTRL|SHIFT',
        action = act.CopyTo 'Clipboard',
    },
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = act.PasteFrom 'Clipboard',
    },
}

-- =============================================================================
-- MISC SETTINGS
-- =============================================================================

-- Scrollback buffer (how many lines to keep in history)
config.scrollback_lines = 10000

-- Don't prompt when closing if there's only one pane
config.skip_close_confirmation_for_processes_named = {
    'bash', 'sh', 'zsh', 'fish', 'nu',
}

-- Set zsh as default shell (should auto-detect, but explicit is safer)
config.default_prog = { '/bin/zsh' }

-- Reduce visual bell flash duration (less jarring)
config.visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = 'CursorColor',
}

-- =============================================================================
-- RETURN THE CONFIG
-- =============================================================================
-- This line is REQUIRED - it tells WezTerm to use all our settings
return config
