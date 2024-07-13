" VIMod Keymaps

" Set leader to space
let mapleader = "\<Space>"

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