" Vim-peekaboo - register menu
let g:enabled_peekaboo = get(g:, 'enabled_peekaboo', 1)
if g:enabled_peekaboo
	Plug 'junegunn/vim-peekaboo'
endif

" Settings that can be set before the plugin is loaded
let g:peekaboo_window = 'vert bo 30new'
let g:peekaboo_delay = 0
let g:peekaboo_compact = 0
let g:peekaboo_prefix = ''
let g:peekaboo_ins_prefix = ''

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction