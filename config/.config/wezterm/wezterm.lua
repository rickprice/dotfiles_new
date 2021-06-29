local wezterm = require 'wezterm';
return {
  enable_tab_bar=false,
  -- color_scheme="Adventure",
  color_scheme="Jellybeans",

    font = wezterm.font_with_fallback({"Iosevka","Noto Sans Mono","Source Code Pro"}),
    font_size = 11.0,
    -- dpi = 96.0,
    bold_brightens_ansi_colors = true,
    -- font_dirs = {"/usr/share/fonts/TTF"},
    font_shaper = "Harfbuzz",
    harfbuzz_features = {"kern", "liga", "clig", "calt"},
    scrollback_lines = 10000,
}

