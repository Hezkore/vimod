" Copilot - GitHub Copilot
let g:enabled_copilot = get(g:, 'enabled_copilot', 1)
if g:enabled_copilot
	Plug 'github/copilot.vim'
endif

" Settings that can be set before the plugin is loaded
" Disable automatic Copilot completion, use Ctr+x Ctrl+c to trigger it instead
let g:copilot_enabled = 1

function! ToggleCopilot()
	if copilot#Enabled()
		execute 'Copilot disable'
	else
		execute 'Copilot enable'
		" Run `Copilot status` and check if `:Copilot setup` is mentioned
		let status = execute('Copilot status')
		if status =~# ':Copilot setup'
			execute 'Copilot setup'
		endif
	endif
endfunction

function! TriggerCopilotSuggestion()
	echo "Asking Copilot for a suggestion..."
	" wait for just a little bit before calling copilot#Suggest()
	call timer_start(100, {-> execute("call copilot#Suggest()")})
	"execute "call copilot#Suggest()"
endfunction

function! CopilotReadyToUse()
	" TODO stop from freezing forever
	return 0
	
	if copilot#Enabled()
		if empty(copilot#Client().StartupError())
			if copilot#RunningClient() != v:null
				" This will freeze Vim forever, do not use!
				let status = copilot#Call('checkStatus', {})
				if status ==# 'Copilot: Ready'
					return 1
				endif
			endif
		endif
	endif

	return 0
endfunction

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction