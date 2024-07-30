" QuickUI - Quick access menu
Plug 'skywind3000/vim-quickui'

" Settings that can be set before the plugin is loaded
let g:enabled_quickmenu = get(g:, 'enabled_quickmenu', 1)
let g:quickui_color_scheme = get(g:, 'quickui_color_scheme', 'system')
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
		let name = input('Enter file name: ', expand('%:p:h') . g:path_separator . expand('%:t'))
		if name != ""
			exec 'saveas ' . name
		else
			echo "No file name provided"
		endif
	endfunction
	
	function! SaveSessionWithPrompt()
		let name = input('Enter session name: ', g:current_session != '' ? g:current_session : 'My Session')
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
			\ ["&Save Session As...", 'call SaveSessionWithPrompt()', "Save the current session"],
		\ ])
		
		if g:last_session != ''
			call quickui#menu#install('&Sessions', [
				\ ["&Load Last Session", 'call LoadSession( "' . g:last_session . '" )', "Load the session \"" . g:last_session . "\""],
			\ ])
		endif
		
		let session_list = ProduceSessionList()
		if len(session_list) > 0
			call quickui#menu#install('&Sessions', [
				\ ["--"],
				\ ["&Remove Session...", 'call RemoveSessionWithList()', "Remove a session"],
				\ ["--"],
			\ ])
			for session in session_list
				call quickui#menu#install('&Sessions', [
					\ [session, 'call LoadSession("' . session . '")', "Load session \"" . session . "\""],
				\ ])
			endfor
		endif
		
		call quickui#menu#change_weight('&Sessions', 300)
		"endif
	endfunction
	
	function! SaveBookmarkWithPrompt()
		let name = input('Enter bookmark name: ', '')
		if name != ""
			" Make sure name has no spaces
			let name = substitute(name, ' ', '_', 'g')
		else
			echo "No bookmark name provided"
		endif
		
		" Ask for path
		let path = input('Enter bookmark path: ', expand('%:p:h'))
		if path != ""
			" Make sure path exists
			if !isdirectory(path)
				echo "Path does not exist"
				return
			else
				" Remove
				call AddNERDTreeBookmark( name, path )
				" Rebuild menu
				call AddNERDTreeList()
			endif
		else
			echo "No bookmark path provided"
		endif
	endfunction
	
	function! RemoveBookmarkWithList()
		let bookmarks = ProduceNERDTreeBookmarksList()
		let linelist = []
		let index = 0
		for bookmark in keys(bookmarks)
			let index += 1
			if index < 10
				let linelist += [["&" . index . ". " .bookmark, bookmark]]
			else
				let linelist += [[index . ". " .bookmark, bookmark]]
			endif
		endfor
		" restore last position in previous listbox
		let opts = {'title': 'Select a bookmark to remove'}
		let l:selection = quickui#listbox#inputlist(linelist, opts)
		if l:selection == -1
			echo "No bookmark selected"
			return
		endif
		
		" Ask if user is sure
		let question = "Are you sure you want to remove the bookmark:\n\"" . linelist[l:selection][1] . "\"?"
		let choices = "&Yes\n&No"
		let choice = quickui#confirm#open(question, choices, 2, 'Confirm')
		if choice == 1
			" Remove the bookmark
			call RemoveNERDTreeBookmark( linelist[l:selection][1] )
			" Rebuild menu
			call AddNERDTreeList()
		else
			echo "No bookmark removed"
		endif
	endfunction
	
	function! AddNERDTreeList()
		call quickui#menu#clear('&Explorer')
		
		call quickui#menu#install('&Explorer', [
			\ [ "&Open File Explorer\t%{LeaderKey()}+o", 'NERDTreeFocus' ],
			\ [ "&Find Current File\t%{LeaderKey()}+f", 'NERDTreeFind', 'Find the current file' ],
			\ [ "--", '' ],
			\ [ "Change &Directory\t%{LeaderKey()}+c+d", 'cd %:p:h | pwd', 'Change directory to the current buffer' ],
		\ ])
		
		call quickui#menu#install('&Explorer', [
			\ ["--", ''],
			\ ["&Add Bookmark...", 'call SaveBookmarkWithPrompt()', 'Add a bookmark'],
			\ ["&Edit Bookmarks", 'call g:NERDTreeBookmark.Edit()', 'Edit the bookmarks file'],
			\ ["--", ''],
			\ ["&Remove Bookmark...", 'call RemoveBookmarkWithList()', 'Remove a bookmark'],
		\ ])
		
		let bookmarks = ProduceNERDTreeBookmarksList()
		if len(bookmarks) > 0
			call quickui#menu#install('&Explorer', [
				\ ["--"],
			\ ])
			for bookmark in keys(bookmarks)
				call quickui#menu#install('&Explorer', [
					\ [bookmark, 'NERDTreeFromBookmark ' . bookmarks[bookmark], 'Open bookmarked directory'],
				\ ])
			endfor
		endif
		
		call quickui#menu#change_weight('&Explorer', 200)
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
		\ [ "Close Scratch Buffers", 'call CloseUnmodifiedBuffers()', 'Close all unmodified scratch buffers' ],
		\ [ "--", '' ],
		\ [ "Next\t%{LeaderKey()}+l\\%{LeaderKey()}+k", 'bnext' ],
		\ [ "Previous\t%{LeaderKey()}+h\\%{LeaderKey()}+j", 'bprevious' ],
		\ [ "--", '' ],
		\ [ "&List All Buffers\t%{LeaderKey()}+b", 'Buffers' ],
		\ [ "--", '' ],
		\ [ "Save All", 'wa' ],
		\ [ "Close All", 'qa' ],
	\ ], 100)
	
	
	" NetRw menu or NERDTree
	if exists('g:enabled_nerdtree') && g:enabled_nerdtree == 1
		" NERDTree
		call AddNERDTreeList()
	else
		" NetRw
		call quickui#menu#install('&Explorer', [
			\ [ "&Open File Explorer\t%{LeaderKey()}+o", 'call ToggleOrFocusLexplore()' ],
			\ [ "--", '' ],
			\ [ "Change &Directory\t%{LeaderKey()}+c+d", 'cd %:p:h | pwd', 'Change directory to the current buffer' ],
		\ ], 200)
	endif
	
	" Sessions menu
	if exists('g:enabled_sessions') && g:enabled_sessions == 1
		" Session list
		call AddSessionList()
	endif
	
	" Window menu
	call quickui#menu#install('&Window', [
		\ [ "&Split Horizontal\t\Ctrl+w+s", 'split' ],
		\ [ "Split &Vertical\tCtrl+w+v", 'vsplit' ],
		\ [ "--", '' ],
		\ [ "&Close\t\Ctrl+w+q", 'close' ],
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
	\ ], 400)
	
	" Terminal menu
	call quickui#menu#install('&Terminal', [
		\ [ "New &Terminal", 'bot terminal ++rows=15', "Open a new terminal" ],
		\ [ "New Terminal &Persistent", 'bot terminal ++rows=15 ++noclose', "Open a new terminal that becomes an editable buffer" ],
		\ [ "Make &Window Terminal", 'terminal ++curwin', "Convert the current window into a terminal" ],
	\ ], 500)
	
	" Fzf/Find menu
	if exists('g:enabled_fzf') && g:enabled_fzf == 1
		function! CommandHistoryQuery()
			let query = input("query: ")
			if query != ""
				Locate query
			endif
		endfunction
		
		call quickui#menu#install('&Find', [
			\ ["Find &Files\t%{LeaderKey()}+p\tCtrl+p", 'call FindFilesInCurrentDir()', "Files in the current directory"],
			\ ["Find &Buffers\t%{LeaderKey()}+b", 'Buffers', "Currently open buffers"],
			\ ["Find L&ines", 'Lines', "Lines across all open buffers"],
			\ ["Find Buffer &Lines", 'BLines', "Lines in the current buffer"],
			\ ["--", ""],
			\ ["Find Commands", 'Commands', "All available commands"],
			\ ["Find Command History", 'History:', "Executed command history"],
			\ ["Find Command Output", 'call CommandHistoryQuery()', "Output of a command"],
			\ ["--", ""],
			\ ["Find File History", 'History', "v:oldfiles and open buffers"],
			\ ["Find Search History", 'History/', "Search history"],
			\ ["Find Jump History", 'Jumps', "Position jump history"],
			\ ["--", ""],
			\ ["Find Normal Mappings", 'call fzf#vim#maps("n", 0)', "Normal mode mappings"],
			\ ["Find Insert Mappings", 'call fzf#vim#maps("i", 0)', "Insert mode mappings"],
			\ ["Find Visual Mappings", 'call fzf#vim#maps("v", 0)', "Visual mode mappings"],
			\ ["Find Command Mappings", 'call fzf#vim#maps("c", 0)', "Command mode mappings"],
			\ ["Find Terminal Mappings", 'call fzf#vim#maps("t", 0)', "Terminal mode mappings"],
			\ ["--", ""],
			\ ["Find Marks", 'Marks', "Marks created by pressing m. Press ' {symbol} to jump to a mark"],
			\ ["Find Windows", 'Windows', "Windows"],
			\ ["Find Changelist", 'Changes', "Changelist across all open buffers"],
			\ ["Find Colors Schemes", 'Colors', "Search for color schemes"],
			\ ["Find File Types", 'Filetypes', "File types"],
		\ ], 600)
	endif
	
	" Fugitive / Git menu
	if exists('g:enabled_fugitive') && g:enabled_fugitive == 1
		call quickui#menu#install('&Git', [
			\ ["&Open Git", 'Git', "Open the Git status window"],
			\ ["--", ""],
			\ ["Open &Difference", 'Gdiffsplit', "Diff staged version of the file side by side with the working tree version"],
			\ ["Open Git &Blame", 'Git blame', "Blame the current file"],
			\ ["Open Git &Log", 'Gclog', "Load commit history into the quickfix list"],
			\ ["--", ""],
		\ ])
		
		if exists('g:enabled_fzf') && g:enabled_fzf == 1
			call quickui#menu#install('&Git', [
				\ ["Find Git &Files", 'GFiles', "Git files (git ls-files)"],
				\ ["Find Git &Status Files", 'GFiles?', "Git files (git status)"],
				\ ["Find Git &Commits", 'Commits', "Git commits"],
				\ ["Find Git B&uffer Commits", 'BCommits', "Git commits for the current buffer; visual-select lines to track changes in the range"],
			\ ])
		endif
		
		" Add Github gh cli menu, even if gh is not installed
		call quickui#menu#install('&Git', [
			\ ["--", ""],
			\ ["Open &Pull Requests", 'call OpenGithubPullRequests()', "Open the pull requests for the current repository (requires gh)"],
			\ ["Open &Issues", 'call OpenGithubIssues()', "Open the issues for the current repository (requires gh)"],
			\ ["Search Issues", 'call SearchGithubIssues()', "Search for issues in the current repository (requires gh)"],
			\ ["Open &Repository", 'call OpenGithubRepository()', "Open the repository for the current file (requires gh)"],
		\ ])
		
		call quickui#menu#change_weight('&Git', 700)
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
		\ ],800)
		
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
			\ ["T&oggle Fold", 'call ToggleFold()', "Toggle folding of the current code block"],
			\ ["Fold All", 'call CloseAllFolds()', "Fold all code blocks"],
			\ ["Unfold All", 'call OpenAllFolds()', "Unfold all code blocks"],
			\ ["--"],
			\ ["View Type Hierarchy", 'LspTypeHierarchy', "View the type hierarchy of the symbol under the cursor"],
			\ ["Incoming Call Hierarchy", 'LspCallHierarchyIncoming', "Display incoming call hierarchy for the symbol under the cursor"],
			\ ["Outgoing Call Hierarchy", 'LspCallHierarchyOutgoing', "Display outgoing call hierarchy for the symbol under the cursor"],
		\ ]
	else
		" LSP not installed
		call quickui#menu#install('&LSP', [
			\ ['&LSP not installed', ''],
		\ ],800)
	endif
	
	" Copilot menu
	if exists('g:enabled_copilot') && g:enabled_copilot == 1
		call quickui#menu#install('&Copilot', [
			\ ["%{copilot#Enabled()==1? 'Disable':'Enable'} Copilot", 'call ToggleCopilot() | Copilot status'],
			\ ["--", ''],
			\ ["Show Suggestion &Panel\t%{LeaderKey()}+c+p", 'Copilot panel'],
		\ ], 900)
	endif

	" Options menu
	call quickui#menu#install('&Options', [
		\ ["&Edit Vim Configuration", 'Settings', "Edit the Vim configuration file"],
		\ ["&Reload Vim Configuration", 'ApplySettings', "Reload the Vim configuration file"],
		\ ["--", ''],
		\ [ "%{&spell? 'Disable':'Enable'} &Spell Checking", 'set spell!', 'Toggle spell checking' ],
	\ ],1000)
