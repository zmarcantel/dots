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
if isdirectory('~/.vim/swapfiles')
    set directory=~/.vim/swapfiles/
endif

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
" Status Line
"***********************************************************

"hi plain term=bold cterm=bold ctermfg=White ctermbg=235
"hi green term=bold cterm=bold ctermfg=107 ctermbg=235 guifg=#799d6a
"hi orange term=bold cterm=bold ctermfg=215 ctermbg=235 guifg=#ffb964
"
"function! MyGitBranchStyle()
"    let branch = GitBranch()
"    if branch == ''
"        let branchStyle = ''
"    else
"        let branchStyle = branch
"    end
"    return branchStyle
"endfunction
"
"function! WindowNumber()
"    let str=tabpagewinnr(tabpagenr())
"    return str
"endfunction
"
"set laststatus=2
"set statusline=%#plain#%f\ [col:\ %#green#%c%#plain#]\ [line:\ %#green#%l%#plain#/%#orange#%L%#plain#]\ [win:\ %#green#%2{WindowNumber()}%#plain#]\ [branch:\ %#orange#%{MyGitBranchStyle()}%#plain#]

