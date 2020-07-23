" Vim color file
" Theme: zmar
" Author: Zach Marcantel <zmarcantel@gmail.com>

hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256
let g:colors_name = "zmar"


" Define reusable colorvariables.
let s:bg="#222222"
let s:fg="#EBDBB2"
let s:fg2="#d8c9a4"
let s:fg3="#c5b896"
let s:fg4="#b3a687"
let s:bg2="#343434"
let s:bg3="#454545"
let s:bg4="#575757"
let s:keyword="#FE8019"
let s:builtin="#458588"
let s:const= "#FABD2F"
let s:comment="#928374"
let s:func="#cacaca"
let s:str="#8EC07C"
let s:type="#D3869B"
let s:var="#eeeeee"
let s:warning="#FB4934"
let s:warning2="#FE8019"

exe 'hi Normal guifg='s:fg' guibg='s:bg 
exe 'hi Cursor guifg='s:bg' guibg='s:fg 
exe 'hi CursorLine  guibg='s:bg2 
exe 'hi CursorColumn  guibg='s:bg2 
exe 'hi ColorColumn  guibg='s:bg2 
exe 'hi LineNr guifg='s:fg2' guibg='s:bg2 
exe 'hi VertSplit guifg='s:fg3' guibg='s:bg3 
exe 'hi MatchParen guifg='s:warning2'  gui=underline'
exe 'hi StatusLine guifg='s:fg2' guibg='s:bg3' gui=bold'
exe 'hi Pmenu guifg='s:fg' guibg='s:bg2
exe 'hi PmenuSel  guibg='s:bg3 
exe 'hi IncSearch guifg='s:bg' guibg='s:keyword 
exe 'hi Search   gui=underline'
exe 'hi Directory guifg='s:const  
exe 'hi Folded guifg='s:fg4' guibg='s:bg 

exe 'hi Boolean guifg='s:const  
exe 'hi Character guifg='s:const  
exe 'hi Comment guifg='s:comment  
exe 'hi Conditional guifg='s:keyword  
exe 'hi Constant guifg='s:const  
exe 'hi Define guifg='s:keyword  
exe 'hi DiffAdd guifg=#fafafa guibg=#123d0f gui=bold'
exe 'hi DiffDelete guibg='s:bg2  
exe 'hi DiffChange  guibg=#151b3c guifg=#fafafa'
exe 'hi DiffText guifg=#ffffff guibg=#ff0000 gui=bold'
exe 'hi ErrorMsg guifg='s:warning' guibg='s:bg2' gui=bold'
exe 'hi WarningMsg guifg='s:fg' guibg='s:warning2 
exe 'hi Float guifg='s:const  
exe 'hi Function guifg='s:func  
exe 'hi Identifier guifg='s:type'  gui=italic'
exe 'hi Keyword guifg='s:keyword'  gui=bold'
exe 'hi Label guifg='s:var
exe 'hi NonText guifg='s:bg4' guibg='s:bg2 
exe 'hi Number guifg='s:const  
exe 'hi Operater guifg='s:keyword  
exe 'hi PreProc guifg='s:keyword  
exe 'hi Special guifg='s:fg  
exe 'hi SpecialKey guifg='s:fg2' guibg='s:bg2 
exe 'hi Statement guifg='s:keyword  
exe 'hi StorageClass guifg='s:type'  gui=italic'
exe 'hi String guifg='s:str  
exe 'hi Tag guifg='s:keyword  
exe 'hi Title guifg='s:fg'  gui=bold'
exe 'hi Todo guifg='s:fg2'  gui=inverse,bold'
exe 'hi Type guifg='s:type 
exe 'hi Underlined   gui=underline'

" Python Highlighting
exe 'hi pythonBuiltinFunc guifg='s:builtin

" Go Highlighting
exe 'hi goBuiltins guifg='s:builtin

" Markdown Highlighting
exe 'hi mkdCode guifg='s:builtin
