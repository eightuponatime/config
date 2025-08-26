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

call plug#begin()
  Plug 'vim-crystal/vim-crystal'
  Plug 'ziglang/zig.vim'
call plug#end()

colorscheme peachpuff
"highlight Normal ctermbg = 234

vnoremap <C-S-Up>   :m '<-2<CR>gv=gv
vnoremap <C-S-Down> :m '>+1<CR>gv=gv

"if there's a problem with 4 spaces indent in python
"go to /usr/share/vim/vim82/ftplugin/python.vim
"and change all 4 to 2

function! GetPythonIndent()
   return indent(".") . substitute(getline(v:lnum - 1), '^\s*\zs#\([# ]*\)\=', '', '')
endfunction
augroup python_settings
  autocmd!
  autocmd FileType python setlocal indentexpr=GetPythonIndent()
augroup END
set mouse=a

let g:solarized_termcolors=256
set t_Co=256

highlight Comment ctermfg = green

augroup cpp_settings
  autocmd!
  autocmd FileType cpp setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2 cindent cinoptions=t0
augroup END

" how to disable 4 space formatting in zig plugin:
" cd ~/.vim/plugged/zig.vim/ftplugin
" in zig.vim find lines and set values to 2
"   -> setlocal softtabstop=2
"   -> setlocal shiftwidth=2
" then disable autoformatting by 4 space indent rules with command:
let g:zig_fmt_autosave = 0
