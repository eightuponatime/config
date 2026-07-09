" =========================
" Plugins
" =========================
call plug#begin('~/.vim/plugged')
call plug#end()


" =========================
" Basic Vim settings
" =========================
syntax on
filetype plugin indent on

set number
set ruler
set mouse=a
set hlsearch

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set background=light


" =========================
" True color support
" =========================
"if exists('+termguicolors')
"  set termguicolors
"endif

" =========================
" Copy and paste logic
" =========================
set clipboard=unnamedplus

" =========================
" Visual mode: move selected lines
" =========================
vnoremap <C-S-Up>   :m '<-2<CR>gv=gv
vnoremap <C-S-Down> :m '>+1<CR>gv=gv


" =========================
" Python indent settings
" =========================
function! GetPythonIndent()
  return indent(".") . substitute(getline(v:lnum - 1), '^\s*\zs#\([# ]*\)\=', '', '')
endfunction

augroup python_settings
  autocmd!
  autocmd FileType python setlocal indentexpr=GetPythonIndent()
augroup END


" =========================
" C++ indent settings
" =========================
augroup cpp_settings
  autocmd!
  autocmd FileType cpp setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2 cindent cinoptions=t0
augroup END


" =========================
" Zig settings
" =========================
let g:zig_fmt_autosave = 0


" =========================
" Optional custom highlights
" =========================
colorscheme mypeachpuff
highlight Comment ctermfg=green
