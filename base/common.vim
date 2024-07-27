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

" Function for closing every buffer that is listed, has no filetype and is not modified
function CloseUnmodifiedBuffers()
	try
		for bufnr in range(1, bufnr('$'))
			if buflisted(bufnr) && empty(bufname(bufnr)) && !getbufvar(bufnr, '&modified')
				execute 'bd ' . bufnr
			endif
		endfor
	catch
	endtry
endfunction
"augroup ScratchBuffers
"	autocmd!
"	autocmd BufLeave * call CloseUnmodifiedBuffers()
"augroup END

" Function for getting the buffers filetype with a capitalized first letter
function! GetFileType()
	let s:filetype = &filetype
	return toupper(s:filetype[0]) . s:filetype[1:]
endfunction