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
		else
			echo "No file name provided"
		endif
	endfunction
	
	function! SaveSessionWithPrompt()
		let name = quickui#input#open('Enter session name: ', g:current_session != '' ? g:current_session : 'My Session')
		if name != ""
			call MakeSession( name )
		else
			echo "No session name provided"
		endif
		
		" Redo the menu
		call AddSessionList()
	endfunction
	
	function! RemoveSessionWithList()
		let session_list = ProduceSessionList()
		let linelist = []
		let index = 0
		for session in session_list
			let index += 1
			if index < 10
				let linelist += [["&" . index . ". " .session, session]]
			else
				let linelist += [[index . ". " .session, session]]
			endif
		endfor
		" restore last position in previous listbox
		let opts = {'title': 'Select a session to remove'}
		let l:selection = quickui#listbox#inputlist(linelist, opts)
		if l:selection == -1
			echo "No session selected"
			return
		else
			echo "Remove session \"" . linelist[l:selection][1] . "\"?"
		endif
		
		" Ask if user is sure
		let question = "Are you sure you want to remove the session:\n\"" . linelist[l:selection][1] . "\"?"
		let choices = "&Yes\n&No"
		let choice = quickui#confirm#open(question, choices, 2, 'Confirm')
		if choice == 1
			call RemoveSession( linelist[l:selection][1] )
			" Redo the menu
			call AddSessionList()
		else
			echo "No session removed"
		endif
	endfunction
	
	function! AddSessionList()
		"if exists('g:enabled_sessions') && g:enabled_sessions == 1
			call quickui#menu#clear('&Sessions')
			
			call quickui#menu#install('&Sessions', [
				\ ["&Save As...", 'call SaveSessionWithPrompt()', "Save the current session"],
			\ ])
			
			if g:last_session != ''
				call quickui#menu#install('&Sessions', [
					\ ["&Load Last", 'call LoadSession( "' . g:last_session . '" )', "Load the session \"" . g:last_session . "\""],
				\ ])
			endif
			
			let session_list = ProduceSessionList()
			if len(session_list) > 0
				call quickui#menu#install('&Sessions', [
					\ ["--"],
					\ ["&Remove...", 'call RemoveSessionWithList()', "Remove a session"],
					\ ["--"],
				\ ])
				for session in session_list
					call quickui#menu#install('&Sessions', [
						\ [session, 'call LoadSession("' . session . '")', "Load session \"" . session . "\""],
					\ ])
				endfor
			endif
			
			call quickui#menu#change_weight('&Sessions', 2)
		"endif
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
	\ ], 1)
	
	" Sessions menu
	if exists('g:enabled_sessions') && g:enabled_sessions == 1
		" Session list
		call AddSessionList()
	endif
	
	" NetRw menu
	call quickui#menu#install('&NetRw', [
		\ [ "&Open Explorer\t%{LeaderKey()}+o", 'call ToggleOrFocusLexplore()' ],
		\ [ "--", '' ],
		\ [ "Change &Directory\t%{LeaderKey()}+cd", 'cd %:p:h | pwd', 'Change directory to the current buffer' ],
	\ ], 3)
	
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
	\ ], 4)
	
	" Terminal menu
	call quickui#menu#install('&Terminal', [
		\ [ "New &Terminal", 'bot terminal ++rows=15', "Open a new terminal" ],
		\ [ "New Terminal &Persistent", 'bot terminal ++rows=15 ++noclose', "Open a new terminal that becomes an editable buffer" ],
		\ [ "Make &Window Terminal", 'terminal ++curwin', "Convert the current window into a terminal" ],
	\ ], 5)
	
	" Copilot menu
	if exists('g:enabled_copilot') && g:enabled_copilot == 1
		call quickui#menu#install('&Copilot', [
			\ ["%{copilot#Enabled()==1? 'Disable':'Enable'} Copilot", 'call ToggleCopilot() | Copilot status'],
			\ ["--", ''],
			\ ["Show Suggestion &Panel\t%{LeaderKey()}+cp", 'Copilot panel'],
		\ ], 6)
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
		\ ],7)
		
		" LSP context menu
		let g:context_menu_k = [
			\ ["Peek &Definition", 'LspPeekDefinition', "Preview the definition of the symbol under the cursor"],
			\ ["Peek Declaration", 'LspPeekDeclaration', "Preview the declaration of the symbol under the cursor"],
			\ ["Peek Implementation", 'LspPeekImplementation', "Preview the implementation of the symbol under the cursor"],
			\ ["Peek Type Definition", 'LspPeekTypeDefinition', "Preview the type definition of the symbol under the cursor"],
			\ ["--"],
			\ ["&Go to Definition", 'horizontal LspDefinition', "Navigate to the definition of the symbol under the cursor"],
			\ ["Go to D&eclaration", 'horizontal LspDeclaration', "Navigate to the declaration of the symbol under the cursor"],
			\ ["Go to I&mplementation", 'horizontal LspImplementation', "Navigate to the implementation of the symbol under the cursor"],
			\ ["Go to &Type Definition", 'horizontal LspTypeDefinition', "Navigate to the type definition of the symbol under the cursor"],
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
		\ ],7)
	endif
	
	" Options menu
	call quickui#menu#install('&Options', [
		\ ["&Edit Vim Configuration", 'Settings', "Edit the Vim configuration file"],
		\ ["&Reload Vim Configuration", 'ApplySettings', "Reload the Vim configuration file"],
		\ ["--", ''],
		\ [ "%{&spell? 'Disable':'Enable'} &Spell Checking", 'set spell!', 'Toggle spell checking' ],
	\ ],8)
endfunction