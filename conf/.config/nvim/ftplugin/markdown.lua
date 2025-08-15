-- Guard so this file runs once per buffer
if vim.b.lsp_markdown_cfgd then return end
vim.b.lsp_markdown_cfgd = true

-- Set buffer-local options for prose
vim.bo.expandtab = true -- use spaces for tabs
vim.bo.shiftwidth = 2 -- indent size for lists, etc.
vim.bo.tabstop = 2 -- number of spaces a <Tab> in the file counts for

-- Format the current buffer using the attached deno lsp server
-- NOTE: Requires the deno lsp server to be attached for markdown files.
local function format_buffer()
  -- First, save the buffer to ensure the formatter runs on the latest content.
  vim.cmd('write')

  -- Using 'deno fmt' will format all files deno supports (js, ts, json, md) in the current directory.
  vim.fn.jobstart('deno fmt ' .. vim.fn.shellescape(vim.fn.expand('%:.')), {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('File formatting with deno finished.', vim.log.levels.INFO)
        vim.cmd('checktime') -- Reload buffer if it was changed by the formatter
      else
        vim.notify('File formatting with deno failed.', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Format all supported files (including markdown) in the project asynchronously using the 'deno' CLI
local function format_project()
  -- Using 'deno fmt' will format all files deno supports (js, ts, json, md) in the current directory.
  vim.fn.jobstart('deno fmt **/*.md', {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Project formatting with deno finished.', vim.log.levels.INFO)
        vim.cmd('checktime') -- Reload buffer if it was changed by the formatter
      else
        vim.notify('Project formatting with deno failed.', vim.log.levels.ERROR)
      end
    end,
  })
end

-- Set buffer-local keymaps
vim.keymap.set('n', '<leader>lf', format_buffer, {
  buffer = true,
  desc = '[L]SP [F]ormat Buffer (Deno)',
})

vim.keymap.set('n', '<leader>lF', format_project, {
  buffer = true,
  desc = '[L]SP [F]ormat Project (Deno)',
})
