" NERDTree - tree explorer
let g:enabled_nerdtree = get(g:, 'enabled_nerdtree', 1)
if g:enabled_nerdtree
	Plug 'preservim/nerdtree'
endif

" Settings that can be set before the plugin is loaded
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = 'v'
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = get(g:, 'NERDTreeBookmarksFile', $HOME . '/.NERDTreeBookmarks')
let g:NERDTreeBookmarksSort = 0

" Return all the bookmarks and their paths
function! ProduceNERDTreeBookmarksList()
	let l:bookmarks = {}
	let l:file = g:NERDTreeBookmarksFile
	if filereadable(l:file)
		let l:lines = readfile(l:file)
		for l:line in l:lines
			" Find the position of the first space
			let l:space_pos = stridx(l:line, ' ')

			" Extract the name and path based on the position of the first space
			let l:name = strpart(l:line, 0, l:space_pos)
			let l:path = strpart(l:line, l:space_pos + 1)
			
			" Did we get ANYTHING?
			if l:name != '' && l:path != ''
				let l:bookmarks[l:name] = l:path
			endif
		endfor
	endif
	return l:bookmarks
endfunction

" Add a bookmark to the NERDTree bookmarks file
function! AddNERDTreeBookmark(name, path)
	" Get the bookmarks
	let l:bookmarks = ProduceNERDTreeBookmarksList()
	let l:bookmarks[a:name] = a:path
	" write the bookmarks back to the file
	let l:file = g:NERDTreeBookmarksFile
	let l:lines = []
	for l:bookmark in keys(l:bookmarks)
		call add(l:lines, l:bookmark . ' ' . l:bookmarks[l:bookmark])
	endfor
	call writefile(l:lines, l:file)
	
	NERDTreeFocus
	try
		call g:NERDTreeBookmark.CacheBookmarks(1)
		call NERDTreeRender()
		call nerdtree#echo('Bookmark added: ' . a:name . ' -> ' . a:path)
	catch
		call nerdtree#echoError('Failed to add bookmark: ' . a:name . ' -> ' . a:path)
	endtry
endfunction

" Remove a bookmark to the NERDTree bookmarks file
function! RemoveNERDTreeBookmark(name)
	" Get the bookmarks
	let l:bookmarks = ProduceNERDTreeBookmarksList()
	if has_key(l:bookmarks, a:name)
		call remove(l:bookmarks, a:name)
		" write the bookmarks back to the file
		let l:file = g:NERDTreeBookmarksFile
		let l:lines = []
		for l:bookmark in keys(l:bookmarks)
			call add(l:lines, l:bookmark . ' ' . l:bookmarks[l:bookmark])
		endfor
		call writefile(l:lines, l:file)
		
		NERDTreeFocus
		try
			call g:NERDTreeBookmark.CacheBookmarks(1)
			call NERDTreeRender()
			call nerdtree#echo('Bookmark removed: ' . a:name)
		catch
			call nerdtree#echoError('Failed to remove bookmark: ' . a:name)
		endtry
	else
		call nerdtree#echoError('Bookmark not found: ' . a:name)
	endif
endfunction

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
	" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
	"autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
	"	\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
endfunction