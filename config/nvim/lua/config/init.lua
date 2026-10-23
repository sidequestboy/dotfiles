vim.diagnostic.config {
  virtual_text = {
    source = 'if_many',
    prefix = '●',
    severity = {
      min = vim.diagnostic.severity.INFO,
    },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = '󰋽',
      [vim.diagnostic.severity.HINT] = '󰌶',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
  -- underline = {
  --   severity = {
  --     min = vim.diagnostic.severity.INFO
  --   },
  -- },
  severity_sort = true,
}

P = function(input)
  return print(vim.inspect(input))
end

