vim.g.mapleader = ' '

vim.g.syntax = on
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ic = true 
vim.opt.smartcase = true

vim.opt.relativenumber = true
vim.opt.number = true

-- indentation
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- clipboard
vim.opt.clipboard = "unnamed"

-- undo
vim.opt.undodir = os.getenv("HOME") ..  "/.local/share/nvim/undodir"
vim.opt.undofile = true 

-- show matching brackets
vim.opt.showmatch = true 

-- mouse 
vim.opt.mouse = "a"

-- status line
vim.g.laststatus = 2
-- vim.g.statusline = "%#PmenuSel#\ %{FugitiveHead()}\ %#StatusLine#\ %f\ %m%=%y\ %l:%c\ "
vim.cmd([[set statusline=%#PmenuSel#\ %{FugitiveHead()}\ %#StatusLine#\ %f\ %m%=%y\ %l:%c\ ]])

vim.g.completeopt = "menu,menuone,noselect"
vim.opt.path:append("**")

vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")
