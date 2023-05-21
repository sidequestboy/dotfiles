-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
    fg = "nord_blue",
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  DiagnosticVirtualTextInfo = {
    italic = true,
    fg = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticInfo", true).foreground)
  },
  DiagnosticVirtualTextHint = {
    italic = true,
    fg = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticHint", true).foreground)
  },
  DiagnosticVirtualTextWarn = {
    italic = true,
    fg = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticWarn", true).foreground)
  },
  DiagnosticVirtualTextErr = {
    italic = true,
    fg = string.format("#%x", vim.api.nvim_get_hl_by_name("DiagnosticError", true).foreground)
  },
}

return M
