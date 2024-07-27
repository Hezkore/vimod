" VIMod keymaps

" Set leader to , if not set
if !exists('g:mapleader')
	let mapleader = ","
endif

if exists('g:enabled_quickmenu')
	" Space opens the menu
	noremap <silent> <space> :call quickui#menu#open('system')<cr>
endif

" Leader followed by h, j, gB, k, or l to switch buffers
nmap <silent> <leader>h :bprevious!<CR>
nmap <silent> <leader>j :bprevious!<CR>
nmap <silent> <leader>gB :bprevious!<CR>
nmap <silent> <leader>l :bnext!<CR>
nmap <silent> <leader>k :bnext!<CR>

" Number Leader gb to switch to a specific buffer, or the next buffer
nnoremap <silent> <expr> <leader>gb (v:count > 1 ? ':buffer ' . v:count : ':bnext!').'<CR>'

" Leader n to create a new scratch buffer
nmap <silent> <leader>n :enew<CR>

" Leader q to close the current buffer
function! s:CloseBuffer()
	try
		execute 'bp! | bd! #'
	catch
		"echo "Cannot close the last buffer"
		" Create a new scratch buffer as the first buffer
		execute 'enew'
		" Close the previous buffer
		try
			execute 'bd! #'
		catch
			"echo "Cannot close the last buffer"
		endtry
	endtry
endfunction
nmap <silent> <leader>q :call <SID>CloseBuffer()<CR>

" Leader t to reopen the last (non-scratch) buffer
function! s:ReopenLastBuffer()
	try
		execute 'e#'
	catch
		echo "No previous buffer"
	endtry
endfunction
nmap <silent> <leader>t :call <SID>ReopenLastBuffer()<CR>

" Leader cd to change the working directory to the current buffer's directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Leader cp to open Copilot panel
if exists('g:enabled_copilot')
	nnoremap <silent> <leader>cp <cmd>Copilot panel<CR>
endif

if exists('g:enabled_fzf')
	" Leader lb to list all buffers
	nnoremap <silent> <leader>b :Buffers<CR>
	" Leader p to open fzf file search
	nnoremap <silent> <leader>p :call FindFilesInCurrentDir()<CR>
endif

if exists('g:enabled_nerdtree') && g:enabled_nerdtree == 1
	" Leader o toggles or focuses the NERDTree
	nnoremap <silent> <leader>o :NERDTreeFocus<CR>
	" Leader f to open NERDTree on the current file
	nnoremap <silent> <leader>f :NERDTreeFind<CR>
else
	" Leader o toggles or focuses the Lexplore
	nnoremap <silent> <leader>o :call ToggleOrFocusLexplore()<CR>
endif

" Extended key mappings
function! VIModExtendedKeys()
	" Ctrl h, l to quickly switch buffers
	nnoremap <silent> <C-h> :bprevious!<CR>
	nnoremap <silent> <C-l> :bnext!<CR>
	
	" Ctrl Tab to switch to the next buffer
	nnoremap <silent> <C-tab> :bnext!<CR>
	" Ctrl Shift Tab to switch to the previous buffer
	nnoremap <silent> <C-S-tab> :bprevious!<CR>
	
	" Tab to select the current popup menu item
	inoremap <expr> <tab> pumvisible() ? "\<C-y>" : "\<Tab>"
	
	if exists('g:enabled_copilot')
		inoremap <C-x><C-g> <cmd>call TriggerCopilotSuggestion()<CR>
	endif
	
	if exists('g:enabled_lsp')
		"nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
		"nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
		
		" Enter no longer selects current popup menu item
		inoremap <expr> <cr> pumvisible() ? asyncomplete#cancel_popup() . "\<cr>" : "\<cr>"
		inoremap <expr> <C-j> pumvisible() ? asyncomplete#cancel_popup() . "\<cr>" : "\<cr>"
		
		" Ctrl Space to show autocomplete and signature help
		inoremap <silent> <C-Space> <C-\><C-O>:LspSignatureHelp<CR><Plug>(asyncomplete_force_refresh)
		
		if exists('g:enabled_quickmenu')
			" K to show LSP context menu
			nnoremap <expr> K LspRunningForBuffer() ? ":silent call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>" : "\K"
		endif
	endif
	
	if exists('g:enabled_fzf')
		" Ctrl p to open fzf file search
		nnoremap <silent> <C-p> :call FindFilesInCurrentDir()<CR>
	endif
endfunction
command! VIModKeys call VIModExtendedKeys()