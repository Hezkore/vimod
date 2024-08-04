" VIMod commands

" Show current VIMod version
command! VIModVersion echo "VIMod v" . g:vimod_version

" Reapply settings
command! ApplySettings execute 'source $MYVIMRC'

" Show and edit settings files
function! VIModShowSettings()
	" Ensure g:vimfiles is defined
	if !exists("g:vimfiles")
		echoerr "Error: g:vimfiles is not defined."
		return
	endif
	
	" Open the settings file
	execute 'edit ' . g:vimfiles . '/vimod/base/settings.vim'
	setlocal readonly
	setlocal previewwindow
	
	" Split window and open $MYVIMRC
	vsplit $MYVIMRC
	"execute 'normal! G'
	
	" If $MYVIMRC is changed, source it
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
endfunction
command! Settings call VIModShowSettings()

" Show current session
command! Session echo "Current session is \"" . GetCurrentSession() . "\""

" Show last session
command! LastSession echo "Last session was \"" . g:last_session . "\""