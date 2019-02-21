set number
set tw=79
set hidden
set tabstop=2
set shiftwidth=2
set updatetime=100
set expandtab
set si
set ignorecase
set smartcase
set lazyredraw
set showmatch

filetype plugin on
filetype indent on

let mapleader = "\<space>"

inoremap jk <esc>

nnoremap <leader>w :wa<cr>
nnoremap <leader>W :w<cr>
nnoremap <leader>z :bd<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>r :Explore<cr>
nnoremap <leader>R :Ve<cr>

" Scroll
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <leader>ve :tabnew $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

nnoremap <silent> <leader><cr> :nohlsearch<cr>

nnoremap ]g gt
nnoremap [g gT

call plug#begin()

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'agude/vim-eldar'
Plug 'itchyny/lightline.vim'

" Easy Align ==================================================================
Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Autoformat ==================================================================
Plug 'chiel92/vim-autoformat'
let g:formatdef_custom_html = '"js-beautify --html -A force-aligned -s 2"'
let g:formatters_html = ['custom_html']
autocmd FileType html,scss nnoremap<buffer> <leader>l :Autoformat<CR>

" Deoplete ====================================================================
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" FZF =========================================================================
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%'),
  \                 <bang>0)
nnoremap <leader>e :Buffers<cr>
nnoremap <leader>o :FZF<cr>
nnoremap <leader>f :Ag<cr>

" Language Client =============================================================
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_serverCommands = {
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'scss': ['css-languageserver', '--stdio'],
    \ }
nnoremap <leader>i :call LanguageClient#textDocument_codeAction()<cr>
nnoremap <leader>l :call LanguageClient#textDocument_formatting()<cr>
nnoremap <leader>g :call LanguageClient#textDocument_definition()<cr>
nnoremap <leader>p :call LanguageClient#textDocument_hover()<cr>
nnoremap <leader>k :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>m :call LanguageClient#textDocument_rename()<CR>

call plug#end()

colo eldar 

" Highlight
hi GitGutterAdd    ctermfg=green
hi GitGutterChange ctermfg=yellow
hi GitGutterDelete ctermfg=red
hi ALEErrorSign    ctermfg=red
hi ALEError        cterm=undercurl guisp=red
hi ALEInfoSign     ctermfg=yellow


