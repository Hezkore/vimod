" LSP - Language Server Protocol support
" Snippet support
Plug 'hrsh7th/vim-vsnip'
" LSP integration
Plug 'hrsh7th/vim-vsnip-integ'
" Snippet library
Plug 'rafamadriz/friendly-snippets'

" Settings that can be set before the plugin is loaded

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction