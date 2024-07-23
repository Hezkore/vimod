" Sessions management
let g:enabled_sessions = get(g:, 'enabled_sessions', 1)

let g:sessions_dir = get(g:, 'sessions_dir', g:vimfiles . '/sessions')
let g:last_session_file = get(g:, 'last_session_file', g:vimfiles . '/.lastsession')
let g:current_session = get(g:, 'current_session', '')
let g:last_session = ''
let g:session_default_name = 'default'

if g:enabled_sessions
	"if(argc() == 0)
	"	au VimEnter * nested :call s:manage_sessions()
	"endif
	let g:last_session = filereadable(g:last_session_file) ? readfile(g:last_session_file)[0] : ''
	au VimLeavePre * :call MakeSession()
endif

function! MakeSession(session = '')
	let g:current_session = a:session != '' ? a:session : g:current_session
	if g:current_session == ''
		let g:current_session = g:session_default_name
	endif
	" Make sure the path exists
	if !isdirectory(g:sessions_dir)
		call mkdir(g:sessions_dir, 'p')
	endif
	" Save the session
	exe "mksession! " . GetPathToCurrentSession()
	" Save the last session name
	"let g:last_session = g:current_session
	call writefile([g:current_session], g:last_session_file)
	echo "Saved session \"" . g:current_session . "\""
endfunction

function! LoadSession( session = '' )
	if g:current_session == a:session
		echo "Session \"" . g:current_session . "\" is already loaded"
		return
	endif
	let g:current_session = a:session != '' ? a:session : g:current_session
	if g:current_session != ''
		let l:sessionfile = GetPathToCurrentSession()
		if (filereadable(l:sessionfile))
			exe 'source ' l:sessionfile
			redraw!
			let g:last_session = g:current_session
			echo "Loaded session \"" . g:current_session . "\""
		else
			echo "Session file not found: " . l:sessionfile
		endif
	else
		echo "No session to load"
	endif
endfunction

"function! LoadPreviousSession()
"	if filereadable(g:last_session_file)
"		let l:session = readfile(g:last_session_file)[0]
"		call LoadSession(l:session)
"	else
"		echo "No previous session found"
"	endif
"endfunction

function! ProduceSessionList()
	let l:sessionlist = []
	for l:file in split(glob(g:sessions_dir . '/*.vim'), '\n')
		let l:sessionname = fnamemodify(l:file, ':t:r')
		if l:sessionname != g:session_default_name
			call add(l:sessionlist, {'name': l:sessionname, 'mtime': getftime(l:file)})
		endif
	endfor
	" Sort the list by modification time in descending order
	call sort(l:sessionlist, {a, b -> b.mtime - a.mtime})
	" Extract the session names from the sorted list
	return map(l:sessionlist, 'v:val.name')
endfunction

function! RemoveSession( session )
	let l:sessionfile = g:sessions_dir . '/' . a:session . '.vim'
	if filereadable(l:sessionfile)
		call delete(l:sessionfile)
		echo "Removed session \"" . a:session . "\""
	else
		echo "Session file not found: " . l:sessionfile
	endif
endfunction

function! GetCurrentSession()
	return g:current_session != '' ? g:current_session : g:session_default_name
endfunction

function! GetLastSession()
	return g:last_session
endfunction

function! GetPathToCurrentSession()
	return g:sessions_dir . '/' . g:current_session . '.vim'
endfunction

"function! s:manage_sessions()
"
"	"call LoadSession()
"endfunction