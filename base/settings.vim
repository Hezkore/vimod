" VIMod settings

" Disable compatibility with vi which can cause unexpected issues
set nocompatible

" Enable syntax highlighting
syntax on

" Set Vim language to English
let $LANG = 'en'
set langmenu=en_US.UTF-8

" Enable filetype detection, plugins, and indentation
filetype plugin indent on

" Set the OS clipboard as Vim's clipboard
set clipboard=unnamedplus

" Highlight the current line
set cursorline

" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Set the width of the line numbers
set numberwidth=6

" Always show the tabline
set showtabline=2

" Always show the status line
set laststatus=2

" Show a vertical line at the 80th and 120th columns
set colorcolumn=80,120

" Show matching brackets when the cursor is over one
set showmatch

" Show command in status line
set showcmd

" Always keep one line around the cursor
set scrolloff=1

" Always keep five columns around the cursor
set sidescrolloff=5

" Let Vim set the title of the terminal
set title

" Sets how many lines of history VIM has to remember
set history=1000

"  Maximum number of changes that can be reverted in the current buffer
set undolevels=1000

" Maximum number lines to save for undo
set undoreload=10000

" Persistent undo
try
	let undo_dir = g:vimfiles . "/undo"
	if !isdirectory(undo_dir)
		call mkdir(undo_dir, "p")
	endif
	let &undodir = undo_dir
	set undofile
catch
endtry

" Split windows to the right by default (because we have more horizontal space)
set splitright

" Hide the current mode and assume the status line displays it
set noshowmode

" Use the command line completion menu
set wildmenu
set wildmode=longest,full
set wildoptions=pum
set wildignore=*.o,*~,*.pyc,*.swp,*.bak,*.class
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Omni completion settings
set omnifunc=syntaxcomplete#Complete

" Configure auto completion menu to show immediately without inserting or selecting automatically
set completeopt=menu,menuone,noinsert",preview,noselect

" Allow hidden buffers to enable switching without saving
set hidden

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

" Use Tab for Tabs by default
set noexpandtab

" Set the number of spaces that a tab character represents
set tabstop=4

" Set the number of spaces that a Tab key press inserts while in Insert mode
set softtabstop=4

" Set the number of spaces used for each step of (auto)indentation
set shiftwidth=4

" Enable auto-indentation and smart indentation for code
set autoindent
set copyindent
set smartindent

" Prevent automatic insertion of comment leaders
"set formatoptions-=c " Don't auto-wrap comments
set formatoptions-=r " Don't auto-insert comment leader on new line

" When shifting lines, round the indentation to the nearest multiple of "shiftwidth.
set shiftround

" Set fold method to indent
set foldmethod=indent

" Disable folding by default
set nofoldenable

" Do not fold by default
set foldlevelstart=20

" Add a column to show the fold level
set foldcolumn=1

" Allow the cursor to go one character past the end of the line
set virtualedit+=block,onemore

" Make backspace behave like most other text editors
set backspace=eol,start,indent

" Allow cursor to wrap
set whichwrap=b,s,h,l,<,>,[,]

" Show some whitespaces
set list
set listchars=trail:·,nbsp:·,extends:>,precedes:<,tab:\ \ ",tab:\┊\ ,multispace:\┊\ ,space:·
"match LineNr /\t\|\s\{2,}/
"autocmd WinNew * match LineNr /\t\|\s\{2,}/

" Set utf8 as standard encoding
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Disable backup files and swap files
set nobackup
set nowritebackup
set noswapfile

" Don't redraw while executing macros
set lazyredraw

" Make terminal refreshing fast, instead refresh character for character
set ttyfast

" Always try to show a paragraph's last line
set display+=lastline

" Avoid wrapping a line in the middle of a word
set linebreak

" No line wrapping
set nowrap

" Ask for confirmation when closing an unsaved buffer
set confirm

" Change selected letters when write
set selectmode=mouse,key

" Select with SHIFT + ARROW for Vim-noobs
set keymodel=startsel,stopsel

" Enable select with mouse in insert mode
set selection=exclusive

" Can move cursor past end of line, where there are no characters, in visualblock mode
set virtualedit=block

" Visual selection automatically copied to clipboard
set go+=a

" make terminal refreshing fast, instead refresh character for character
set ttyfast

" Prefer redraw to scrolling for more than 3 lines, prevent glitches when you're scrolling
set ttyscroll=3

" Start diff mode with vertical splits
set diffopt=vertical

" Hide mouse when typing
set mousehide

" Always show the signcolumn
set signcolumn=number

" Options for restoring sessions
set sessionoptions-=options
set sessionoptions+=winpos,resize

" Restore cursor to last position in file when reopened
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif