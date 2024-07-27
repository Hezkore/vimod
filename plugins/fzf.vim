" fzf - fuzzy search
let g:enabled_fzf = get(g:, 'enabled_fzf', 1)
if g:enabled_fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
endif

" Settings that can be set before the plugin is loaded
let g:fzf_vim = {}
let g:fzf_vim.buffers_jump = 1

" This is to open fzf in the current directory without just displaying ./ as the path
function! FindFilesInCurrentDir()
	execute 'Files ' . getcwd()
endfunction

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction