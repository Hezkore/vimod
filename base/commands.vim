" VIMod commands

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

	" Split window and open $MYVIMRC
	vsplit $MYVIMRC
	execute 'normal! G'
endfunction
command! Settings call VIModShowSettings()

" Apply settings
function! VIModApplySettings()
	" Source the vimrc settings file
	execute 'source $MYVIMRC'
endfunction
command! ApplySettings call VIModApplySettings()