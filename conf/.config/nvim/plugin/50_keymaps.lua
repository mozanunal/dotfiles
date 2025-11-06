local kmap = vim.keymap.set
local extra = require('mini.extra')
local pick = require('mini.pick')
local files = require('mini.files')
local diff  = require('mini.diff')
local git  = require('mini.git')

-- custom pickers
local function yank_path()
  local path = vim.fn.expand('%:.') -- “%:.” → path relative to cwd
  if path == '' then return end -- Ignore [No Name] buffers
  vim.fn.setreg('+', path) -- Copy to system clipboard
  vim.notify('Copied (cwd-relative): ' .. path, vim.log.levels.INFO, { title = 'Path' })
end

local function grep_word()
  local word = vim.fn.expand('<cword>')
  if word == '' then return end
  pick.builtin.grep({
    pattern = word,
    tool = 'git',
  })
end

local function grep_live()
  pick.builtin.grep_live({
    tool = 'git',
  })
end

-- search & navigation
kmap({ 'n', 'v' }, 'n', 'nzzzv')
kmap({ 'n', 'v' }, 'N', 'Nzzzv')

-- window management
kmap({ 'n', 'v' }, '<leader>_', ':split<CR>', { silent = true, desc = 'Window Split' })
kmap({ 'n', 'v' }, '<leader>|', ':vsplit<CR>', { silent = true, desc = 'Window VSplit' })
kmap({ 'n', 'v' }, '<leader>q', ':q<CR>', { desc = 'Window Quit' })
kmap({ 'n', 'v' }, 'H', ':bp<CR>', { silent = true })
kmap({ 'n', 'v' }, 'L', ':bn<CR>', { silent = true })

-- terminal helpers
kmap('n', '<leader>tt', ':term<CR>', { silent = true, desc = 'Terminal' })
kmap('n', '<leader>t_', ':split | term<CR>', { silent = true, desc = 'Terminal Split' })
kmap('n', '<leader>t|', ':vsplit | term<CR>', { silent = true, desc = 'Terminal Vsplit' })
kmap('t', '<Esc><Esc>', '<C-\\><C-n>')

-- git & diff
kmap('n', '<leader>gd', diff.toggle_overlay, { desc = 'Git Diff' })
kmap('n', '<leader>gg', '<CMD>terminal lazygit<CR>', { silent = true, desc = 'Lazygit' })

-- file pickers
kmap('n', '<leader>ff', function() pick.builtin.files({ tool = 'git' }) end, { desc = 'Find File' })
kmap('n', '<leader><Space>', function() pick.builtin.files({ tool = 'git' }) end, { desc = 'Find File' })
kmap('n', '<C-p>', function() pick.builtin.files({ tool = 'git' }) end, { desc = 'Find File' })
kmap('n', '<leader>fl', extra.pickers.buf_lines, { silent = true, desc = 'Find Lines' })
kmap('n', '<leader>fs', function() extra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = 'Find Symbols' })
kmap('n', '<leader>e', files.open, { desc = 'File Explorer' })
kmap('n', '<leader>fb', pick.builtin.buffers, { desc = 'Find Buffer' })
kmap('n', '<leader>fg', grep_live, { desc = 'Live Grep' })
kmap('n', '<leader>fo', extra.pickers.options, { desc = 'Find Options' })
kmap('n', '<leader>fe', extra.pickers.explorer, { desc = 'Find Explorer' })
kmap('n', '<leader>/', pick.builtin.grep_live, { desc = 'Live Grep' })
kmap('n', '<leader>fh', pick.builtin.help, { desc = 'Find Help' })
kmap('n', '<leader>fk', extra.pickers.keymaps, { desc = 'Find Keymaps' })
kmap('n', '<leader>`', pick.builtin.resume, { desc = 'Resume Picker' })
kmap('n', '<leader>fd', extra.pickers.diagnostic, { desc = 'Find Diagnostics' })
kmap('n', '<leader>*', grep_word, { desc = 'Grep current word' })
kmap('n', '<leader>fp', extra.pickers.visit_paths, { desc = 'Find Visit Paths' })
kmap('n', '<leader>fP', extra.pickers.oldfiles, { desc = 'Find Visit Paths Global' })
kmap('n', '<leader>fc', extra.pickers.commands, { desc = 'Find Commands' })
kmap('n', '<leader>ft', extra.pickers.colorschemes, { desc = 'Find Themes' })

-- buffers & misc
kmap('n', '<leader>bd', '<CMD>bd<CR>', { silent = true, desc = 'Close Buffer' })
kmap('n', '<leader>o', '<CMD>silent !open %<CR>', { silent = true, desc = 'Open File Externally' })
kmap('n', '<leader>O', '<CMD>silent !open -R %<CR>', { silent = true, desc = 'Reveal File' })
kmap('n', '<leader>yp', yank_path, { desc = 'Yank Relative Path' })

-- lsp actions
kmap('n', '<leader>k', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Help' })
kmap('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
kmap('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, { desc = 'LSP: Format Buffer' })
kmap('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'LSP: Rename' })
kmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP: Add WS Folder' })
kmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'LSP: Remove WS Folder' })
kmap('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover Docs' })
kmap('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Goto Declaration' })
kmap('n', 'gI', vim.lsp.buf.implementation, { desc = 'LSP: Goto Implementation' })
kmap('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Goto Definition' })
kmap('n', 'gr', function() extra.pickers.lsp({ scope = 'references' }) end, { desc = 'LSP: Goto References' })
kmap('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP: Goto Type Definition' })
kmap(
  'n',
  '<leader>wl',
  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  { desc = 'LSP: List WS Folders' }
)