endfunction

" Helper functions

" Show error message for missing GitHub CLI tool
function! ShowGithubCliError()
	"Give the user a link to https://cli.github.com/
	call quickui#confirm#open("The GitHub CLI tool (gh) must be installed.\n\nDownload from:\nhttps://cli.github.com", "&OK", 0, "Error")
endfunction

" Function for displaying open pull requests
function! OpenGithubPullRequests()
	" Does the user have gh?
	if !g:has_github_cli
		call ShowGithubCliError()
		return
	endif
	
	let pr_list = ProduceGithubPullRequestList()
	if len(pr_list) == 0
		echo "No pull requests found"
		return
	endif
	
	let linelist = []
	let pr_numbers = []
	let index = 0
	for pr in pr_list
		let index += 1
		let title = string(pr['title'])
		let url = string(pr['url'])
		let number = pr['number']
		let listTitle = title . " (" . pr['headRefName'] . ") \t" . pr['author']['login']
		call add(pr_numbers, number)
		if index < 10
			call add(linelist, ["&" . index . ". " . listTitle, url])
		else
			call add(linelist, [index . ". " . listTitle, url])
		endif
	endfor

	" restore last position in previous listbox
	let opts = {'title': 'Select a pull request to view'}
	let l:selection = quickui#listbox#inputlist(linelist, opts)
	if l:selection == -1
		echo "No pull request selected"
		return
	endif

	" Get the pull request number
	let pr_number = pr_numbers[l:selection]

	" Get the pull request via ProduceGithubPullRequestJson
	let pr_json = ProduceGithubPullRequestJson(pr_number)
	let description = has_key(pr_json, 'body') ? pr_json['body'] : "No description provided."
	let description_lines = split(description, '\n')
	let cleaned_description_lines = map(description_lines, 'substitute(v:val, "\r", "", "g")')

	" Prepare the content for the confirm dialog
	let content = [
		\ "Title: " . pr_json['title'],
		\ "Author: " . pr_json['author']['login'],
		\ "",
		\ "Created At: " . FormatTimestamp(pr_json['createdAt']),
		\ "Updated At: " . FormatTimestamp(pr_json['updatedAt']),
		\ "",
		\ "URL: " . pr_json['url'],
		\ "Branch: " . pr_json['headRefName'],
		\ "",
		\ "Description:"
	\] + cleaned_description_lines

	" Join the content into a single string for the dialog
	let choices = "&View Files\n&Close"
	
	" Open the confirm dialog and get the user's choice
	let choice = quickui#confirm#open(content, choices, 0, 'Pull request #' . pr_number)

	" Check the user's choice
	if choice == 1
		" User chose "View Files"
		" Open the diff view to compare the changes
		call OpenDiffView(pr_number)
	endif
