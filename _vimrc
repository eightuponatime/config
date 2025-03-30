map <C-S-v> <S-Insert>  

set backspace=indent,eol,start

syntax on

set tabstop=2

set shiftwidth=2

set expandtab

set ai

set number

set hlsearch

set ruler

highlight Comment ctermfg=green

set background=light

"colorscheme vacme

set nocompatible

set guicursor=n-v-c-i:block-Cursor

set visualbell
set t_vb=

"py indent settings:
aug python
    " ftype/python.vim overwrites this
    au FileType python setlocal expandtab ts=2 sts=2 sw=2
aug end

set cinoptions=(2,m1

set mouse=a

aug rust
  au FileType rust setlocal expandtab ts=2 sts=2 sw=2
aug end
