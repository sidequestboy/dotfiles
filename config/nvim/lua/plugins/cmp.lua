return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'jdrupal-dev/css-vars.nvim',
      opts = {
        -- If you use CSS-in-JS, you can add the autocompletion to JS/TS files.
        cmp_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        -- WARNING: The search is not optimized to look for variables in JS files.
        -- If you change the search_extensions you might get false positives and weird completion results.
        search_extensions = { '.js', '.ts', '.jsx', '.tsx' },
      },
    },
    -- Snippet Engine & its associated nvim-cmp source
    { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
    'FelipeLema/cmp-async-path',
    {
      'roobert/tailwindcss-colorizer-cmp.nvim',
      config = function()
        require('tailwindcss-colorizer-cmp').setup {
          color_square_width = 2,
        }
      end,
    },
  },
  config = function()
    local cmp = require 'cmp'

    local luasnip = require 'luasnip'
    -- this loads friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()
    -- this loads my custom snippets
    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { './snippets' },
    }
    luasnip.config.setup {}

    local cmp_opts = {
      experimental = { ghost_text = true },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        ['<C-e>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<C-c>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif cmp.visible() then
            -- cmp.select_next_item()
            cmp.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            -- cmp.select_prev_item()
            cmp.abort()
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'css_vars' },
        { name = 'async_path' },
      },
      formatting = {
        format = require('tailwindcss-colorizer-cmp').formatter,
      },
    }

    cmp.setup(cmp_opts)
  end,
}
