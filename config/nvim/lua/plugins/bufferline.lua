return {
  'akinsho/bufferline.nvim',
  dev = false,
  dir = '~/my/code/others/nvim-plugins/bufferline.nvim',
  enabled = true,
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  after = 'catppuccin',
  priority = 998,
  config = function()
    local error_sign = vim.fn.sign_getdefined('DiagnosticSignError')[1].text or '󰅚'
    local warning_sign = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text or '󰀪'
    local palette = require('catppuccin.palettes').get_palette 'mocha'

    local opts = {
      options = {
        sort_by = 'insert_after_current',
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if level:match 'error' then
            return error_sign
          elseif level:match 'warning' then
            return warning_sign
          else
            return ''
          end
        end,
        groups = {
          items = {
            require('bufferline.groups').builtin.pinned:with { icon = '📌' },
          },
        },
      },
      highlights = require('catppuccin.groups.integrations.bufferline').get {
        styles = { 'bold' },
        custom = {
          all = {
            info = { fg = palette.overlay0 },
            info_visible = { fg = palette.overlay0 },
            info_selected = { fg = palette.text },
            hint = { fg = palette.overlay0 },
            hint_visible = { fg = palette.overlay0 },
            hint_selected = { fg = palette.text },
            warning = { fg = palette.yellow, undercurl = true },
            warning_visible = { fg = palette.yellow, undercurl = true },
            warning_selected = { fg = palette.yellow, undercurl = true },
            error = { fg = palette.red, undercurl = true },
            error_visible = { fg = palette.red, undercurl = true },
            error_selected = { fg = palette.red, undercurl = true },
          },
        },
      },
    }
    require('bufferline').setup(opts)

    vim.keymap.set({ 'n' }, '<leader>p', function()
      vim.cmd 'BufferLineTogglePin'
    end, { desc = '[P]in buffer' })

    vim.keymap.set({ 'n' }, '<tab>', function()
      vim.cmd 'BufferLineCycleNext'
    end, { desc = 'next buffer' })
    vim.keymap.set({ 'n' }, '<S-tab>', function()
      vim.cmd 'BufferLineCyclePrev'
    end, { desc = 'previous buffer' })
  end,
}
