-- Open a terminal automatically only on `nvim` or `nvim .`
local term_on_start = vim.api.nvim_create_augroup('OpenTerminalOnStart', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = term_on_start,
  callback = function()
    local argc = vim.fn.argc() -- number of file args
    if argc == 0 or (argc == 1 and vim.fn.argv(0) == '.') then
      vim.cmd('terminal')
      vim.cmd('setlocal nonumber norelativenumber')
    end
  end,
})
