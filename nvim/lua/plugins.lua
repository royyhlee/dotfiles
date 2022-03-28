vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- FZF
  use { "junegunn/fzf", run = ":call fzf#install()" }
  use 'junegunn/fzf.vim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Color
  use 'folke/tokyonight.nvim'

  -- File explorer
  -- use 'kyazdani42/nvim-tree.lua'
  use 'jeetsukumaran/vim-filebeagle'

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- Surround
  use 'tpope/vim-surround'

  -- Autopair
  use 'jiangmiao/auto-pairs'

  -- Lightspeed
  use 'ggandor/lightspeed.nvim'

  -- Git Gutter
  use 'airblade/vim-gitgutter'

  -- Close Tag
  use 'alvan/vim-closetag'

  -- Commentary
  use 'tpope/vim-commentary'

  -- Fugitive
  use 'tpope/vim-fugitive'
end)
