set relativenumber
set number
set formatoptions-=cro
set mouse=a
set numberwidth=1
set ruler
set encoding=utf-8
set laststatus=0
set smartindent
set autoindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set showtabline=4
set hidden
set fileencoding=utf-8 
set splitbelow
set splitright
set background=dark
set autochdir
syntax enable
filetype on
filetype indent on
filetype plugin on

colorscheme ron

highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight EndOfBuffer guibg=none ctermbg=none

" Keymaps
let mapleader=" "

nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>sq :q!<CR>

inoremap jk <ESC>

nnoremap <leader>y "+y
vnoremap <leader>y "+y

nnoremap <leader>p "+p
vnoremap <leader>p "+p

syntax on

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
  set termguicolors
endif
