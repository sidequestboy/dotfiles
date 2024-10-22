return {
  'sbdchd/neoformat',
  config = function()
    local auto_format_enabled = true
    vim.api.nvim_create_user_command('AutoFormatEnable', function()
      auto_format_enabled = true
      print 'Auto format enabled.'
    end, {})
    vim.api.nvim_create_user_command('AutoFormatDisable', function()
      auto_format_enabled = false
      print 'Auto format disabled.'
    end, {})
    vim.api.nvim_create_user_command('AutoFormatToggle', function()
      if auto_format_enabled then
        vim.cmd 'AutoFormatDisable'
      else
        vim.cmd 'AutoFormatEnable'
      end
    end, {})

    local augroup = vim.api.nvim_create_augroup('fmt', { clear = true })
    local prettierd_filetypes = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.css', '*.scss', '*.html' }
    local prettierd_cmd = 'Neoformat prettierd'
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = augroup,
      pattern = prettierd_filetypes,
      callback = function()
        if auto_format_enabled then
          vim.cmd(prettierd_cmd)
        end
      end,
    })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      group = augroup,
      pattern = prettierd_filetypes,
      callback = function()
        vim.keymap.set({ 'n' }, '<leader>=', function()
          vim.cmd(prettierd_cmd)
        end, { desc = 'Neoformat', buffer = true })
      end,
    })
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      group = augroup,
      pattern = { '*.lua' },
      callback = function()
        if auto_format_enabled then
          vim.cmd 'Neoformat stylua'
        end
      end,
    })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      group = augroup,
      pattern = { '*.lua' },
      callback = function()
        vim.keymap.set({ 'n' }, '<leader>=', function()
          vim.cmd 'Neoformat stylua'
        end, { desc = 'Neoformat', buffer = true })
      end,
    })
  end,
}
