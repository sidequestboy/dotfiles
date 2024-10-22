return {
  'echasnovski/mini.surround',
  -- dir = '~/my/code/others/nvim-plugins/mini.surround',
  -- dev = false,
  version = '*',
  opts = function(_, opts)
    opts.mappings = {
      add = '<leader>za',
      delete = '<leader>zd', -- Delete surrounding
      find = '<leader>zf', -- Find surrounding (to the right)
      find_left = '<leader>zF', -- Find surrounding (to the left)
      highlight = '<leader>zh', -- Highlight surrounding
      replace = 'zr', -- Replace surrounding
      update_n_lines = 'zn', -- Update `n_lines`

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    }
  end,
}
