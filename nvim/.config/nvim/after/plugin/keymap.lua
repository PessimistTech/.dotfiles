local map = require('pessimisttech.keybind')
local nmap = map.nmap
local nnoremap = map.nnoremap
local vnoremap = map.vnoremap
local inoremap = map.inoremap

-- line numbers
nmap('<leader>nm', ':set rnu!')

-- git keybinds
nnoremap('<leader>gg', ':Git<CR>')
nnoremap('<leader>gp', ':Git push | :q<CR>')

-- keep centered
nnoremap('J', 'mzJ`z')
nnoremap('j', 'jzz')
nnoremap('k', 'kzz')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

-- moving lines
vnoremap('J', ":m '>+1<CR>gv=gv")
vnoremap('K', ":m '<-2<CR>gv=gv")
nnoremap('<leader>j', ':m .+1<CR>==')
nnoremap('<leader>k', ':m .-2<CR>==')

-- switching tabs
nnoremap('<leader>H', ':tabprevious<CR>')
nnoremap('<leader>L', ':tabnext<CR>')

-- resize
nnoremap('<leader>in', ':resize +10<CR>')
nnoremap('<leader>dc', ':resize -10<CR>')
nnoremap('<leader>wd', ':vertical resize +10<CR>')
nnoremap('<leader>sk', ':vertical resize -10<CR>')

-- nerd tree
vim.g.NERDTreeShowHidden = 1 
nnoremap('<leader>n', ':NERDTreeFocus<CR>')

