" Basic settings
syntax on
set number
set relativenumber

" Centralize swap files to avoid polluting projects (// ensures unique names via full path)
silent! call mkdir(expand('~/.local/state/vim/swap'), 'p')
set directory=~/.local/state/vim/swap//

" Leader key configuration
let mapleader = " "

" Fast escape to normal mode
inoremap jk <Esc>

" Fast save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Mode-dependent cursor shape (beam in Insert mode, block in Normal mode)
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
else
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

" Differentiated system clipboard access
if has('clipboard')
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>Y "+Y
  nnoremap <leader>p "+p
  vnoremap <leader>p "+p
  nnoremap <leader>P "+P
else
  " Fallback for terminal Vim builds without +clipboard (standard Arch Linux vim package)
  if executable('wl-copy')
    function! s:ClipYankOp(type) abort
      let l:reg_save = @@
      if a:type ==# 'line'
        silent exe "normal! '[V']y"
      else
        silent exe "normal! `[v`]y"
      endif
      call system('wl-copy', @@)
      let @@ = l:reg_save
    endfunction

    nnoremap <silent> <leader>y :set opfunc=<SID>ClipYankOp<CR>g@
    nnoremap <silent> <leader>Y :call system('wl-copy', getline('.'))<CR>
    vnoremap <silent> <leader>y y:call system('wl-copy', @@)<CR>
  endif

  if executable('wl-paste')
    function! s:ClipPaste(cmd) abort
      let l:clip = system('wl-paste --no-newline')
      let l:reg_save = @@
      let @@ = l:clip
      silent exe 'normal! ' . a:cmd
      let @@ = l:reg_save
    endfunction

    nnoremap <silent> <leader>p :call <SID>ClipPaste('p')<CR>
    nnoremap <silent> <leader>P :call <SID>ClipPaste('P')<CR>
    vnoremap <silent> <leader>p c<C-r>=system('wl-paste --no-newline')<CR><Esc>
  endif
endif
