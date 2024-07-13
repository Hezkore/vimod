" Figure out where the vim files are
if has('win32') || has('win64')
	let g:vimfiles = expand('$HOME/vimfiles')
else
	let g:vimfiles = expand('$HOME/.vim')
endif

runtime vimod/base/plugin.vim

" Basic settings
syntax on " Enable syntax highlighting
filetype plugin indent on " Enable filetype detection, plugins, and indentation
set splitright " Split to the right
" Disable error bells
set belloff=error
"set helpheight=20 " Set the height of the help window
set hidden " Allow hidden buffers
set number " Show line numbers
set noexpandtab " Use spaces instead of tabs
set shiftwidth=4 " Set the number of spaces to use for auto-indent
set tabstop=4 " Set the number of spaces that a tab counts for
set hlsearch " Highlight search results
set incsearch " Incremental search
set ignorecase " Case-insensitive search
set smartcase " Case-insensitive search, unless a capital letter is used
set noswapfile " Disable swap files
"set updatetime=300 " Set the time in milliseconds to write swap files
set timeout
set timeoutlen=1500 " Key timeout in milliseconds (like when using leader key)
set ttimeout
set ttimeoutlen=50 " Timeout for key codes
set laststatus=2 " Always show the status line
"set statusline=%{&readonly?'[Read-Only]':''}\ %=Ln\ %l/%L,Col\ %v\ Scroll:%P\ %Y

" reset the command line text after a while
set showcmd " Show command in status line
set showmatch " Show matching brackets

set shortmess+=F

" hide he current mode
set noshowmode

" higlight current line
set cursorline

" enable terminal colors
set termguicolors


set wildmenu " Show command line completion menu
" Show auto completion menu immediately
set completeopt=menuone,noinsert,noselect


runtime vimod/base/statusline.vim
runtime vimod/base/tabline.vim

" Netrw directory browsing settings
let g:netrw_browse_split=0 " Open files in the same window
let g:netrw_keepdir = 0 " Keep the current directory and the browsing directory synced
let g:netrw_banner = 0 " Disable the banner

hi! link netrwMarkFile Search

" Key mappings
let mapleader = "\<Space>" " Set the leader key to Space
nmap <silent> <leader>l :bnext!<CR> " Go to the next buffer
nmap <silent> <leader>h :bprevious!<CR> " Go to the previous buffer
nmap <silent> <leader>q :bp! <BAR> bd! #<CR> " Close the current buffer
" Undo closing the last buffer with <leader>t
nmap <silent> <leader>t :e#<CR>
nnoremap <Leader>bl :buffers<CR>:buffer<Space>
" Map leader followed by a number to jump to that buffer number
for i in range(1, 9)
	execute 'nnoremap <silent> <Leader>'.i.' :buffer '.i.'<CR>'
endfor

nnoremap <silent> <F5> :source $MYVIMRC<CR> <BAR> :echomsg "Reloaded .vimrc"<CR> " Reload the .vimrc file