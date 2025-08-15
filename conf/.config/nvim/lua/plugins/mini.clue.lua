return {
  {
    'echasnovski/mini.clue',
    config = function()
      require('mini.clue').setup({
        window = { delay = 50 }, -- faster pop-up
        triggers = {
          -- leader
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          -- common prefixes
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
          -- marks / registers
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
          -- window commands
          { mode = 'n', keys = '<C-w>' },
          -- built-in completion
          { mode = 'i', keys = '<C-space>' },
        },

        clues = {
          -- your top-level groups
          { mode = 'n', keys = '<Leader>f', desc = 'Find' },
          { mode = 'n', keys = '<Leader>g', desc = 'Git' },
          { mode = 'n', keys = '<Leader>l', desc = 'LSP' },

          -- auto-generated packs
          require('mini.clue').gen_clues.builtin_completion(),
          require('mini.clue').gen_clues.g(), -- `g` motions
          require('mini.clue').gen_clues.z(), -- `z` folds/etc.
          require('mini.clue').gen_clues.marks(),
          require('mini.clue').gen_clues.registers(),
          require('mini.clue').gen_clues.windows({
            submode_move = true,
            submode_navigate = true,
            submode_resize = true,
          }),
        },
      })
    end,
  },
}
