syntax on

set tabstop=2

set shiftwidth=2

set softtabstop=2

set expandtab

set ai

set number

set hlsearch

set ruler


set background=dark
colorscheme peachpuff

colorscheme mycolorscheme

vnoremap <C-S-Up>   :m '<-2<CR>gv=gv
vnoremap <C-S-Down> :m '>+1<CR>gv=gv

"if there's a problem with 4 spaces indent in python
"go to /usr/share/vim/vim82/ftplugin/python.vim
"and change all 4 to 2

set indentexpr=GetPythonIndent()
function GetPythonIndent()
   return indent(".") . substitute(getline(v:lnum - 1),
'^\s*\zs#\([# ]*\)\=', '', '')
endfunction
