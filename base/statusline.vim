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
	" Adjust for special cases like Visual Block mode
	let current_mode = mode()
	return get(mode_name, current_mode, '')
endfunction

" Use autocommands to switch statusline highlight groups based on window focus
augroup StatusLine
	autocmd!
	autocmd WinEnter * setlocal statusline=%!ActiveStatusLine()
	autocmd WinLeave * setlocal statusline=%!InactiveStatusLine()
augroup END
set statusline=%!ActiveStatusLine()

" function for setting an inactive statusline
function! InactiveStatusLine()
	" Set the highlight group for the inactive statusline
	let s:statusline = '%#TabLine#'
	let s:statusline .= " %(%h %)"
	let s:statusline .= StatusLineFile()
	let s:statusline .= StatusLineInfo()
	let s:statusline .= StatusLinePos()
	
	return s:statusline
endfunction

" function for setting an active statusline
function! ActiveStatusLine()
	let s:statusline = mode() != 'n' ? '%#QuickFixLine#' : '%#WildMenu#'
	let s:statusline .= &buftype == 'help' ? (mode() != 'n' ? ' %h %{ModeFullName()}' : ' %h') : ' %{ModeFullName()}'
	let s:statusline .= mode() != 'n' ? '>%#QuickFixLine# ' : ' %#StatusLineNC# '
	let s:statusline .= StatusLineFile()
	let s:statusline .= mode() != 'n' ? '%#QuickFixLine#' : '%#StatusLine#'
	let s:statusline .= StatusLineInfo()
	let s:statusline .= mode() != 'n' ? '%#QuickFixLine#' : '%#CurSearch#'
	let s:statusline .= StatusLinePos()
	
	" Return the statusline
	return s:statusline
endfunction

function! StatusLineFile()
	let s:statuslinefile = '%(%w %)'
	let s:statuslinefile .= '%t'
	let s:statuslinefile .= '%m'
	let s:statuslinefile .= '%( %{&readonly?"⊝":""}%)'
	let s:statuslinefile .= '%='
	let s:statuslinefile .= '%(%y %)'
	
	return s:statuslinefile
endfunction

function! StatusLineInfo()
	let s:statuslineinfo = '%( %{&fileencoding?&fileencoding:&encoding}%)'
	let s:statuslineinfo .= '[%{&fileformat}] '
	
	return s:statuslineinfo
endfunction

function! StatusLinePos()
	let s:statuslineending = '%( %p%% %)'
	let s:statuslineending .= '㏑:%l/%L'
	let s:statuslineending .= '☰℅:%v '
	
	return s:statuslineending
endfunction