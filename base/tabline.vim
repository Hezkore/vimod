" Custom tabline

set showtabline=2
function! CustomTabLine()
	let s = ''
	" Get the list of all buffers
	let bufnr_list = range(1, bufnr('$'))
	" Filter out unlisted buffers
	let bufnr_list = filter(bufnr_list, 'buflisted(v:val)')
	" Loop through each buffer
	for bufnr in bufnr_list
		" Set highlight
		if bufnr == bufnr('%')
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		" Set the buffer number (for mouse clicks)
		let s .= '%' . bufnr . 'T'
		" Add buffer number
		let s .= ' ' . bufnr . '.'
		" Get buffer name and status
		let bufname = bufname(bufnr)
		let modified = getbufvar(bufnr, "&modified")
		" Shorten the buffer name
		let bufname_short = pathshorten(fnamemodify(bufname, ':t'))
		" Add buffer name
		if bufname_short == ''
			let s .= '[No Name]'
		else
			let s .= bufname_short
		endif
		" Add modified label [+] if the buffer is modified
		if modified
			let s .= '[+]'
		endif
		" Add space after buffer name
		let s .= ' '
	endfor
	" After the last buffer fill with TabLineFill and reset buffer nr
	let s .= '%#TabLineFill#%T'
	return s
endfunction
set tabline=%!CustomTabLine()