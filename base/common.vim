" OS specific path separator
if has("win32") || has("win64")
    let g:path_separator = '\'
else
    let g:path_separator = '/'
endif

" Function for returning the Vim directory
function VimDir()
	if has('win32') || has('win64')
		return expand('~/vimfiles')
	else
		return expand('~/.vim')
	endif
endfunction
let g:vimfiles = VimDir()

" Function for setting the start directory
function SetVIModStartDir()
	" Is the working directory set by the user?
	if getcwd() == expand('$VIMRUNTIME') || getcwd() == expand('~')
		" If not, use the start dir file instead
		let g:start_dir_file = VimDir() . '/.startdir'
		if filereadable(g:start_dir_file)
			let g:start_dir = readfile(g:start_dir_file)[0]
			execute 'cd' fnameescape(g:start_dir)
		endif
	endif
endfunction
call SetVIModStartDir()

" Function for returning the leader key
function LeaderKey()
	if exists('g:mapleader')
		return g:mapleader
	else
		return "Leader"
	endif
endfunction