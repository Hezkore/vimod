" fugitive - Git wrapper
if executable('git')
	let g:enabled_fugitive = get(g:, 'enabled_fugitive', 1)
else
	let g:enabled_fugitive = 0
endif
if g:enabled_fugitive
	Plug 'tpope/vim-fugitive'
endif

" Settings that can be set before the plugin is loaded

" Function for cleaning up the fugitive statusline
function! CustomFugitiveStatusline()
	let s:statusline = fugitive#statusline()
	let s:statusline = substitute(s:statusline, '^\[', '', '')
	let s:statusline = substitute(s:statusline, '\]$', '', '')
	let s:statusline = substitute(s:statusline, 'Git:', '', '')
	let s:statusline = substitute(s:statusline, '(', '[', '')
	let s:statusline = substitute(s:statusline, ')', ']', '')
	return s:statusline
endfunction

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction