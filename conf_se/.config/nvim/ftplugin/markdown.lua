require('mini.pairs').setup({
  rules = {
    ['`'] = { action = 'open', pair = '```', neigh_pattern = '[^`]' },
  },
}
)
