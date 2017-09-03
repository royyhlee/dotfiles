" Sets how many lines of history VIM has to remember
set history=500

" Key map
let mapleader="\<Space>"
inoremap jk <esc>
map <silent> <leader><cr> :noh<cr>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tabs
set expandtab
set smarttab " Be smart when using tabs ;)
set shiftwidth=4
set tabstop=4

" Indent
set ai  " Auto Indent
set si  " Smart Indent
set wrap "Wrap lines

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

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



"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')

" Language
Plug 'jason0x43/vim-js-indent'
Plug 'cakebaker/scss-syntax.vim' 
Plug 'herringtondarkholme/yats.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'pangloss/vim-javascript'
Plug 'Quramy/vim-js-pretty-template'
Plug 'neomake/neomake'
Plug 'jason0x43/vim-tss', { 'for': [ 'typescript', 'javascript' ], 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'
Plug 'mhartington/nvim-typescript'
Plug 'valloric/matchtagalways'
"Plug 'scrooloose/syntastic'
"Plug 'leafgarland/typescript-vim'
"Plug 'Quramy/tsuquyomi'
"Plug 'w0rp/ale'

" VIM
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" ETC
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'

" Theme
Plug 'rakr/vim-one'
Plug 'flazz/vim-colorschemes'
Plug 'reedes/vim-colors-pencil'
Plug 'ayu-theme/ayu-vim'
Plug 'ayu-theme/ayu-vim-airline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" Easy Align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF
map <silent> <leader>o :FZF<cr>
map <silent> <leader>f :Ag<cr>

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
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
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

" Neomake
autocmd! BufWritePost * Neomake

" vim-js-indent
let js_indent_typescript = 0

" NVIM Typescript
map <silent> <leader>i :TSImport<cr>

" Typescript-vim
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow

" Airline
let g:airline_powerline_fonts = 1

" vim-tss
"let g:tss_auto_open_loclist = 1
let g:tss_completion_ignore_case = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_profile = 1
let g:deoplete#enable_debug = 1
let deoplete#tag#cache_limit_size = 5000000
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd CompleteDone * silent! pclose!

" NERDTree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>n :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>

" NERDCommenter
let g:NERDSpaceDelims = 1

" Theme
set background=light
colorscheme PaperColor
let g:airline_theme='papercolor'

" Ayu
"let ayucolor="dark" " for mirage version of theme
"colorscheme ayu

" Pencil
" let g:airline_theme='pencil'
" let g:pencil_higher_contrast_ui = 0   " 0=low (def), 1=high
" let g:pencil_neutral_code_bg = 0   " 0=gray (def), 1=normal
