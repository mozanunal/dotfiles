-- Guard so this file runs once per buffer
if vim.b.lsp_lua_cfgd then return end
vim.b.lsp_lua_cfgd = true

-- Set buffer-local indentation options (Lua community standard is often 2 spaces)
vim.bo.expandtab = true -- use spaces for tabs
vim.bo.shiftwidth = 2   -- number of spaces for an indent
vim.bo.tabstop = 2      -- number of spaces a <Tab> in the file counts for

-- Format the current buffer using an attached LSP server that supports formatting.
-- This is typically handled by lua_ls, which has a built-in formatter.
local function format_buffer() vim.lsp.buf.format({ async = true }) end

-- Format the entire project asynchronously using the 'stylua' CLI
local function format_project()
  vim.fn.jobstart('stylua .', {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Project formatting with stylua finished.', vim.log.levels.INFO)
        vim.cmd('checktime') -- Reload buffer if it was changed by the formatter
      else
        vim.notify('Project formatting with stylua failed.', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Set buffer-local keymaps
vim.keymap.set('n', '<leader>lf', format_buffer, {
  buffer = true,
  desc = '[L]SP [F]ormat Buffer (LSP/Stylua)',
})

vim.keymap.set('n', '<leader>lF', format_project, {
  buffer = true,
  desc = '[L]SP [F]ormat Project (Stylua)',
})
