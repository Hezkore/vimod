" Dracula - theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Settings that can be set before the plugin is loaded
let g:dracula_high_contrast_diff = 1

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
	"echomsg "Applying Dracula theme"
	colorscheme dracula
endfunction