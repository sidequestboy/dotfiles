-- Strudel = JavaScript + Mini strings

-- Use JS-like settings
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.commentstring = "// %s"

-- Optionally use JavaScript LSP for Strudel
vim.bo.filetype = "strudel"
vim.bo.syntax = "javascript"

-- Link to JS Treesitter parser for now
vim.treesitter.language.register("javascript", "strudel")


