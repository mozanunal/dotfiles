-- Basic Keymaps
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzzzv', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzzzv', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '}', '}zz', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '{', '{zz', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>t', ":terminal<CR>i", { desc = '[T]erminal' })
vim.keymap.set('n', '<leader>gg', ":Git<CR>", { desc = '[G]it' })
vim.keymap.set('n', '<leader>gp', ":Git push<CR>", { desc = '[G]it [P]ush' })
vim.keymap.set('n', ']b', ":bn<CR>", { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '[b', ":bp<CR>", { desc = '[B]uffer [P]rev' })
vim.keymap.set('n', '<leader>e', ":Neotree focus toggle<CR>", { desc = 'Open [E]xplorer' })

-- Telescope
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', tb.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tb.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', tb.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
vim.keymap.set('n', '<leader>gf', tb.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', tb.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', tb.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', tb.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', tb.live_grep, { desc = '[S]earch by [G]rep' })

-- Diagnostic Keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', '<leader>sd', tb.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

