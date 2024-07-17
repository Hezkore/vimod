" LSP - Language Server Protocol support
Plug 'yegappan/lsp'

" Settings that can be set before the plugin is loaded
let lspOpts = #{
	\   aleSupport: v:false,
	\   autoComplete: v:true,
	\   autoHighlight: v:false,
	\   autoHighlightDiags: v:true,
	\   autoPopulateDiags: v:true,
	\   completionMatcher: 'fuzzy',
	\   completionMatcherValue: 1,
	\   diagSignErrorText: 'E>',
	\   diagSignHintText: 'H>',
	\   diagSignInfoText: 'I>',
	\   diagSignWarningText: 'W>',
	\   echoSignature: v:false,
	\   hideDisabledCodeActions: v:false,
	\   highlightDiagInline: v:true,
	\   hoverInPreview: v:false,
	\   ignoreMissingServer: v:false,
	\   keepFocusInDiags: v:true,
	\   keepFocusInReferences: v:true,
	\   completionTextEdit: v:true,
	\   diagVirtualTextAlign: 'above',
	\   diagVirtualTextWrap: 'default',
	\   noNewlineInCompletion: v:false,
	\   omniComplete: v:true,
	\   outlineOnRight: v:false,
	\   outlineWinSize: 30,
	\   semanticHighlight: v:true,
	\   showDiagInBalloon: v:true,
	\   showDiagInPopup: v:true,
	\   showDiagOnStatusLine: v:true,
	\   showDiagWithSign: v:true,
	\   showDiagWithVirtualText: v:false,
	\   showInlayHints: v:true,
	\   showSignature: v:true,
	\   snippetSupport: v:false,
	\   ultisnipsSupport: v:false,
	\   useBufferCompletion: v:false,
	\   usePopupInCodeAction: v:true,
	\   useQuickfixForLocations: v:false,
	\   vsnipSupport: v:false,
	\   bufferCompletionTimeout: 100,
	\   customCompletionKinds: v:true,
	\   completionKinds: {},
	\   filterCompletionDuplicates: v:true,
\ }
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [#{
\	name: 'go',
\	filetype: ['go', 'gomod'],
\	path: 'gopls',
\	args: [''],
\	syncInit: v:true,
\   workspaceConfig: #{
\		gopls: #{
\			hints: #{
\				assignVariableTypes: v:true,
\				compositeLiteralFields: v:true,
\				compositeLiteralTypes: v:true,
\				constantValues: v:true,
\				functionTypeParameters: v:true,
\				parameterNames: v:true,
\				rangeVariableTypes: v:true
\			}
\		}
\	}
\ },#{
\	name: 'Zig',
\	filetype: ['zig'],
\	path: 'zls',
\	args: [''],
\	syncInit: v:true
\ },#{
\	name: 'Nim',
\	filetype: ['nim'],
\	path: expand('~\.nimble\bin\nimlsp'),
\	args: [''],
\	syncInit: v:true
\ }]
autocmd User LspSetup call LspAddServer(lspServers)

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction