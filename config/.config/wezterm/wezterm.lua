local wezterm = require 'wezterm';
return {
  enable_tab_bar=false,
  -- color_scheme="Adventure",
  color_scheme="Jellybeans",

    font = wezterm.font_with_fallback({"Iosevka","JetBrains Mono"}),
    font_size = 11.0,
    -- dpi = 96.0,
    font_dirs = {"/usr/share/fonts/TTF"},
    font_shaper = "Harfbuzz",
    --font_shaper = "Allsorts",
    --font_antialias = "Subpixel",
    harfbuzz_features = {"kern", "liga", "clig", "calt"},
    font_antialias = "Greyscale",
    --font_antialias = "None",
    font_hinting = "Full",
    -- font_hinting = "Vertical",
    --font_hinting = "VerticalSubpixel",
    --font_hinting = "None",
}

