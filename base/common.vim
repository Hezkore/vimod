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

" Function for fold toggling
function! ToggleFold()
	try
		execute 'normal! zA'
	catch
	endtry
endfunction

" Function for opening all folds
function! OpenAllFolds()
	try
		execute 'normal! zR'
	catch
	endtry
endfunction

" Function for closing all folds
function! CloseAllFolds()
	try
		execute 'normal! zM'
	catch
	endtry
endfunction

" Convert an ISO timestamp to a formatted timestamp
function! FormatTimestamp(iso_timestamp)
	" Extract date and time components from the ISO 8601 timestamp
	let l:year = str2nr(strpart(a:iso_timestamp, 0, 4))
	let l:month = str2nr(strpart(a:iso_timestamp, 5, 2))
	let l:day = str2nr(strpart(a:iso_timestamp, 8, 2))
	let l:hour = str2nr(strpart(a:iso_timestamp, 11, 2))
	let l:minute = str2nr(strpart(a:iso_timestamp, 14, 2))
	let l:second = str2nr(strpart(a:iso_timestamp, 17, 2))

	" Format the timestamp in a more readable format
	return printf('%04d-%02d-%02d %02d:%02d:%02d', l:year, l:month, l:day, l:hour, l:minute, l:second)
endfunction