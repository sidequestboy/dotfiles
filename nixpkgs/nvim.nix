{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      {
        plugin = vim-pug;
        config = ''
          augroup pug
            autocmd!
            autocmd FileType pug setlocal shiftwidth=2 softtabstop=2 expandtab
          augroup END
        '';
      }
      vim-airline
      {
        plugin = vim-airline-themes;
        config = "let g:airline_theme='base16_gruvbox_dark_hard'";
      }
      {
        plugin = vim-gitgutter;
        config = ''
          highlight! link SignColumn LineNr
          set updatetime=100
        '';
      }
      coc-nvim
      {
        plugin = goyo;
        config = ''
          function! s:goyo_enter()
            if executable('tmux') && strlen($TMUX)
              silent !tmux set status off
              silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
            endif
            set noshowmode
            set noshowcmd
            set scrolloff=999
            " ...
          endfunction

          function! s:goyo_leave()
            if executable('tmux') && strlen($TMUX)
              silent !tmux set status on
              silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            endif
            set showmode
            set showcmd
            set scrolloff=5
            " ...
          endfunction

          autocmd! User GoyoEnter nested call <SID>goyo_enter()
          autocmd! User GoyoLeave nested call <SID>goyo_leave()

        '';
      }
    ];
    extraConfig = ''
      let mapleader = ","
      nnoremap <leader>g :Goyo<cr>

      augroup javascript
        autocmd!
        autocmd BufNewFile,BufRead *.js set ft=javascript
        autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
      augroup END

      augroup markdown
        autocmd!
        autocmd BufNewFile,BufRead *.md set ft=markdown
        autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
      augroup END

      "last position
      augroup lastposition
        autocmd!
        autocmd BufWinLeave *.* mkview
        autocmd BufWinEnter *.* silent! loadview
      augroup END
    '';
    coc = {  };

    vimAlias = true;
  };
}
