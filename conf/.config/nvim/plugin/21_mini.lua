require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.cursorword').setup()
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

local extra = require('mini.extra')
extra.setup()

require('mini.basics').setup({
  options = {
    extra_ui = true,
    win_borders = 'bold',
  },
  mappings = {
    windows = true,
  },
})

local misc = require('mini.misc')
misc.setup_termbg_sync()
misc.setup_restore_cursor()
-- misc.setup_auto_root()

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

local ai = require('mini.ai')
ai.setup({
  custom_textobjects = {
    B = extra.gen_ai_spec.buffer(),
    F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    -- inline-code         `code`
    ['`'] = ai.gen_spec.pair('`', '`', { type = 'greedy' }),
    -- fenced code block  ```lang … ```
    ['c'] = function()
      return ai.find_textobject('a', '`', { n_times = 3 }) -- triple-tick hack
    end,
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
    claude = { pattern = '%f[%w]()CLAUDE()%f[%W]', group = 'MiniHipatternsNote' },
    done = { pattern = '%f[%w]()DONE()%f[%W]', group = 'MiniHipatternsHack' },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
