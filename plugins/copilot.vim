" Copilot - GitHub Copilot
Plug 'github/copilot.vim'

" Settings that can be set before the plugin is loaded
"imap <M-§> <Plug>(copilot-suggest)
"imap <NL> <Cmd>Copilot panel<CR>
map <leader>p <Cmd>Copilot panel<CR>

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction