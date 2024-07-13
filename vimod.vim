" Figure out where the vim files are
if has('win32') || has('win64')
	let g:vimfiles = expand('$HOME/vimfiles')
else
	let g:vimfiles = expand('$HOME/.vim')
endif

" Load base
runtime vimod/base/plugins.vim
runtime vimod/base/settings.vim
runtime vimod/base/statusline.vim
runtime vimod/base/tabline.vim
runtime vimod/base/netrw.vim
runtime vimod/base/keymap.vim
runtime vimod/base/commands.vim

" Read the starting directory from the start_dir file
let g:start_dir_file = g:vimfiles . '/.startdir'
if filereadable(g:start_dir_file)
	let g:start_dir = readfile(g:start_dir_file)[0]
	if exists('g:start_dir')
		execute 'cd' fnameescape(g:start_dir)
	endif
endif