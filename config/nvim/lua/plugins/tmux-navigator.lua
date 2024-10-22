return {
  'christoomey/vim-tmux-navigator',
  config = function()
    vim.keymap.set({ 'n', 't', 'i' }, '<C-h>', function()
      vim.cmd 'TmuxNavigateLeft'
    end, { silent = true })
    vim.keymap.set({ 'n', 't', 'i' }, '<C-l>', function()
      vim.cmd 'TmuxNavigateRight'
    end, { silent = true })
    vim.keymap.set({ 'n', 't', 'i' }, '<C-j>', function()
      vim.cmd 'TmuxNavigateDown'
    end, { silent = true })
    vim.keymap.set({ 'n', 't', 'i' }, '<C-k>', function()
      vim.cmd 'TmuxNavigateUp'
    end, { silent = true })
  end,
}
