local use_cterm, palette
local dark = {
	base00 = "#2E3440",
	base01 = "#3B4252",
	base02 = "#434C5E",
	base03 = "#4C566A",
	base04 = "#D8DEE9",
	base05 = "#E5E9F0",
	base06 = "#ECEFF4",
	base07 = "#8FBCBB",
	base08 = "#88C0D0",
	base09 = "#81A1C1",
	base0A = "#5E81AC",
	base0B = "#BF616A",
	base0C = "#D08770",
	base0D = "#EBCB8B",
	base0E = "#A3BE8C",
	base0F = "#B48EAD",
}
local light = {
	base00 = "#e5e9f0",
	base01 = "#c2d0e7",
	base02 = "#b8c5db",
	base03 = "#aebacf",
	base04 = "#60728c",
	base05 = "#2e3440",
	base06 = "#3b4252",
	base07 = "#29838d",
	base08 = "#99324b",
	base09 = "#ac4426",
	base0A = "#9a7500",
	base0B = "#4f894c",
	base0C = "#398eac",
	base0D = "#3b6ea8",
	base0E = "#97365b",
	base0F = "#5272af",
}
if vim.o.background == 'dark' then
	palette = dark
else
	palette = light
end
require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
vim.g.colors_name = 'nord'
