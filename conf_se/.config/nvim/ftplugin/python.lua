-- Guard so this file runs once per buffer
if vim.b.lsp_python_cfgd then return end
vim.b.lsp_python_cfgd = true

-- Set buffer-local indentation options
vim.bo.expandtab = true -- use spaces for tabs
vim.bo.shiftwidth = 4 -- number of spaces for an indent
vim.bo.tabstop = 4 -- number of spaces a <Tab> in the file counts for

-- Format the current buffer using the attached ruff_lsp server
local function format_buffer() vim.lsp.buf.format({ async = true, name = 'ruff' }) end

-- Format the entire project asynchronously using the 'ruff' CLI
local function format_project()
  vim.fn.jobstart('ruff format .', {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Project formatting with ruff finished.', vim.log.levels.INFO)
        vim.cmd('checktime') -- Reload buffer if it was changed by the formatter
      else
        vim.notify('Project formatting with ruff failed.', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Set buffer-local keymaps
vim.keymap.set('n', '<leader>lf', format_buffer, {
  buffer = true,
  desc = '[L]SP [F]ormat Buffer (Ruff)',
})

vim.keymap.set('n', '<leader>lF', format_project, {
  buffer = true,
  desc = '[L]SP [F]ormat Project (Ruff)',
})
