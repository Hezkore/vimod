" Nim language settings
autocmd Filetype nim call s:lang_settings()
function! s:lang_settings()
	" Nim forces 2 spaces for indentation
	setlocal expandtab
	let &l:shiftwidth = 2
	let &l:tabstop = &l:shiftwidth
	let &l:softtabstop = &l:shiftwidth
endfunction