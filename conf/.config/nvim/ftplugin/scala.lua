
-- Guard so this file runs once per buffer
if vim.b.lsp_scala_cfgd then return end
vim.b.lsp_scala_cfgd = true

-- Set buffer-local indentation options (common Scala style)
vim.bo.expandtab = true -- use spaces for tabs
vim.bo.shiftwidth = 2 -- number of spaces for an indent
vim.bo.tabstop = 2 -- number of spaces a <Tab> in the file counts for

-- Format the current buffer using the attached Metals LSP server
local function format_buffer() vim.lsp.buf.format({ async = true }) end

-- Format the entire project asynchronously using the 'scalafmt' CLI
local function format_project()
  vim.fn.jobstart('scalafmt', {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Project formatting with scalafmt finished.', vim.log.levels.INFO)
        vim.cmd('checktime') -- Reload buffer if it was changed by the formatter
      else
        vim.notify('Project formatting with scalafmt failed. Is scalafmt installed?', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Set buffer-local keymaps
vim.keymap.set('n', '<leader>lf', format_buffer, {
  buffer = true,
  desc = '[L]SP [F]ormat Buffer (Metals/Scalafmt)',
})

vim.keymap.set('n', '<leader>lF', format_project, {
  buffer = true,
  desc = '[L]SP [F]ormat Project (Scalafmt)',
})
