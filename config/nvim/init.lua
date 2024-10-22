vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'config'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require('lazy').setup('plugins', {
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { 'catppuccin' },
  },
  dev = { path = '~/my/code/others/nvim-plugins' },
  -- checker = { enabled = true },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