endfunction

function! OpenDiffView(pr_number)
	" Store the pull request number in a global variable
	let g:pr_number = a:pr_number

	" Get the list of modified files with line changes in the pull request
	let pr_files_command = 'gh pr view ' . a:pr_number . ' --json files --jq ".files[] | {path: .path, additions: .additions, deletions: .deletions}"'
	let pr_files_output = system(pr_files_command)

	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the list of modified files for pull request #" . a:pr_number
		return
	endif

	" Clean the JSON output by removing null characters
	let pr_files_output = substitute(pr_files_output, '\c\%x00', '', 'g')

	" Debug: Print the JSON output
	echom "JSON Output: " . pr_files_output

	" Convert concatenated JSON objects into a JSON array
	let pr_files_output = '[' . substitute(pr_files_output, '}\s*{', '},{', 'g') . ']'

	" Parse the JSON output
	let modified_files = json_decode(pr_files_output)

	" Ensure modified_files is a list
	if type(modified_files) == type({})
		let modified_files = [modified_files]
	elseif type(modified_files) != type([])
		echo "Error: Unexpected JSON format"
		return
	endif

	" Open a small window at the top of the screen to list the modified files
	top new
	setlocal buftype=nofile
	setlocal bufhidden=wipe
	setlocal noswapfile
	setlocal nobuflisted
	call setline(1, ['Select a file to view changes:'] + map(copy(modified_files), 'v:val["path"] . " (+" . string(v:val["additions"]) . "/-" . string(v:val["deletions"]) . ")"'))
	setfiletype diff
	file ModifiedFilesList
	setlocal readonly
	setlocal nonumber
	setlocal norelativenumber
	setlocal signcolumn=no

	" Move the cursor to the first file in the list
	call cursor(2, 1)

	" Map <Enter> to open the selected file and show changes
	nnoremap <buffer> <silent> <CR> :call OpenFileDiff()<CR>
