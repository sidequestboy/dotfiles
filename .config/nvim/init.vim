" install vim-plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'

"utility
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug '907th/vim-auto-save'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'chemzqm/denite-extra'
Plug 'glacambre/firenvim', {
  \ 'branch': 'fix_493',
  \ 'do': 'npm install && npm run build && npm run install_manifests' }
Plug 'farmergreg/vim-lastplace'

"eye candy
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'

"organization
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'tbabej/taskwiki'
Plug 'jceb/vim-orgmode'

"programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neomake/neomake'
Plug 'ludovicchabant/vim-gutentags'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

let mapleader=','
let maplocalleader=' '

set mouse=a
set nohls
"set clipboard+=unnamedplus
set number
set splitbelow
set splitright

set ts=4
set sw=4
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set tags+=~/.tags-usr

let g:auto_save = 1
"let g:auto_save_events = ["TextChanged"]

let g:netrw_banner = 0
let g:netrw_liststyle = 3

let g:tmux_resizer_no_mappings = 1

nnoremap <silent> <A-h> :TmuxResizeLeft<CR>
nnoremap <silent> <A-j> :TmuxResizeDown<CR>
nnoremap <silent> <A-k> :TmuxResizeUp<CR>
nnoremap <silent> <A-l> :TmuxResizeRight<CR>

hi vertsplit cterm=NONE ctermfg=black
hi statusline cterm=bold
hi statuslinenc cterm=NONE
"set fillchars+=vert:\ 

tmap <C-l> <C-\><C-n><C-l>
tmap <C-h> <C-\><C-n><C-h>
tmap <C-k> <C-\><C-n><C-k>
tmap <C-j> <C-\><C-n><C-j>

inoremap <C-l> <C-o>:TmuxNavigateRight<cr>
inoremap <C-h> <C-o>:TmuxNavigateLeft<cr>
inoremap <C-j> <C-o>:TmuxNavigateDown<cr>
inoremap <C-k> <C-o>:TmuxNavigateUp<cr>

noremap <leader>n :bn<cr>
noremap <leader>p :bp<cr>
noremap <leader>c :e ~/.config/nvim/init.vim<cr>
noremap <leader>s :source ~/.config/nvim/init.vim<cr>
noremap <leader>x :bdelete<cr>
noremap <leader>h :Helptags<cr>
noremap <leader><leader> :Commands<cr>
noremap <leader>f :Files<cr>
noremap <leader>t :Tags<cr>
noremap <leader>b :Buffers<cr>
nmap <leader>P <Plug>(Prettier)

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  autocmd BufNewFile,BufRead *.md set ft=markdown
  autocmd BufNewFile,BufRead *.markdown set ft=markdown
  autocmd FileType vimwiki let b:auto_save = 0
  autocmd BufWritePost *.wiki execute '!task sync'
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
  endfunction
endif

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

if exists('g:started_by_firenvim')
  set guifont=FiraMono\ Nerd\ Font\ Mono:h11
  set nonumber
  let g:loaded_airline = 1
else
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_theme='base16_chalk'
  let g:airline_powerline_fonts = 1
endif
