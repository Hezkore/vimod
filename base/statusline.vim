" Custom statusline

" Always show the status line at the bottom
set laststatus=2

" Function to get the full name of the current mode
function! ModeFullName()
	let mode_name = {
		\ 'n': 'NORMAL',
		\ 'no': 'N·OP',
		\ 'v': 'VISUAL',
		\ 'V': 'V·LINE',
		\ "\<C-V>" : 'V·BLOCK',
		\ 's': 'SELECT',
		\ 'S': 'S·LINE',
		\ "\<C-S>" : 'S·BLOCK',
		\ 'i': 'INSERT',
		\ 'R': 'REPLACE',
		\ 'Rv': 'V·REPLACE',
		\ 'c': 'COMMAND',
		\ 'cv': 'VIM EX',
		\ 'ce': 'EX',
		\ 'r': 'PROMPT',
		\ 'rm': 'MORE',
		\ 'r?': 'CONFIRM',
		\ '!': 'SHELL',
		\ 't': 'TERMINAL'
		\ }
	return get(mode_name, mode(), '')
endfunction

" Set the statusline based on if the window is active or not
augroup StatusLine
	autocmd!
	autocmd WinEnter * setlocal statusline=%!ActiveStatusLine()
	autocmd WinLeave * setlocal statusline=%!InactiveStatusLine()
augroup END
set statusline=%!ActiveStatusLine()

" Function for setting an inactive statusline
function! InactiveStatusLine()
	" Set the highlight group for the inactive statusline
	let s:statusline = '%#TabLine#'
	let s:statusline .= " %(%h %)"
	let s:statusline .= StatusLineFile()
	let s:statusline .= StatusLineInfo()
	let s:statusline .= StatusLinePos()
	
	return s:statusline
endfunction

" Function for setting an active statusline
function! ActiveStatusLine()
	let s:statusline = mode() != 'n' ? '%#QuickFixLine#' : '%#WildMenu#'
	let s:statusline .= &buftype == 'help' ? (mode() != 'n' ? ' %h %{ModeFullName()}' : ' %h') : ' %{ModeFullName()}'
	let s:statusline .= mode() != 'n' ? '>%#QuickFixLine# ' : ' %#StatusLineNC# '
	let s:statusline .= StatusLineFile()
	let s:statusline .= mode() != 'n' ? '%#QuickFixLine#' : '%#StatusLine#'
	let s:statusline .= StatusLineInfo()
	let s:statusline .= mode() != 'n' ? '%#QuickFixLine#' : '%#CurSearch#'
	let s:statusline .= StatusLinePos()
	
	return s:statusline
endfunction

" Function for setting the file information in the statusline
function! StatusLineFile()
	let s:statuslinefile = '%(%w %)'
	let s:statuslinefile .= '%t%<'
	let s:statuslinefile .= '%m'
	let s:statuslinefile .= '%( %{&readonly?"⊝":""}%)'
	let s:statuslinefile .= '%='
	let s:statuslinefile .= '%(%y %)'
	
	return s:statuslinefile
endfunction

" Function for setting the general information in the statusline
function! StatusLineInfo()
	let s:statuslineinfo = '%( %<%{&expandtab?"Spaces":"Tabs"}[%{&tabstop}]%)'
	let s:statuslineinfo .= '%( %{&fileencoding?&fileencoding:&encoding}%)'
	let s:statuslineinfo .= '%([%{&fileformat}] %)'
	if exists('g:enabled_lsp') && g:enabled_lsp == 1
		try
			let s:statuslineinfo .= '%(%{&modifiable==1? (LspRunningForBuffer()==1? "LSP[".LspStatusInfo()."]":"LSP[off]") : ""} %)'
		catch
		endtry
	endif
	if exists('g:enabled_copilot') && g:enabled_copilot == 1
		try
			let s:statuslineinfo .= '%(%{&readonly==0? (copilot#Enabled()==1? "Copilot[on]":"Copilot[off]") : ""} %)'
		catch
		endtry
	endif
	
	return s:statuslineinfo
endfunction

" Function for setting the current position in the statusline
function! StatusLinePos()
	let s:statuslineending = '%( %P%)'
	let s:statuslineending .= ' Ln%l/%L'
	let s:statuslineending .= ', Col%v '
	
	return s:statuslineending
endfunction