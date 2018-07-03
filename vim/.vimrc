set nocompatible
filetype off

" include the Vundle 'header'
source ~/.vim_includes

set rtp+=~/.vim


"**********************************************************
" Look and feel
"**********************************************************
set cul
set cuc
set number

set t_Co=256
syntax on
color zach


"**********************************************************
" Leader setup
"**********************************************************

" set leader to <Space>
let mapleader = "\<Space>"

"**********************************************************
" Convenience aliases
"**********************************************************
:command W w
:command Wa wa
:command Q q
:command Qa qa

"***********************************************************
" Editing
"***********************************************************
set hlsearch
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

" global swap directory
if !isdirectory($HOME . '/.vim/swapfiles')
    call mkdir($HOME . "/.vim/swapfiles/", "p")
endif
set directory=$HOME/.vim/swapfiles/

" allow <leader><number> window switching
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

au BufNewFile,BufRead *.less set filetype=less

"***********************************************************
" Language specific
"***********************************************************

" add doxygen support to all cpp and h files
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.cpp set filetype=cpp.doxygen
augroup END


" spell check markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" golang use goimports
let g:go_fmt_command = "goimports"
" allow older vims not generate warning (Fedora 18 has barely lower version)
let g:go_version_warning = 0

" enhanced c++ highlighting
let g:cpp_class_scope_highlight = 1

"***********************************************************
" Behavior
"***********************************************************
set visualbell
set t_vb=

set mouse=n

"***********************************************************
" NERDTree
"***********************************************************
let g:NERDTreeDirArrows=1
autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" cursor to file on open
autocmd VimEnter * NERDTree | wincmd p
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0
nmap <c-n> :NERDTreeToggle<CR>


"***********************************************************
" Syntastic
"***********************************************************
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"***********************************************************
" CtrlP
"***********************************************************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"***********************************************************
" Arista
"***********************************************************

" Include the system settings
:if filereadable( "/etc/vimrc" )
    source /etc/vimrc
:endif

" Include Arista-specific settings
:if filereadable( $VIM . "/vimfiles/arista.vim" )
    "source $VIM/vimfiles/arista.vim
:endif