endfunction

function! OpenFileDiff()
	" Get the current line (file name)
	let file_line = getline('.')

	" Skip the title line
	if file_line =~ '^Select a file to view changes:'
		return
	endif

	" Extract the actual file name
	let file_name = matchstr(file_line, '\v^.*\ze\s\(\+\d+\/\-\d+\)$')

	" Get the full diff for the pull request
	let pr_diff_command = 'gh pr diff ' . g:pr_number
	let pr_diff_output = system(pr_diff_command)

	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the diff for pull request #" . g:pr_number
		return
	endif

	" Extract the diff section for the selected file
	let file_diff = []
	let in_diff_section = 0
	for line in split(pr_diff_output, "\n")
		if line =~ '^diff --git a/' . file_name . ' '
			let in_diff_section = 1
		elseif line =~ '^diff --git a/' && in_diff_section
			break
		endif
		if in_diff_section
			call add(file_diff, line)
		endif
	endfor

	" Check if a buffer named 'DiffPreview' already exists and delete it
	let bufnum = bufnr('DiffPreview')
	if bufnum != -1
		execute 'bdelete! ' . bufnum
	endif

	" Open the diff in a new vertical split window to the right
	vsplit new
	setlocal buftype=nofile
	setlocal bufhidden=wipe
	setlocal noswapfile
	setlocal nobuflisted
	" Temporarily disable readonly to set the buffer content
	setlocal noreadonly
	call setline(1, file_diff)
	setfiletype diff
	file DiffPreview
	" Re-enable readonly after setting the buffer content
	setlocal readonly
