require("user.plugins")

-- use space as a the leader key
vim.g.mapleader = ' '

-- Set the behavior of tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Indentation
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
  trail = '·',
	  tab = '!·',  
}

-- Scrolling
vim.opt.scrolloff = 8

-- Telescope
local map = require("user.utils").map

map("n", "<Leader>ff", ":lua require('user.telescope-config').project_files()<CR>")
map("n", "<Leader>fa", ":lua require('telescope.builtin').find_files()<CR>")
map("n", "<Leader>fg", ":lua require('telescope.builtin').live_grep()<CR>")

