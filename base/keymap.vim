" VIMod keymaps

" DEBUG: Reload the .vimrc file
"nnoremap <silent> <F5> :source $MYVIMRC<CR> <BAR> :echomsg "Reloaded .vimrc"<CR> " Reload the .vimrc file

" Set leader to space if not set
if !exists('g:mapleader')
	let mapleader = "\<Space>"
endif

" Leader followed by h, j, k, or l to switch buffers
nmap <silent> <leader>h :bprevious!<CR>
nmap <silent> <leader>j :bprevious!<CR>
nmap <silent> <leader>l :bnext!<CR>
nmap <silent> <leader>k :bnext!<CR>

" Leader n to create a new scratch buffer
nmap <silent> <leader>n :enew<CR>

" Leader q to close the current buffer
nmap <silent> <leader>q :bp! <BAR> bd! #<CR>

" Leader t to reopen the last (non-scratch) buffer
nmap <silent> <leader>t :e#<CR>

" Leader cd to change the working directory to the current buffer's directory
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Number Leader bb to switch to a specific buffer
nnoremap <expr> <Leader>bb ':buffer '.(v:count > 0 ? v:count : '').'<CR>'

" Leader o toggles or focuses the Lexplore
nnoremap <leader>o :call ToggleOrFocusLexplore()<CR>


" Make tab accept wildmenu item
"inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Extended key mappings
function! VIModExtendedKeys()
	" ctrl h, j, k, l to quickly switch buffers
	nnoremap <silent> <C-h> :bprevious!<CR>
	nnoremap <silent> <C-j> :bprevious!<CR>
	nnoremap <silent> <C-l> :bnext!<CR>
	nnoremap <silent> <C-k> :bnext!<CR>
	
	" ctrl space to show autocomplete and signature help
	inoremap <C-Space> <C-\><C-O>:LspShowSignature<CR><C-x><C-o>
endfunction
command! VIModKeys call VIModExtendedKeys()