local wezterm = require 'wezterm';
return {
  enable_tab_bar=false,

  -- font = wezterm.font("JetBrains Mono"),
    font = wezterm.font_with_fallback({"Iosevka Nerd Font Mono"},{foreground="#b0b0b0"}),
    font_size = 11.0,
    -- dpi = 96.0,
    font_dirs = {"/usr/share/fonts/nerd-fonts-complete"},
    font_rules = {
        {
            italic = true,
            font = wezterm.font_with_fallback({"Iosevka Nerd Font Mono Light Italic"},{foreground="#b0b0b0"}),
        },
        {
            intensity = "Bold",
            font = wezterm.font_with_fallback({"Iosevka Nerd Font Mono"}, {foreground="#ffffff"}),
        },
        {
            italic = true,
            intensity = "Bold",
            font = wezterm.font_with_fallback({"Iosevka Nerd Font Mono Medium Italic"}, {foreground="#ffffff"}),
        },
        {
            intensity = "Half",
            font = wezterm.font_with_fallback({"Iosevka Nerd Font Mono Extralight"}, {foreground="#c0c0c0"}),
        },
        {
            italic = true,
            intensity = "Half",
            font = wezterm.font_with_fallback({"Iosevka Nerd Font Mono Extralight Italic"}, {foreground="#c0c0c0"}),
        },
    },
    font_shaper = "Harfbuzz",
    --font_shaper = "Allsorts",
    --font_antialias = "Subpixel",
    harfbuzz_features = {"kern", "liga", "clig", "calt"},
    font_antialias = "Greyscale",
    --font_antialias = "None",
    --font_hinting = "Full",
    font_hinting = "Vertical",
    --font_hinting = "VerticalSubpixel",
    --font_hinting = "None",
}

