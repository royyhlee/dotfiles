-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Map Esc to kk
map('i', 'jk', '<Esc>')

-- Don't use arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Fast saving with <leader> and s
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>W', ':wa<CR>')

-- Fast save & quit
map('n', '<leader>q', ':q<CR>')

-- Fast scrolling
map('n', '<C-e>', '3<C-e>')
map('n', '<C-y>', '3<C-y>')

-- Edit $MYVIMRC
map('n', '<leader>ve', ':tabnew $MYVIMRC<cr>')
map('n', '<leader>vs', ':source $MYVIMRC<cr>')

-- Tab switching
map('n', ']g', 'gt')
map('n', '[g', 'gT')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- NvimTree
map('n', '-', ':NvimTreeOpen %:p:h<CR>')              -- open
map('n', '<leader>r', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Vista tag-viewer
map('n', '<C-m>', ':Vista!!<CR>') -- open/close

-- FZF
map('n', '<leader>f', ':Ag<cr>')
map('n', '<leader>o', ':FZF<cr>')

-- Fugitive
map('n', '<leader>gb', ':Git blame<cr>')
map('n', '<leader>gs', ':G<cr>')
map('n', '<leader>gw', ':Gwrite<cr>')

-- Filebeagle
vim.g.filebeagle_suppress_keymaps = 1
vim.api.nvim_set_keymap('', '-', '<Plug>FileBeagleOpenCurrentBufferDir', { silent = true })
vim.api.nvim_set_keymap('', '_', '<Plug>FileBeagleOpenCurrentWorkingDir', { silent = true })
