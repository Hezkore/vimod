" LSP - Language Server Protocol support
let g:enabled_snippets = get(g:, 'enabled_snippets', 1)
if g:enabled_snippets
	" Snippet support
	Plug 'hrsh7th/vim-vsnip'
	" LSP integration
	Plug 'hrsh7th/vim-vsnip-integ'
	" Snippet library
	Plug 'rafamadriz/friendly-snippets'
endif

" Settings that can be set before the plugin is loaded

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction