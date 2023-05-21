---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-h>"] = { ":<C-U>TmuxNavigateLeft<CR>", opts = { silent = true } },
    ["<C-j>"] = { ":<C-U>TmuxNavigateDown<CR>", opts = { silent = true } },
    ["<C-k>"] = { ":<C-U>TmuxNavigateUp<CR>", opts = { silent = true } },
    ["<C-l>"] = { ":<C-U>TmuxNavigateRight<CR>", opts = { silent = true } },
  },
}

return M
