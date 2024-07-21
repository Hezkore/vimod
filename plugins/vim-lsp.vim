" LSP - Language Server Protocol support
" Main LSP runner
Plug 'prabirshrestha/vim-lsp'
" Automatic installation of LSP servers
Plug 'mattn/vim-lsp-settings'
" Completion while typing
Plug 'prabirshrestha/asyncomplete.vim'
" Fill completion menu with LSP completions
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Settings that can be set before the plugin is loaded
let g:enabled_lsp = 1

let g:lsp_diagnostics_enabled = 1

" Do nothing while in insert mode
let g:lsp_diagnostics_signs_insert_mode_enabled = 0
let g:lsp_diagnostics_float_insert_mode_enabled = 0
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0

" Place text after the line
let g:lsp_diagnostics_virtual_text_align = 'after'

" Disable inlay hints, such as parameter names
let g:lsp_inlay_hints_enabled = 0


let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 150

let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_float_delay = 300

let g:lsp_diagnostics_highlights_enabled = 1
"let g:lsp_diagnostics_highlights_delay = 0

"let g:lsp_diagnostics_signs_enabled = 0
"let g:lsp_diagnostics_signs_delay = 0

let g:lsp_diagnostics_signs_error = {'text': 'E'}
let g:lsp_diagnostics_signs_warning = {'text': 'W'}
let g:lsp_diagnostics_signs_information = {'text': 'I'}

let g:lsp_document_code_action_signs_hint = {'text': 'A'}

"let g:lsp_diagnostics_signs_hint = 0
"let g:lsp_diagnostics_signs_priority = 0
"let g:lsp_diagnostics_signs_priority_map = 0
"let g:lsp_diagnostics_virtual_text_enabled = 0
"let g:lsp_diagnostics_virtual_text_delay = 0
"let g:lsp_diagnostics_virtual_text_prefix = 0
"let g:lsp_diagnostics_virtual_text_align = 0
"let g:lsp_diagnostics_virtual_text_wrap = 0
"let g:lsp_diagnostics_virtual_text_padding_left = 0

"let g:lsp_document_code_action_signs_enabled = 0
"let g:lsp_document_code_action_signs_delay = 0
"let g:lsp_document_code_action_signs_hint = 0
"let g:lsp_document_code_action_signs_priority = 0

"let g:lsp_preview_keep_focus = 0
"let g:lsp_use_event_queue = 0
"let g:lsp_insert_text_enabled = 0
"let g:lsp_text_edit_enabled = 0
"let g:lsp_document_highlight_enabled = 0
"let g:lsp_document_highlight_delay = 0
"let g:lsp_preview_float = 0
"let g:lsp_preview_autoclose = 0
"let g:lsp_preview_doubletap = 0
"let g:lsp_preview_fixup_conceal = 0
let g:lsp_peek_alignment = 'center'
"let g:lsp_preview_max_width = 0
"let g:lsp_preview_max_height = 0
"let g:lsp_float_max_width = 0
"let g:lsp_signature_help_enabled = 0
"let g:lsp_signature_help_delay = 0
"let g:lsp_show_workspace_edits = 0
"let g:lsp_fold_enabled = 0
"let g:lsp_hover_conceal =
"let g:lsp_hover_ui = 0
"let g:lsp_ignorecase = 0
"let g:lsp_semantic_enabled = 0
"let g:lsp_semantic_delay = 0
"let g:lsp_text_document_did_save_delay = 0
"let g:lsp_completion_resolve_timeout = 0
"let g:lsp_tagfunc_source_methods = 0
"let g:lsp_show_message_request_enabled = 0
"let g:lsp_show_message_log_level = 0
"let g:lsp_work_done_progress_enabled = 0
"let g:lsp_untitled_buffer_enabled = 0
"let g:lsp_inlay_hints_delay = 0
"let g:lsp_code_action_ui = 0

"let g:lsp_get_supported_capabilities = get(g:, 'lsp_get_supported_capabilities', [function('lsp#default_get_supported_capabilities')])
"let g:lsp_document_symbol_detail = get(g:, 'lsp_document_symbol_detail', 0)
"let g:lsp_experimental_workspace_folders = get(g:, 'lsp_experimental_workspace_folders', 0)

function! LspRunningForBuffer()
	let l:server = lsp#get_allowed_servers(bufnr('%'))
	for l:server in l:server
		let l:status = lsp#get_server_status(l:server)
		if l:status == 'running'
			return 1
		endif
	endfor
	return 0
endfunction

function! LspStatusInfo()
	" use lsp#get_buffer_diagnostics_counts() and then return a string with the counts
	let l:counts = lsp#get_buffer_diagnostics_counts()
	let l:status = ''
	if l:counts.error > 0
		let l:status .= printf('E:%d', l:counts.error)
	endif
	if l:counts.warning > 0
		let l:status .= printf('W:%d', l:counts.warning)
	endif
	if l:counts.information > 0
		let l:status .= printf('I:%d', l:counts.information)
	endif
	return l:status == '' ? 'on' : l:status
endfunction

function! LspToggleState()
	if LspRunningForBuffer() == 1
		echo "Stopping LSP server"
		LspStopServer
	else
		echo "Starting LSP server"
		call lsp#activate()
	endif
endfunction

"function! ManageOrInstallLspServers()
"	if LspRunningForBuffer() == 1
"		LspManageServers
"	else
"		LspInstallServer
"	endif
"endfunction
	
" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
	
	function! s:on_lsp_buffer_enabled() abort
		setlocal omnifunc=lsp#complete
		"setlocal signcolumn=yes
		if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
		"nmap <buffer> gd <plug>(lsp-definition)
		"nmap <buffer> gs <plug>(lsp-document-symbol-search)
		"nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
		"nmap <buffer> gr <plug>(lsp-references)
		"nmap <buffer> gi <plug>(lsp-implementation)
		"nmap <buffer> gt <plug>(lsp-type-definition)
		"nmap <buffer> <leader>rn <plug>(lsp-rename)
		"nmap <buffer> [g <plug>(lsp-previous-diagnostic)
		"nmap <buffer> ]g <plug>(lsp-next-diagnostic)
		"nnoremap <buffer> K <plug>(lsp-hover)
		"nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
		"nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
		
		"let g:lsp_format_sync_timeout = 1000
		"autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
		
		" Close completion menu when completion is done
		autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
		
		" refer to doc to add more commands
	endfunction
endfunction