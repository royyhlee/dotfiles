" Plugins ======================================================================
call plug#begin()

" Plugins
" Plug 'mhartington/formatter.nvim'
" Plug 'sbdchd/neoformat'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'ggandor/lightspeed.nvim', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'nathom/filetype.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jeetsukumaran/vim-filebeagle'

" Theme
" Plug 'junegunn/seoul256.vim'
" Plug 'ajmwagar/vim-deus'
" Plug 'flrnprz/candid.vim'
" Plug 'agude/vim-eldar'
" Plug 'morhetz/gruvbox'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'lifepillar/vim-solarized8'
" Plug 'arzg/vim-colors-xcode'
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'relastle/bluewery.vim'

call plug#end()

" LSP Config

set completeopt=menu,menuone,noselect

lua << EOF
require("trouble").setup {}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
-- vim.opt.completeopt = {'noinsert', 'menuone', 'noselect'}
-- vim.api.nvim_command('inoremap <C-j> <C-x><C-o>')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>c', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>l', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', "<Leader>i", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

end

local nvim_lsp = require('lspconfig')
local servers = { 'jsonls', 'cssls', 'tsserver', 'html', 'angularls' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup{    
    on_attach = on_attach,
    capabilities = capabilities
  }
end

EOF

" Color Scheme =================================================================

if has("termguicolors") 
  set termguicolors
endif

" colo eldar

" colo bluewery
" let g:lightline = { 'colorscheme': 'bluewery' }

" colo bluewery-light
" let g:lightline = { 'colorscheme': 'bluewery_light' }

"""""" tokyonight
let g:tokyonight_style = "night"
let g:lightline = {'colorscheme': 'tokyonight'}
colo tokyonight

"""""" Deus
" colo deus

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

" hi guicursor guifg=red ctermfg=red

" hi DiffChange guifg=yellow  ctermfg=yellow
" hi DiffAdd    guifg=#00fb00 
" hi DiffDelete guifg=red     ctermfg=red
" hi SignColumn guibg=#E1E1E1
" " ctermfg=#00fb00

" General ======================================================================
set number
set tw=100
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

" set foldmethod=syntax
" set foldlevelstart=1

" let typescript_fold=1

" filetype plugin on
" filetype indent on

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
nnoremap <leader>O :Buffers<cr>
nnoremap <leader>o :FZF<cr>
nnoremap <silent> <Leader>f :Ag<cr>

nnoremap <silent> <leader>L :call CocAction('format')<cr>

