return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = { size = 20, shade_terminals = true, shading_factor = -15 },
  keys = {
    {
      '<C-t>',
      function()
        vim.cmd(vim.v.count .. 'ToggleTerm')
      end,
      mode = { 'n', 't' },
      desc = 'ToggleTerm',
      silent = true,
    },
  },
}
-- vim.cmd(vim.v.count .. "ToggleTerm")
