local vault_path = vim.fn.expand '~/my/docs/sidequestboy'
return {
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = {
      'BufReadPre ' .. vault_path .. '/**.md',
      'BufNewFile ' .. vault_path .. '/**.md',
    },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
    },
    opts = {
      dir = '~/my/docs/sidequestboy', -- no need to call 'vim.fn.expand' here
      mappings = {
        -- ["gf"] = ...
      },
    },
    config = function(_, opts)
      require('obsidian').setup(opts)

      vim.keymap.set('n', 'gf', function()
        if require('obsidian').util.cursor_on_markdown_link() then
          return '<cmd>ObsidianFollowLink<CR>'
        else
          return 'gf'
        end
      end, { noremap = false, expr = true })
    end,
  },
  {
    'oflisback/obsidian-bridge.nvim',
    opts = {
      vault_path = vault_path,
      obsidian_server_address = 'http://localhost:27123',
    },
  },
}
