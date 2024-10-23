return {
  { 'lewis6991/satellite.nvim' },
  { 'digitaltoad/vim-pug' },
  {
    'ixru/nvim-markdown',
    config = function()
      vim.cmd 'map <Plug> <Plug>Markdown_Fold'
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
  },
  {
    'glepnir/nerdicons.nvim',
    cmd = 'NerdIcons',
    config = function()
      require('nerdicons').setup {}
      vim.keymap.set({ 'n' }, '<leader>i', function()
        vim.cmd 'NerdIcons'
      end, { desc = 'Nerd [i]cons' })
    end,
  },
  -- Git related plugins
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set({ 'n' }, '<leader>G', '<cmd>Git | only<cr>', { silent = true, desc = 'fu[G]itive' })
    end,
  },
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '│' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>gph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      default_merge_method = 'rebase',
      default_to_projects_v2 = true,
      -- suppress_missing_scope = {
      --   projects_v2 = true,
      -- },
    },
    config = function(_, opts)
      require('octo').setup(opts)
    end,
  },

  {
    'sindrets/diffview.nvim',
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- dir = '~/my/code/others/nvim-plugins/lualine.nvim',
    -- dev = false,
    priority = 999,
    dependencies = { 'folke/noice.nvim' },
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
      extensions = {
        'fugitive',
        'neo-tree',
        'quickfix',
        'toggleterm',
        'man',
        'nvim-dap-ui',
        'lazy',
        'fzf',
      },
    },
    config = function(_, opts)
      vim.opt.showmode = false
      opts.sections = {
        lualine_b = {
          'branch',
          'diff',
          { 'diagnostics', sources = { 'nvim_diagnostic' } },
          {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
            color = { fg = '#ff9e64' },
          },
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            color = { fg = '#ff9e64' },
          },
        },
      }
      require('lualine').setup(opts)
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {
      indent = {
        char = '┊',
      },
      scope = {
        char = '┊',
        show_start = false,
      },
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = function()
      local opts = {
        -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
      require('Comment').setup(opts)
    end,
  },
  {
    'declancm/maximize.nvim',
    opts = { default_keymaps = false },
    config = function(_, opts)
      require('maximize').setup(opts)
      vim.keymap.set('n', '<leader>o', function()
        require('maximize').toggle()
      end, { desc = 'make [O]nly window' })
    end,
  },
  { 'echasnovski/mini.ai', version = '*' },
  {
    'stephenway/postcss.vim',
  },
}
