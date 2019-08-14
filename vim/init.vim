" Plugins ======================================================================
call plug#begin()

" Theme
Plug 'noahfrederick/vim-hemisu'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-vividchalk'
Plug 'noahfrederick/vim-noctu'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'ajmwagar/vim-deus'
Plug 'flrnprz/candid.vim'
Plug 'agude/vim-eldar'
Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'qpkorr/vim-bufkill'
call plug#end()

" Color Scheme =================================================================

" if has("termguicolors") 
"   set termguicolors
" endif

colo eldar

hi GitGutterAdd    guifg=green  ctermfg=green
hi GitGutterChange guifg=yellow ctermfg=yellow
hi GitGutterDelete guifg=red    ctermfg=red

" General ======================================================================
set number
set tw=80
set cc=+1
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

nnoremap <leader>q :q<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>W :w<cr>
nnoremap <leader>z :BD<cr>
nnoremap <leader>E :e!<cr>
nnoremap <leader>n :Dirvish<cr>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <silent> <leader>ve :tabnew $MYVIMRC<cr>
nnoremap <silent> <leader>vs :source $MYVIMRC<cr>

nnoremap <silent> <leader><cr> :nohlsearch<cr>

nnoremap ]g gt
nnoremap [g gT

" Nerd Commenter
let g:NERDSpaceDelims = 1

" Exit Terminal
tnoremap <Esc> <C-\><C-n>:q!<CR>

" Fugitive =====================================================================
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>

" Easy Align ===================================================================
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF ==========================================================================
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)
nnoremap <leader>e :Buffers<cr>
nnoremap <leader>o :FZF<cr>
nnoremap <leader>f :Ag<cr>

" Conquer of Completion ========================================================
let g:coc_node_path="/home/royyhlee/.nvm/versions/node/v10.16.2/bin/node"
set updatetime=300
set cmdheight=2
nmap     <silent> <leader>i <Plug>(coc-codeaction)
nnoremap <silent> <leader>l :call CocAction('format')<cr>
nnoremap <silent> <leader>h :call CocAction('jumpDefinition')<cr>
nnoremap <silent> <leader>p :call CocAction('doHover')<cr>
nnoremap <silent> <leader>k :call CocActionAsync('jumpReferences')<cr>
nnoremap <silent> <leader>m :call CocAction('rename')<cr>

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

