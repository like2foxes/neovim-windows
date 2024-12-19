return {
  'Wansmer/treesj',
  keys = { '<space>tm', '<space>tj', '<space>ts' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
}
