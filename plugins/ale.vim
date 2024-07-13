" ALE - linting and lsp support
Plug 'dense-analysis/ale'

" Settings that can be set before the plugin is loaded
"let g:ale_linters = {'d': ['dmd', 'dls']}
"let g:ale_fixers = {'d': ['dfmt']}
"let g:ale_d_dmd_executable = 'ldc2'
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_hover_cursor = 1
let g:ale_enabled = 1

" Language specific settings
" D Language
"let g:ale_d_dls_executable = expand('$HOME/AppData/Local/dub/packages/serve-d/0.7.6/serve-d/serve-d.exe')

" Settings that need to be applied after the plugin is loaded
"autocmd User VIModPlugSettings call s:plugin_settings()
"function! s:plugin_settings()
"	echomsg "Applying ALE bindings"
"endfunction