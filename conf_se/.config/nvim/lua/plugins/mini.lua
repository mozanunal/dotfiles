return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      -- require("mini.completion").setup()
      require('mini.cursorword').setup()
      require('mini.extra').setup()
      require('mini.fuzzy').setup()
      require('mini.git').setup()
      require('mini.icons').setup()
      require('mini.indentscope').setup()
      require('mini.misc').setup()
      require('mini.move').setup()
      require('mini.notify').setup()
      require('mini.operators').setup()
      require('mini.pairs').setup()
      require('mini.splitjoin').setup()
      require('mini.statusline').setup()
      require('mini.surround').setup()
      require('mini.tabline').setup()
      require('mini.trailspace').setup()
      require('mini.visits').setup()

      require('mini.basics').setup({
        options = {
          extra_ui = true,
          win_borders = 'bold',
        },
        mappings = {
          windows = true,
        },
      })

      require('mini.sessions').setup({ autoread = true, autowrite = true })

      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      require('mini.files').setup({
        windows = {
          max_number = 10,
          preview = false,
          width_focus = 50,
          width_nofocus = 20,
          width_preview = 20,
        },
      })

      require('mini.diff').setup({
        view = {
          style = 'sign',
          signs = {
            add = '▎',
            change = '▎',
            delete = '',
          },
        },
      })

      require('mini.jump2d').setup({
        mappings = {
          start_jumping = 'S',
        },
      })

      require('mini.jump').setup({
        delay = { highlight = 0, idle_stop = 0 },
      })

      require('mini.pick').setup({
        mappings = {
          choose_in_vsplit = '<C-CR>',
        },
        options = {
          use_cache = true,
        },
      })

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
