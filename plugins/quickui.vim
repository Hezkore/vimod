" QuickUI - Quick access menu
Plug 'skywind3000/vim-quickui'

" Settings that can be set before the plugin is loaded
let g:enabled_quickmenu = 1
let g:quickui_color_scheme = 'system' " Try to match the system color scheme
let g:quickui_border_style = 2
let g:quickui_show_tip = 1 " Show tips in the command line
let g:quickui_protect_hjkl = 1 " Give menu items priority over hjkl movement

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
	
	" Clear all the menus
	call quickui#menu#reset()
	
	function! WriteOrPrompt()
		try
			write
		catch
			call WriteAsWithPrompt()
		endtry
	endfunction
	
	function! WriteAsWithPrompt()
		" Default to the current file's directory
		let name = quickui#input#open('Enter file name: ', "Saves to " . expand('%:p:h'))
		if name != ""
			exec 'saveas ' . name
		endif
	endfunction
	
	" Buffer menu
	call quickui#menu#install('&Buffer', [
		\ [ "&New\t%{LeaderKey()}+n", 'enew' ],
		\ [ "--", '' ],
		\ [ "&Write", 'call WriteOrPrompt()' ],
		\ [ "Write As...", 'call WriteAsWithPrompt()' ],
		\ [ "--", '' ],
		\ [ "&Close\t%{LeaderKey()}+q", 'bp! | bd! #' ],
		\ [ "Reopen Las&t\t%{LeaderKey()}+t", 'e#' ],
		\ [ "--", '' ],
		\ [ "Next\t%{LeaderKey()}+l\\%{LeaderKey()}+k", 'bnext' ],
		\ [ "Previous\t%{LeaderKey()}+h\\%{LeaderKey()}+j", 'bprevious' ],
		\ [ "--", '' ],
		\ [ "&List All Buffers\t%{LeaderKey()}+lb", 'CtrlPBuffer' ],
		\ [ "--", '' ],
		\ [ "Save All", 'wa' ],
		\ [ "Close All", 'qa' ],
	\ ])
	
	" Window menu
	call quickui#menu#install('&Window', [
		\ [ "&Split Horizontal\t\Ctrl+ws", 'split' ],
		\ [ "Split &Vertical\tCtrl+wv", 'vsplit' ],
		\ [ "--", '' ],
		\ [ "&Close\t\Ctrl+wq", 'close' ],
		\ [ "Close &All", 'qa' ],
		\ [ "--", '' ],
		\ [ "Next", 'wincmd w' ],
		\ [ "Previous", 'wincmd W' ],
		\ [ "--", '' ],
		\ [ "Move Up", 'wincmd k' ],
		\ [ "Move Down", 'wincmd j' ],
		\ [ "Move Left", 'wincmd h' ],
		\ [ "Move Right", 'wincmd l' ],
		\ [ "--", '' ],
		\ [ "&Equalize", 'wincmd =', 'Equalize all window sizes' ],
		\ [ "Equalize Height", 'wincmd _=', 'Equalize the height of all windows' ],
		\ [ "Equalize Width", 'wincmd |=', 'Equalize the width of all windows' ],
	\ ])
	
	" NetRw menu
	call quickui#menu#install('&NetRw', [
		\ [ "&Open Explorer\t%{LeaderKey()}+o", 'call ToggleOrFocusLexplore()' ],
		\ [ "--", '' ],
		\ [ "Change &Directory\t%{LeaderKey()}+cd", 'cd %:p:h | pwd', 'Change directory to the current buffer' ],
	\ ])
	
	" Spelling menu
	call quickui#menu#install('&Spelling', [
		\ [ "%{&spell? 'Disable':'Enable'} &Spell Checking", 'set spell!', 'Toggle spell checking' ],
	\ ])
	
	" Terminal menu
	call quickui#menu#install('&Terminal', [
		\ [ "New &Terminal", 'bot terminal ++rows=15', "Open a new terminal" ],
		\ [ "New Terminal &Persistent", 'bot terminal ++rows=15 ++noclose', "Open a new terminal that becomes an editable buffer" ],
		\ [ "Make &Window Terminal", 'terminal ++curwin', "Convert the current window into a terminal" ],
	\ ])
	
	" Copilot menu
	if exists('g:enabled_copilot') && g:enabled_copilot == 1
		call quickui#menu#install('&Copilot', [
			\ ["%{copilot#Enabled()==1? 'Disable':'Enable'} Copilot", 'call ToggleCopilot() | Copilot status'],
			\ ["--", ''],
			\ ["Show Suggestion &Panel\t%{LeaderKey()}+cp", 'Copilot panel'],
		\ ])
	endif
	
	" If the LSP server is installed, add the LSP menu
	if exists('g:enabled_lsp') && g:enabled_lsp == 1
		" LSP quick menu
		call quickui#menu#install('&LSP', [
			\ ["&Format Document", 'LspDocumentFormat', "Format the entire document"],
			\ ["Format Se&lection", 'LspDocumentRangeFormat', "Format the selected text"],
			\ ["--"],
			\ ["Show &Symbols", 'LspDocumentSymbol', "Display symbols in the current document"],
			\ ["Find Symb&ols", 'LspWorkspaceSymbol', "Search for symbols across the workspace"],
			\ ["--"],
			\ ["Show &Diagnostics", 'LspDocumentDiagnostics', "Display diagnostics for the current document"],
			\ ["&Next Diagnostic", 'LspNextDiagnostic', "Navigate to the next diagnostic issue"],
			\ ["&Previous Diagnostic", 'LspPreviousDiagnostic', "Navigate to the previous diagnostic issue"],
			\ ["--"],
			\ ["Show Conte&xt Menu\tK", 'call quickui#tools#clever_context("k", g:context_menu_k, {})', "Show the context menu for the current LSP server"],
			\ ["--"],
			\ ["%{LspRunningForBuffer()==1? 'S&top':'S&tart'} LSP", 'call LspToggleState()'],
			\ ["%{LspRunningForBuffer()==1? '&Update':'&Install'} LSP Server", 'LspInstallServer'],
			\ ["&Manage LSP Servers", 'LspManageServers'],
		\ ])
		
		" LSP context menu
		let g:context_menu_k = [
			\ ["Peek &Definition", 'LspPeekDefinition', "Preview the definition of the symbol under the cursor"],
			\ ["Peek Declaration", 'LspPeekDeclaration', "Preview the declaration of the symbol under the cursor"],
			\ ["Peek Implementation", 'LspPeekImplementation', "Preview the implementation of the symbol under the cursor"],
			\ ["Peek Type Definition", 'LspPeekTypeDefinition', "Preview the type definition of the symbol under the cursor"],
			\ ["--"],
			\ ["&Go to Definition", 'LspDefinition', "Navigate to the definition of the symbol under the cursor"],
			\ ["Go to D&eclaration", 'LspDeclaration', "Navigate to the declaration of the symbol under the cursor"],
			\ ["Go to I&mplementation", 'LspImplementation', "Navigate to the implementation of the symbol under the cursor"],
			\ ["Go to &Type Definition", 'LspTypeDefinition', "Navigate to the type definition of the symbol under the cursor"],
			\ ["--"],
			\ ["Show Hover &Info", 'LspHover', "Display hover information for the symbol under the cursor"],
			\ ["Show Code &Actions", 'LspCodeAction --ui', "List available quick fixes for the current file"],
			\ ["Show Code&Lens", 'LspCodeLens', "List executable CodeLens commands for the current document"],
			\ ["--"],
			\ ["&Rename Symbol", 'LspRename', "Rename the symbol under the cursor across the project"],
			\ ["--"],
			\ ["&Find References", 'LspReferences', "Find all references to the symbol under the cursor"],
			\ ["&Next Reference", 'LspNextReference', "Navigate to the next reference of the symbol under the cursor"],
			\ ["&Previous Reference", 'LspPreviousReference', "Navigate to the previous reference of the symbol under the cursor"],
			\ ["--"],
			\ ["View Type Hierarchy", 'LspTypeHierarchy', "View the type hierarchy of the symbol under the cursor"],
			\ ["Incoming Call Hierarchy", 'LspCallHierarchyIncoming', "Display incoming call hierarchy for the symbol under the cursor"],
			\ ["Outgoing Call Hierarchy", 'LspCallHierarchyOutgoing', "Display outgoing call hierarchy for the symbol under the cursor"],
		\ ]
	else
		" LSP not installed
		call quickui#menu#install('&LSP', [
			\ ['&LSP not installed', ''],
		\ ])
	endif
endfunction