endfunction

function! OpenGithubIssues()
	" Does the user have gh?
	if !g:has_github_cli
		call ShowGithubCliError()
		return
	endif
	
	" List the issues for the current repository
	let issues_command = 'gh issue list --json number,title,url,author,createdAt,updatedAt'
	let issues_output = system(issues_command)
	
	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the list of issues for the current repository"
		return
	endif
	
	" Parse the JSON output
	let issues = json_decode(issues_output)
	if len(issues) == 0
		echo "No issues found"
		return
	endif
	
	" Ensure issues is a list
	if type(issues) == type({})
		let issues = [issues]
	elseif type(issues) != type([])
		echo "Error: Unexpected JSON format"
		return
	endif
	
	" Prepare the list of issues for the menu
	let linelist = []
	let issue_numbers = []
	let index = 0
	for issue in issues
		let index += 1
		let title = string(issue['title'])
		let url = string(issue['url'])
		let number = issue['number']
		let listTitle = title . "\t" . issue['author']['login']
		call add(issue_numbers, number)
		if index < 10
			call add(linelist, ["&" . index . ". " . listTitle, url])
		else
			call add(linelist, [index . ". " . listTitle, url])
		endif
	endfor
	
	" restore last position in previous listbox
	let opts = {'title': 'Select an issue to view'}
	let l:selection = quickui#listbox#inputlist(linelist, opts)
	if l:selection == -1
		echo "No issue selected"
		return
	endif
	
	call ShowGithubIssue( issue_numbers[l:selection] )
