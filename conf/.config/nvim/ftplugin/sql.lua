-- Guard so this file runs once per buffer
if vim.b.lsp_sql_cfgd then return end
vim.b.lsp_sql_cfgd = true

-- Set buffer-local options for writing clean SQL
vim.bo.expandtab = true -- use spaces for tabs
vim.bo.shiftwidth = 4 -- indent size
vim.bo.tabstop = 4 -- number of spaces a <Tab> in the file counts for

-- Format the current buffer using the 'sqlfmt' CLI
-- NOTE: Requires 'sqlfmt' to be installed and in your PATH.
local function format_buffer()
  -- First, save the buffer to ensure the formatter runs on the latest content.
  vim.cmd('write')

  -- Using 'sqlfmt' on a file will format it in place.
  vim.fn.jobstart('sqlfmt ' .. vim.fn.shellescape(vim.fn.expand('%:.')), {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('File formatting with sqlfmt finished.', vim.log.levels.INFO)
        vim.cmd('checktime') -- Reload buffer if it was changed by the formatter
      else
        vim.notify('File formatting with sqlfmt failed.', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Format all supported files (*.sql) in the project asynchronously using the 'sqlfmt' CLI
local function format_project()
  -- First, save the current buffer in case it's part of the project to be formatted.
  vim.cmd('write')

  -- Using 'sqlfmt **/*.sql' will format all SQL files in the project.
  vim.fn.jobstart('sqlfmt **/*.sql', {
    on_exit = function(_, code)
      if code == 0 then
        -- The current buffer is reloaded only if it was one of the files changed.
        vim.notify('Project formatting with sqlfmt finished.', vim.log.levels.INFO)
        vim.cmd('checktime')
      else
        vim.notify('Project formatting with sqlfmt failed.', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Set buffer-local keymaps
vim.keymap.set('n', '<leader>lf', format_buffer, {
  buffer = true,
  desc = '[L]SP [F]ormat Buffer (sqlfmt)',
})

vim.keymap.set('n', '<leader>lF', format_project, {
  buffer = true,
  desc = '[L]SP [F]ormat Project (sqlfmt)',
})
