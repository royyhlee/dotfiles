" Plugins ======================================================================
call plug#begin()

" Plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jeetsukumaran/vim-filebeagle'

" Theme
Plug 'junegunn/seoul256.vim'
Plug 'ajmwagar/vim-deus'
Plug 'flrnprz/candid.vim'
Plug 'agude/vim-eldar'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'lifepillar/vim-solarized8'
Plug 'arzg/vim-colors-xcode'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

call plug#end()

" Color Scheme =================================================================

" if has("termguicolors") 
"   set termguicolors
" endif

colo eldar

"""""" Deus
" colo deus

"""""" Challenger Deep
" let g:lightline = { 'colorscheme': 'challenger_deep' }
" colo challenger_deep

"""""" XCODE
" colo xcodelight

"""""" Gruvbox
" let g:gruvbox_sign_column='bg0'
" let g:lightline = { 'colorscheme': 'gruvbox' }
" set background=dark
" colo gruvbox

"""""" Seoul256
" let g:lightline = { 'colorscheme': 'seoul256' }
" colo seoul256
" set background=light

hi DiffChange guifg=yellow  ctermfg=yellow
" hi DiffAdd    guifg=#00fb00 
hi DiffDelete guifg=red     ctermfg=red
" hi SignColumn guibg=#E1E1E1
" " ctermfg=#00fb00

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

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

nnoremap <leader>q :q<cr>
nnoremap <leader>w :wa<cr>
nnoremap <leader>W :w<cr>
nnoremap <leader>d :BD<cr>
nnoremap <leader>D :bd<cr>
nnoremap <leader>r :e!<cr>
nnoremap <leader>n :FileBeagle<cr>
nnoremap <leader>s :set spell! spelllang=en_us<cr>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <silent> <leader>ve :tabnew $MYVIMRC<cr>
nnoremap <silent> <leader>vs :source $MYVIMRC<cr>

nnoremap <silent> <leader><cr> :nohlsearch<cr>

nnoremap ]g gt
nnoremap [g gT

" FileBeagle ===================================================================
let g:filebeagle_suppress_keymaps = 1
map <silent> -         <Plug>FileBeagleOpenCurrentBufferDir

" Exit Terminal
tnoremap <Esc> <C-\><C-n>:q!<CR>

" Fugitive =====================================================================
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gs :G<cr>
nnoremap <leader>gw :Gwrite<cr>

" Easy Align ===================================================================
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF ==========================================================================
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

function! s:format_buffer(b)
  let l:name = bufname(a:b)
  return printf("%s\t%s", a:b, empty(l:name) ? '[No Name]' : fnamemodify(l:name, ":p:~:."))
endfunction

command! BD call fzf#run(fzf#wrap({
      \ 'source': map(
      \   filter(
      \     range(
      \       1,
      \       bufnr('$')
      \     ),
      \     {_, nr -> buflisted(nr) && getbufvar(nr, "&filetype") != "qf" && !getbufvar(nr, "&modified")}
      \   ),
      \   {_, nr -> s:format_buffer(nr)}
      \ ),
      \ 'sink*': { lines -> execute('bwipeout '.join(map(lines, {_, line -> split(line)[0]}))) },
      \ 'options': '--multi -d \t --bind ctrl-a:select-all+accept'
      \ }))
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <leader>e :Buffers<cr>
nnoremap <leader>o :FZF<cr>
nnoremap <silent> <Leader>f :Ag<cr>

" Conquer of Completion ========================================================
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

