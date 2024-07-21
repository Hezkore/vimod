" Sessions management
let g:enabled_sessions = get(g:, 'enabled_sessions', 0)
if g:enabled_sessions
	function! s:init_sessions()
		if(argc() == 0)
			au VimEnter * nested :call LoadSession()
		endif
		au VimLeavePre * :call MakeSession()
	endfunction
	call s:init_sessions()
endif

function! MakeSession()
	let b:filename = 'session.vim'
	exe "mksession! " . b:filename
endfunction

function! LoadSession()
	let b:sessionfile = "session.vim"
	if (filereadable(b:sessionfile))
		exe 'source ' b:sessionfile
		redraw!
	endif
endfunction