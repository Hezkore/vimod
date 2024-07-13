" Figure out where the vim files are
if has('win32') || has('win64')
	let g:vimfiles = expand('$HOME/vimfiles')
else
	let g:vimfiles = expand('$HOME/.vim')
endif

runtime vimod/base/plugins.vim
runtime vimod/base/settings.vim
runtime vimod/base/statusline.vim
runtime vimod/base/tabline.vim
runtime vimod/base/netrw.vim
runtime vimod/base/keymap.vim