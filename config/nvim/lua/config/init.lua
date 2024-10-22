vim.diagnostic.config {
  virtual_text = {
    source = 'if_many',
    prefix = '●',
    severity = {
      min = vim.diagnostic.severity.INFO,
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

vim.cmd [[
  sign define DiagnosticSignError text=󰅚 texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn text=󰀪 texthl=DiagnosticSignWarn linehl= numhl=
  sign define DiagnosticSignInfo text=󰋽 texthl=DiagnosticSignInfo linehl= numhl=
  sign define DiagnosticSignHint text=󰌶 texthl=DiagnosticSignHint linehl= numhl=
]]
