" Dracula - theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Settings that can be set before the plugin is loaded
let g:dracula_high_contrast_diff = 1 " Use high contrast diff colors
let g:dracula_italic = 1 " Pray that the users terminal supports italics
set background=dark " Set the background to dark

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
	" Only apply the theme is no other colorscheme has been set
	if !exists('g:colors_name')
		if has("termguicolors")
			try
				set termguicolors
				colorscheme dracula
			catch
				colorscheme darkblue
			endtry
		endif
	endif
endfunction