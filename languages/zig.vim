" Zig language settings
autocmd Filetype zig call s:lang_settings()
function! s:lang_settings()
	setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
endfunction