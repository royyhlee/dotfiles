" Plugins ====================================================================
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'agude/vim-eldar'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Color Scheme ================================================================
colo eldar 

hi GitGutterAdd    ctermfg=green
hi GitGutterChange ctermfg=yellow
hi GitGutterDelete ctermfg=red
" hi ALEErrorSign    ctermfg=red
" hi ALEError        cterm=undercurl guisp=red
" hi ALEInfoSign     ctermfg=yellow

" General =====================================================================
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

nnoremap <leader>q :wq<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>W :w<cr>
nnoremap <leader>z :bd<cr>
nnoremap <leader>r :NERDTreeFind<cr>
nnoremap <leader>n :NERDTreeToggle<cr>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <leader>ve :tabnew $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

nnoremap <silent> <leader><cr> :nohlsearch<cr>

nnoremap ]g gt
nnoremap [g gT

" Fugitive ====================================================================
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>

" NERD Tree ===================================================================
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 80

" Easy Align ==================================================================
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF =========================================================================
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)
nnoremap <leader>e :Buffers<cr>
nnoremap <leader>o :FZF<cr>
nnoremap <leader>f :Ag<cr>

" Conquer of Completion =======================================================
let g:coc_node_path="/home/royyhlee/.nvm/versions/node/v8.16.0/bin/node"
nmap <leader>i <Plug>(coc-codeaction)
nnoremap <leader>l :call CocAction('format')<cr>
nnoremap <leader>h :call CocAction('jumpDefinition')<cr>
nnoremap <leader>p :call CocAction('doHover')<cr>
nnoremap <leader>k :call CocAction('jumpReferences')<cr>
nnoremap <leader>m :call CocAction('rename')<cr>

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

