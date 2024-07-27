" vim-cursorword - underlines the word under the cursor
let g:enabled_cursorword = get(g:, 'enabled_cursorword', 1)
if g:enabled_cursorword
	Plug 'itchyny/vim-cursorword'
endif

" Settings that can be set before the plugin is loaded
let g:cursorword = 1
let g:cursorword_highlight = 1
let g:cursorword_delay = 400

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction