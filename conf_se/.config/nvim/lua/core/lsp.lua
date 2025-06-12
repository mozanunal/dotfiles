vim.diagnostic.config({
  virtual_text = false, -- completely off (will use virtual_lines instead)
  virtual_lines = { -- new handler
    only_current_line = true, -- show virtual lines only under cursor
  },
  severity_sort = true, -- most severe first
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.lsp.enable({ 'terraformls', 'lua_ls', 'gopls', 'pyright', 'ruff', 'rust_analyzer', 'html', 'deno' })
