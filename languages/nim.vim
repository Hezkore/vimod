" Nim language settings
autocmd Filetype nim call s:lang_settings()
function! s:lang_settings()
	setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
endfunction