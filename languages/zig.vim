" Zig language settings
autocmd Filetype zig call s:lang_settings()
function! s:lang_settings()
	" Use Tabs instead of spaces
	setlocal noexpandtab
	" Set tabsize to whatever the built-in default is for Zig
	let &l:tabstop = &shiftwidth
	let &l:softtabstop = &shiftwidth
	
	" Don't auto-insert comment leader on new line
	setlocal formatoptions-=r
	
	" Disable formatting on save in older Vim versions
	let g:zig_fmt_autosave=0
endfunction