let mapleader = " "

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" setup plugins
call plug#begin()

	" coc plugin install
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'preservim/nerdtree'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'morhetz/gruvbox'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'

call plug#end()

" Syntax highlights
syntax on
set nohlsearch

" search
set incsearch
set ic
set smartcase

" Colors
colorscheme gruvbox
" highlight Normal ctermfg=grey ctermbg=black
set background=dark

" line numbers
set rnu nu 
nmap <leader>nm :set rnu!<CR>

" indentation
set smartindent 
set tabstop=4 softtabstop=4
set shiftwidth=4

" clipboard
set clipboard=unnamed

" undo
set undodir=~/.vim/undodir
set undofile

" update path
set path+=**

" show matching brackets
set showmatch

" enable mouse
set mouse=a
set ttymouse=xterm2

" filetype plugin
filetype plugin on
filetype indent on

" coc mappings
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
augroup AutoImports
	autocmd!
	autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
	autocmd BufWritePre *.java :silent call CocAction('runCommand', 'java.action.organizeImports') 
augroup END

" nerdtree mappings
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeFocus<CR>

" fzf mappings
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>ps :Rg<CR>

" keep J centered
nnoremap J mzJ`z

" moving lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

set laststatus=2
set statusline=%#PmenuSel#%{fugitive#head()}%#LineNr#\ %f%=%y\ %l:%c\ 
