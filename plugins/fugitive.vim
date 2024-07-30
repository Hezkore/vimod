" fugitive - Git wrapper
if executable('git')
	let g:enabled_fugitive = get(g:, 'enabled_fugitive', 1)
else
	let g:enabled_fugitive = 0
endif
if g:enabled_fugitive
	Plug 'tpope/vim-fugitive'
endif

" Is Githubs's cli installed?
let g:has_github_cli = executable('gh')

" Settings that can be set before the plugin is loaded

" Function for cleaning up the fugitive statusline
function! CustomFugitiveStatusline()
	let s:statusline = fugitive#statusline()
	let s:statusline = substitute(s:statusline, '^\[', '', '')
	let s:statusline = substitute(s:statusline, '\]$', '', '')
	let s:statusline = substitute(s:statusline, 'Git:', '', '')
	let s:statusline = substitute(s:statusline, '(', '[', '')
	let s:statusline = substitute(s:statusline, ')', ']', '')
	return s:statusline
endfunction

" Function for producing a list of current pull requests
function! ProduceGithubPullRequestList()
	let s:pr_list = system('gh pr list --json number,title,url,author,headRefName')
	let s:pr_list = json_decode(s:pr_list)
	return s:pr_list
endfunction

" Function for producing a json for a specific pull request
function! ProduceGithubPullRequestJson(pr_number)
	" Get the JSON data for the pull request
	let pr_command = 'gh pr view ' . a:pr_number . ' --json number,title,url,headRefName,baseRefName,body,author,createdAt,updatedAt'
	let pr_output = system(pr_command)
		
	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the pull request data for #" . a:pr_number
		return {}
	endif
	
	" Parse the JSON output
	let pr_json = json_decode(pr_output)
	return pr_json
endfunction

function! ProduceGithubIssueJson(issue_number)
	" Get the JSON data for the issue
	let issue_command = 'gh issue view ' . a:issue_number . ' --json number,title,url,body,author,createdAt,updatedAt'
	let issue_output = system(issue_command)
	
	" Check if the gh command was successful
	if v:shell_error != 0
		echo "Error: Unable to get the issue data for #" . a:issue_number
		return {}
	endif
	
	" Parse the JSON output
	let issue_json = json_decode(issue_output)
	return issue_json
endfunction

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
endfunction