" VIMod keymaps

" DEBUG: Reload the .vimrc file
nnoremap <silent> <F5> :source $MYVIMRC<CR> <BAR> :echomsg "Reloaded .vimrc"<CR> " Reload the .vimrc file

" Set leader to space
let mapleader = "\<Space>"

" jk to escape insert mode
"inoremap jk <esc>

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

" Leader bl to list buffers and jump to one
nnoremap <Leader>bl :buffers<CR>:buffer<Space>

" Leader followed by a number to jump to that buffer number
for i in range(1, 9)
	execute 'nnoremap <silent> <Leader>'.i.' :buffer '.i.'<CR>'
endfor

" Leader o toggles or focuses the Lexplore
nnoremap <leader>o :call ToggleOrFocusLexplore()<CR>

" Ctrl h, j, k, l to quickly switch buffers
nnoremap <silent> <C-h> :bprevious!<CR>
nnoremap <silent> <C-j> :bprevious!<CR>
nnoremap <silent> <C-l> :bnext!<CR>
nnoremap <silent> <C-k> :bnext!<CR>