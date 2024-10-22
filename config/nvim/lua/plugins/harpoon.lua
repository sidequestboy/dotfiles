return {
  'ThePrimeagen/harpoon',
  enabled = false,
  dev = true,
  dir = '~/my/code/others/nvim-plugins/harpoon',
  opts = {
    save_on_toggle = true,
    tabline = false,
  },
  config = function(_, opts)
    require('harpoon').setup(opts)
    vim.keymap.set({ 'n' }, '<leader>m', function()
      require('harpoon.mark').toggle_file()
    end, { desc = 'Harpoon [m]ark' })
    vim.keymap.set({ 'n', 'i', 'c' }, '<C-g>', function()
      vim.cmd 'Telescope harpoon marks'
    end, { desc = 'Harpoon [G]o to file' })
    vim.keymap.set({ 'n' }, '<leader>n', function()
      require('harpoon.ui').nav_next()
    end, { desc = 'Harpoon [n]ext file' })
    vim.keymap.set({ 'n' }, '<leader>p', function()
      require('harpoon.ui').nav_prev()
    end, { desc = 'Harpoon [p]revious file' })
    vim.keymap.set({ 'n' }, '<leader>h', function()
      require('harpoon.ui').nav_file(1)
    end, { desc = 'Harpoon go to file 1' })
    for i = 1, 9, 1 do
      vim.keymap.set({ 'n' }, '<leader>' .. tostring(i), function()
        require('harpoon.ui').nav_file(i)
      end, { desc = 'Harpoon go to file [' .. tostring(i) .. ']' })
    end
  end,
}
