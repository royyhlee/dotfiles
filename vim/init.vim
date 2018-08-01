" Settings
set history=500
set expandtab
set smarttab " Be smart when using tabs ;)
set shiftwidth=2
set tabstop=2
set ai   " Auto Indent
set si   " Smart Indent
set wrap " Wrap lines
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning

" Key map
let mapleader="\<Space>"
inoremap jk <esc>
map <silent> <leader><cr> :noh<cr>
map <leader>w :wa<cr>
map <leader>q :q<cr>
map <leader>Q :qa<cr>

" Tab Select
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Split Movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Scroll
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Quickfix
nnoremap <leader>; :ll<CR>

" Tab
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Enable syntax highlighting
syntax enable

" Editor line number
set number

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')

" Language
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tern'
Plug 'jason0x43/vim-js-indent'
Plug 'cakebaker/scss-syntax.vim'
Plug 'herringtondarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'Quramy/vim-js-pretty-template'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'airblade/vim-gitgutter'
Plug 'chiel92/vim-autoformat'
" Plug 'palantir/tslint'
" Plug 'neomake/neomake'
" Plug 'valloric/matchtagalways'
" Plug 'jason0x43/vim-tss', { 'for': [ 'typescript', 'javascript' ], 'do': 'npm install'}
" Plug 'w0rp/ale'

" VIM
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" ETC
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'

" Theme
Plug 'agude/vim-eldar'
Plug 'vim-airline/vim-airline'
" Plug 'rakr/vim-one'
" Plug 'junegunn/seoul256.vim'
" Plug 'flazz/vim-colorschemes'
" Plug 'reedes/vim-colors-pencil'
" Plug 'liuchengxu/space-vim-dark'
" Plug 'zanglg/nova.vim'
" Plug 'ayu-theme/ayu-vim'
" Plug 'ayu-theme/ayu-vim-airline'
" Plug 'nightsense/seabird'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'notpratheek/vim-luna'
" Plug 'lifepillar/vim-wwdc17-theme'
" Plug 'roosta/vim-srcery'
" Plug 'lu-ren/SerialExperimentsLain'

call plug#end()

" NCM2
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone 

" Easy Align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF
map <silent> <leader>o :FZF<cr>
map <silent> <leader>f :Ag<cr>
map <silent> <leader>F :Ag!<cr>

let g:fzf_command_prefix = 'Fzf'
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '`'),
            \                 <bang>0)

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
            \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" vim-js-indent
let js_indent_typescript = 1

" Airline
let g:airline_powerline_fonts = 1

" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 50
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>n :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>

" NERDCommenter
let g:NERDSpaceDelims = 1

" NVM Completion Manager
autocmd BufEnter * call ncm2#enable_for_buffer()

" Eldar
colo eldar

" LanguageClient
"
augroup LanguageClient_config
  autocmd!
  " Discard all errors in the QuickFix window if the language server stops or crashes
  autocmd User LanguageClientStopped call setqflist([])
augroup end

let g:LanguageClient_serverCommands = {
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ }
let g:LanguageClient_diagnosticsDisplay = {
    \     1: {
    \         "name": "Error",
    \         "texthl": "ErrorMsg",
    \         "signText": "✖",
    \         "signTexthl": "ErrorMsg",
    \     },
    \     2: {
    \         "name": "Warning",
    \         "texthl": "WarningMsg",
    \         "signText": "?",
    \         "signTexthl": "WarningMsg",
    \     },
    \     3: {
    \         "name": "Information",
    \         "texthl": "ALEInfo",
    \         "signText": "i",
    \         "signTexthl": "ALEInfoSign",
    \     },
    \     4: {
    \         "name": "Hint",
    \         "texthl": "ALEInfo",
    \         "signText": ">",
    \         "signTexthl": "ALEInfoSign",
    \     },
    \ }
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_changeThrottle = 0.5
nnoremap <silent><leader>i :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent><leader>g :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
nnoremap <silent><leader>G :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent><leader>k :call LanguageClient#textDocument_references()<CR>
nnoremap <silent><leader>m :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent><leader>l :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent><leader>p :call LanguageClient#textDocument_hover()<CR>

" Auto Format
let g:formatdef_custom_html = '"js-beautify --html -A force-aligned -s 2"'
let g:formatters_html = ['custom_html']
autocmd FileType html nnoremap<buffer> <leader>l :Autoformat<CR>
"let g:formatdef_custom_tsfmt = \"'tsfmt --useTsfmt ~/.config/vim_plugin/tsfmt.json --stdin '.bufname('%')"

" Seoul256
" let g:airline_theme='seoul256'
" let g:seoul256_background = 238
" let g:seoul256_light_background = 252
" colo seoul256
" colo seoul256-light

" Luna
" let g:airline_theme='luna'
" colo luna

" Seabird
" colo greygull

" SerialExperimentsLain
" colo SerialExperimentsLain

" Nova 
" let g:airline_theme='nova'
" colo nova

" wwdc17
" colo wwdc17
" let g:wwdc17_term_italics = 0
" let g:wwdc17_frame_color = 2

" Srcery
" colo srcery

" PaperColor
" set background=light
" let g:airline_theme='pencil'
" let g:PaperColor_Theme_Options = {
  " \   'theme': {
  " \     'default': { 
  " \       'allow_bold': 0,
  " \       'allow_italic': 0
  " \     }
  " \   }
  " \ }

" colorscheme PaperColor
" let g:space_vim_dark_background = 236
" colo space-vim-dark

" Ayu
" let ayucolor="light" " for mirage version of theme
" colorscheme ayu

" Pencil
" let g:pencil_higher_contrast_ui = 1   " 0=low (def), 1=high
" let g:pencil_neutral_code_bg = 0   " 0=gray (def), 1=normal
" let g:pencil_gutter_color = 1
" colo pencil

