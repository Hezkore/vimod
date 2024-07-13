" Netrw directory browsing settings
let g:netrw_browse_split=0 " Open files in the same window
let g:netrw_keepdir = 0 " Keep the current directory and the browsing directory synced
let g:netrw_banner = 0 " Disable the banner
let g:netrw_liststyle=3 " Use tree style directory listing

hi! link netrwMarkFile Search

" Function to toggle or focus the Lexplore window
let s:explorer_win = -1
function! ToggleOrFocusLexplore()
	" Check if the Lexplore window is open
	let i = 1
	let win_found = 0
	while i <= winnr('$')
		if getwinvar(i, '&filetype') ==# 'netrw'
			let s:explorer_win = i
			let win_found = 1
			break
		endif
		let i += 1
	endwhile

	" If Lexplore window is found, focus it
	if win_found
		execute s:explorer_win . 'wincmd w'
	else
		" Open Lexplore
		20Lexplore
		let s:explorer_win = winnr()
	endif
endfunction