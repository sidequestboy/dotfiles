"mappings here override plugin mappings

nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>ec :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>em :e ~/.config/nvim/after/plugin/mappings.vim<cr>
nnoremap <leader>d :bdelete<cr>
nnoremap <leader>H :Helptags<cr>
nnoremap <leader>m :Maps<cr>
nnoremap <leader>N :new \| only<cr>
nnoremap <leader>g :Buffers<cr>
"nnoremap <leader>g :ls<cr>:b<Space>
nnoremap <leader>f :Files<cr>
nnoremap <leader>c :Commands<cr>
nnoremap <leader>t :ToggleWorkspace<cr>
nnoremap <leader>P <Plug>(Prettier)
nnoremap <leader>I :PlugInstall<cr>
nnoremap <leader>s :s/
nnoremap Q <nop>

nnoremap <F5> :source ~/.config/nvim/init.vim<cr>:source ~/.config/nvim/after/plugin/mappings.vim<cr>

"insert mode undo
inoremap <C-R> <C-G>u<C-R>
inoremap <C-Z> <C-O>u

"terminal
tnoremap <Esc> <C-\><C-n>

"tmux navigation
nnoremap <silent> <A-h> :TmuxResizeLeft<CR>
nnoremap <silent> <A-j> :TmuxResizeDown<CR>
nnoremap <silent> <A-k> :TmuxResizeUp<CR>
nnoremap <silent> <A-l> :TmuxResizeRight<CR>

inoremap <silent> <C-l> <C-o>:TmuxNavigateRight<cr>
inoremap <silent> <C-h> <C-o>:TmuxNavigateLeft<cr>
inoremap <silent> <C-j> <C-o>:TmuxNavigateDown<cr>
inoremap <silent> <C-k> <C-o>:TmuxNavigateUp<cr>

tmap <C-l> <C-\><C-n><C-l>
tmap <C-h> <C-\><C-n><C-h>
tmap <C-k> <C-\><C-n><C-k>
tmap <C-j> <C-\><C-n><C-j>

tnoremap <silent> <A-l> <C-\><C-n>:TmuxResizeRight<cr>
tnoremap <silent> <A-j> <C-\><C-n>:TmuxResizeDown<cr>
tnoremap <silent> <A-k> <C-\><C-n>:TmuxResizeUp<cr>
tnoremap <silent> <A-h> <C-\><C-n>:TmuxResizeLeft<cr>

" explicitly give sneak priority on this map over surround.
" could also just load sneak first, but explicit is better.
xmap S <Plug>Sneak_S
" replace surround function with this.
xmap <leader>s <Plug>VSurround

