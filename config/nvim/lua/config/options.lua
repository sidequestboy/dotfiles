-- [[ Setting options ]]
-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.guifont = 'Fira Code,Symbols Nerd Font Mono:h13'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- one line at a time
vim.opt.mousescroll = 'ver:1,hor:1'
-- treat wrapped lines as one line scrolled
-- vim.opt.smoothscroll = true

-- vim.o.colorcolumn = "80"

-- Spaces instead of tabs by default
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- trigger indent after we write "case", and when we backspace.
vim.o.smartindent = true

-- so <C-a> doesn't treat "-n" as negative
vim.opt.nrformats:append { 'unsigned' }

-- set invisible chars
vim.o.list = true
vim.o.listchars = 'tab:>-'

-- don't load netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

local function osc52_copy(lines, _)
  local text = table.concat(lines, '\n')
  local encoded = vim.base64.encode(text)
  local tty = vim.fn.system('tmux display -p "#{client_tty}"'):gsub('%s+', '')
  if tty ~= '' then
    local fd = io.open(tty, 'w')
    if fd then
      fd:write(string.format('\027]52;c;%s\027\\', encoded))
      fd:close()
    end
  end
end

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = osc52_copy,
    ['*'] = osc52_copy,
  },
  paste = {
    ['+'] = function()
      return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' }
    end,
    ['*'] = function()
      return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' }
    end,
  },
}
