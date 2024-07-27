" Custom tabline
let g:show_unlisted_buffers = get(g:, 'show_unlisted_buffers', 0)
let g:show_window_count = get(g:, 'show_window_count', 0)

function! CustomTabLine()
	let current_tab = tabpagenr()
	let tab_count = tabpagenr('$')
	let s = '%' .. (tab_count + 1) .. 'X%#TabLineFill#'
	
	" Show current tab number and total tab count
	if tab_count > 1
		let s .= '%X%#TabLineSel#Tab[' . current_tab . '/' . tab_count . ']'
		let s .= '%' .. (tab_count + 1) .. 'X%#TabLineFill# '
	endif
	
	" Show window count, current and total
	if g:show_window_count == 1
		let s .= '%#TabLineSel#Win[' . winnr() . '/' . winnr('$') . ']%#TabLineFill# '
	endif
	
	" Get all the buffers
	let all_buffers = range(1, bufnr('$'))
	
	" Display listed buffers
	for bufnr in filter(copy(all_buffers), 'buflisted(v:val)')
		let s .= (bufnr == bufnr('%') ? '%#TabLineSel#' : '%#TabLine#')
		let bufname = empty(bufname(bufnr)) ? '[No Name]' : fnamemodify(bufname(bufnr), ':t')
		let bufstatus = (getbufvar(bufnr, '&mod') ? '[+]' : '') . (getbufvar(bufnr, '&ro') ? '[-]' : '')
		let s .= bufnr . ':' . bufname . bufstatus . '%#TabLineFill# '
	endfor
	
	" Display unlisted buffers if enabled
	if g:show_unlisted_buffers == 1
		for bufnr in filter(copy(all_buffers), '!buflisted(v:val)')
			let s .= '%#TabLineFill#'
			let s .= (bufnr == bufnr('%') ? '%#TabLineSel#' : '%#TabLine#')
			let s .=  '<' . bufnr . ':' . (empty(bufname(bufnr)) ? '[No Name]' : fnamemodify(bufname(bufnr), ':t'))
			let s .= '>%#TabLineFill# '
		endfor
	endif
	
	return s . '%#TabLineFill#'
endfunction

set tabline=%!CustomTabLine()