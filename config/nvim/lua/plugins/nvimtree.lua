return {
  'nvim-tree/nvim-tree.lua',
  opts = {
    view = {
      float = {
        enable = true,
        open_win_config = {
          width = 30,
          height = 40,
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)
    vim.keymap.set({ 'n', 'i', 'v' }, '<C-f>', function()
      require('nvim-tree.api').tree.toggle()
    end)
  end,
}
