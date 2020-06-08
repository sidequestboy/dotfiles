"Global Variables {{{1
"see after/plugin/mappings.vim for maps
let mapleader='-'
let maplocalleader='\\'

"colours
hi folded ctermbg=NONE
hi statusline cterm=bold
hi statuslinenc cterm=NONE
hi vertsplit cterm=NONE ctermfg=black

"defaults
set expandtab
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set mouse=a
set nohls
set number
set splitbelow
set splitright
set sw=4
set ts=4
set undodir=$XDG_CONFIG_HOME/nvim/undo
set undofile
set noshowmode
set clipboard=unnamedplus

highlight SneakScope ctermfg=black ctermbg=red
highlight Sneak ctermfg=black ctermbg=red

let g:netrw_banner = 0
let g:netrw_liststyle = 3

"Plugin Configuration {{{1
" install vim-plug if not installed {{{2
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
"2}}

"plugin manager
Plug 'junegunn/vim-plug'

"utility
Plug 'unblevable/quick-scope'
Plug 'christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'
Plug '907th/vim-auto-save'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'chemzqm/denite-extra'
Plug 'glacambre/firenvim', {
  \ 'branch': 'master',
  \ 'do': 'npm install && npm run build && npm run install_manifests' }
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
  let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
  let g:airline_exclude_filenames = [ 'term://' ]
  let g:airline_exclude_filetypes = [ 'noairline' ]
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  "let g:airline_theme='base16_chalk'
  let g:airline_theme='base16'
  let g:airline_powerline_fonts = 1
endif
"2}}}
Plug 'farmergreg/vim-lastplace'
Plug 'justinmk/vim-sneak'
Plug 'jpalardy/vim-slime'
"options {{{2
let g:slime_target = "tmux"
let g:slime_paste_file = "$XDG_CONFIG_HOME/slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
"{{{2
Plug 'lambdalisue/suda.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-obsession'
Plug 'thaerkh/vim-workspace'
Plug 'markonm/traces.vim'

"eye candy
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'

"organization
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'tbabej/taskwiki'
Plug 'jceb/vim-orgmode'

"programming
Plug 'vitalk/vim-shebang'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'neomake/neomake'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

let g:auto_save = 1

let g:session_dir= $XDG_CONFIG_HOME . '/nvim/sessions'
let g:workspace_session_directory = $XDG_CONFIG_HOME . '/nvim/sessions/'
let g:workspace_create_new_tabs = 0
let g:workspace_autosave_always = 1

let g:tmux_resizer_no_mappings = 1

highlight HorizSplit ctermbg=NONE ctermfg=NONE



"Autocommands{{{1
augroup autocmds
  autocmd!
  autocmd BufNewFile,BufRead *.md set ft=markdown
  autocmd BufNewFile,BufRead *.markdown set ft=markdown
  autocmd BufNewFile,BufRead *.service* set ft=systemd
  autocmd FileType vimwiki let b:auto_save = 0
  autocmd BufWritePost *.wiki execute '!task sync'
  "autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber bufhidden=hide modified
  autocmd BufEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert | set statusline=%#Normal#
  autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
  autocmd FileType denite call s:denite_my_settings()
  autocmd BufEnter * if &ft ==# 'help' | wincmd o | endif
  autocmd BufEnter * if &ft ==# 'help' | nnoremap u <C-u> | nnoremap d <C-d> | endif
augroup end
highlight QuickScopePrimary cterm=bold
highlight QuickScopeSecondary cterm=bold
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary ctermfg=80 cterm=bold
  autocmd ColorScheme * highlight QuickScopeSecondary ctermfg=83 cterm=bold
augroup END

" vim: set ts=2 sw=2 expandtab:
