" Vim Settings

" Enable syntax highlighting
syntax on

" Enable filetype detection, plugins, and indentation
filetype plugin indent on

" Highlight the current line
set cursorline

" Show line numbers
set number

" Set the width of the line numbers
set numberwidth=6

" Show matching brackets when the cursor is over one
set showmatch

" Show command in status line
set showcmd

" Always keep one line around the cursor
set scrolloff=1

" Let Vim set the title of the terminal
set title

" Enable terminal colors if supported by Vim (not the terminal)
if has("termguicolors")
	set termguicolors
endif

" Split windows to the right by default (because we have more horizontal space)
set splitright

" Hide the current mode and assume the status line displays it
set noshowmode

" Use the command line completion menu
set wildmenu

" Configure auto completion menu to show immediately without inserting or selecting automatically
set completeopt=menuone,preview,popup,noinsert,noselect

" Allow hidden buffers to enable switching without saving
set hidden

" Disable swap files to avoid clutter and potential performance issues
set noswapfile

" Disable bell on errors (otherwise it triggers on every buffer switch)
set belloff=error

" Reduce message verbosity
set shortmess+=F

" Configure key timeout
set timeout
set timeoutlen=1500

" Configure timeout for key codes
set ttimeout
set ttimeoutlen=50

" Enable incremental search for real-time search results
set incsearch

" Highlight search results
set hlsearch

" Ignore case in search patterns for flexibility
set ignorecase

" Enable smart case for search: case-insensitive unless a capital letter is used
set smartcase

" Use Tab for Tabs
set noexpandtab

" Set the number of spaces for a tab character for alignment
set tabstop=4

" Set the number of spaces to use for auto-indentation for consistency
set shiftwidth=4

" Allow the cursor to go one character past the end of the line
set virtualedit+=block,onemore

" Show whitespaces
set listchars=tab:\¦\ ,nbsp:·,trail:·
set list