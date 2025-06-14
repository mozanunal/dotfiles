-- guard so this file runs once per buffer
if vim.b.lsp_python_cfgd then return end
vim.b.lsp_python_cfgd = true

-- lsp-config
vim.lsp.enable({ 'pyright', 'ruff'})

-- indent
vim.bo.expandtab  = true    -- space-indent
vim.bo.shiftwidth = 4
vim.bo.tabstop    = 4

-- format
local function format_buffer()
  vim.cmd([[silent keepjumps %!black -]])
end

local function format_project()
  vim.cmd([[silent keepjumps !black .]])
end

vim.keymap.set('n', '<leader>lf', format_buffer,
  { buffer = true, desc = 'LSP|format buffer' })
vim.keymap.set('n', '<leader>lF', format_project,
  { buffer = true, desc = 'LSP|format project' })
