vim.keymap.set("n", "<leader>p", vim.cmd.PrettierAsync);

vim.cmd [[
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
]]
