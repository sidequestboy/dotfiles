"mappings here override plugin mappings

nnoremap ; :

nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>l :ls<cr>
nnoremap <leader>g :ls<cr>:b<Space>
nnoremap <leader>c :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>s :source ~/.config/nvim/init.vim<cr>:source ~/.config/nvim/after/plugin/mappings.vim<cr>
nnoremap <leader>x :bdelete<cr>
nnoremap <leader>h :Helptags<cr>
nnoremap <leader><Space> :Commands<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>t :ToggleWorkspace<cr>
nnoremap <leader>P <Plug>(Prettier)

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

