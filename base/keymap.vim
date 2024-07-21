" VIMod keymaps

" Set leader to , if not set
if !exists('g:mapleader')
	"let mapleader = "\<Space>"
	let mapleader = ","
endif

if exists('g:enabled_quickmenu')
	" Space opens the menu
	noremap <silent> <space> :call quickui#menu#open('system')<cr>
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
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Number Leader bb to switch to a specific buffer
nnoremap <expr> <leader>gb ':buffer '.(v:count > 0 ? v:count : '').'<CR>'

" Leader cp to open Copilot panel
if exists('g:enabled_copilot')
	nnoremap <silent> <leader>cp :Copilot panel<CR>
endif

if exists('g:enabled_ctrlp')
	" Leader lb to list all buffers
	nnoremap <silent> <leader>lb :CtrlPBuffer<CR>
	" Leader p to open CtrlP
	nnoremap <silent> <leader>p :CtrlP<CR>
endif

" Leader o toggles or focuses the Lexplore
nnoremap <leader>o :call ToggleOrFocusLexplore()<CR>

" Extended key mappings
function! VIModExtendedKeys()
	" Ctrl h, j, k, l to quickly switch buffers
	nnoremap <silent> <C-h> :bprevious!<CR>
	nnoremap <silent> <C-j> :bprevious!<CR>
	nnoremap <silent> <C-l> :bnext!<CR>
	nnoremap <silent> <C-k> :bnext!<CR>
	
	" Tab to select the current popup menu item
	inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
	
	if exists('g:enabled_lsp')
		nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
		nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
		
		" Ctrl space to show autocomplete and signature help
		inoremap <silent> <C-Space> <C-\><C-O>:LspSignatureHelp<CR><Plug>(asyncomplete_force_refresh)
		
		if exists('g:enabled_quickmenu')
			" K to show LSP context menu
			nnoremap <expr> K LspRunningForBuffer() ? ":silent call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>" : "\K"
		endif
	endif
	
	" Ctrl p to open CtrlP
	if exists('g:enabled_ctrlp')
		let g:ctrlp_map = '<c-p>'
	endif
	
	" Ctrl j & k to move the cursor up and down in the popup menu
	"inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
	"inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
endfunction
command! VIModKeys call VIModExtendedKeys()