endfunction

function! SearchGithubIssues(term='')
	" Does the user have gh?
	if !g:has_github_cli
		call ShowGithubCliError()
		return
	endif
	
	" Was there a term provided?
	let search_term = a:term
	if search_term == ''
		" Ask the user for a search term
		let search_term = input('query: ')
		if search_term == ''
			echo "No search term provided"
			return
		endif
	endif
	
	" Search for the issue
	let search_command = 'gh issue list --json number,title,url,author,createdAt,updatedAt --search "' . search_term . '"'
	let search_output = system(search_command)
	
	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the list of issues for the current repository"
		return
	endif
	
	" Parse the JSON output
	let issues = json_decode(search_output)
	if len(issues) == 0
		echo "No issues found matching the search term"
		return
	endif
	
	" Ensure issues is a list
	if type(issues) == type({})
		let issues = [issues]
	elseif type(issues) != type([])
		echo "Error: Unexpected JSON format"
		return
	endif
	
	" Prepare the list of issues for the menu
	let linelist = []
	let issue_numbers = []
	let index = 0
	for issue in issues
		let index += 1
		let title = string(issue['title'])
		let url = string(issue['url'])
		let number = issue['number']
		let listTitle = title . "\t" . issue['author']['login']
		call add(issue_numbers, number)
		if index < 10
			call add(linelist, ["&" . index . ". " . listTitle, url])
		else
			call add(linelist, [index . ". " . listTitle, url])
		endif
	endfor
	
	" restore last position in previous listbox
	let opts = {'title': 'Select an issue to view'}
	let l:selection = quickui#listbox#inputlist(linelist, opts)
	if l:selection == -1
		echo "No issue selected"
		return
	endif
	
	call ShowGithubIssue( issue_numbers[l:selection] )
endfunction

function! ShowGithubIssue(issue_number)
	" Get the issue via ProduceGithubIssueJson
	let issue_json = ProduceGithubIssueJson(a:issue_number)
	let description = has_key(issue_json, 'body') ? issue_json['body'] : "No description provided."
	let description_lines = split(description, '\n')
	let cleaned_description_lines = map(description_lines, 'substitute(v:val, "\r", "", "g")')
	
	" Show a quickui#textbox#open
	let content = [
		\ "Title: " . issue_json['title'],
		\ "Author: " . issue_json['author']['login'],
		\ "",
		\ "Created At: " . FormatTimestamp(issue_json['createdAt']),
		\ "Updated At: " . FormatTimestamp(issue_json['updatedAt']),
		\ "",
		\ "URL: " . issue_json['url'],
		\ "",
		\ "Description:"
	\] + cleaned_description_lines
	
	let opts = {"close":"button", "title":"Issue #" . a:issue_number}
	call quickui#textbox#open(content, opts)
endfunction

function! OpenGithubRepository()
	" Does the user have gh?
	if !g:has_github_cli
		call ShowGithubCliError()
		return
	endif
	
	" Get the repository URL
	let repo_info = system('gh repo view --json url')
	
	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the repository URL"
		return
	endif
	
	" Parse the JSON output
	let repo_info = json_decode(repo_info)
	
	" Extract the URL from the JSON object
	let repo_url = repo_info.url
	
	" Ensure repo_url is a string
	if type(repo_url) != type("")
		echo "Error: Unexpected JSON format"
		return
	endif
	
	" Detect the operating system and open the URL in the default browser
	if has('win32') || has('win64')
		call system('start ' . repo_url)
	elseif has('macunix')
		call system('open ' . repo_url)
	else
		call system('xdg-open ' . repo_url)
	endif
	
	" Show a message in the command line
	echo "Opening the repository in the default browser..."
endfunction