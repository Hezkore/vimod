" Install vim-plug if it's not already installed
let s:plug_dir = g:vimfiles . '/autoload'
let s:plug_path = g:vimfiles . '/autoload/plug.vim'
let s:plug_plugins = g:vimfiles . '/vimod/plugins'

if filereadable(s:plug_path)
	"echomsg "vim-plug found."
else
	echomsg "vim-plug not found, installing..."
	
	" Check if the directory exists, create it if it doesn't
	if !isdirectory(s:plug_dir)
		echomsg "Creating directory for vim-plug..."
		call mkdir(s:plug_dir, "p")
	endif
	
	if has('win32') || has('win64')
		" Use PowerShell command to download vim-plug
		call system('powershell -Command "iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile ' . shellescape(s:plug_path, 1) . '"')
	else
		" Use curl command to download vim-plug for Unix-like systems
		call system('curl -fLo ' . shellescape(s:plug_path, 1) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	endif
	
	" Check if the download was successful
	if filereadable(s:plug_path)
		echomsg "vim-plug installed successfully."
		let g:plug_install = 1
	else
		echomsg "Failed to install vim-plug."
	endif
endif

" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Plugins
call plug#begin(g:vimfiles . '/plugged')
	" Load all plugin configuration files
	let plugin_files = glob(s:plug_plugins."/*.vim", 0, 1)
	for file in plugin_files
		"echomsg "Processing plugin " . file
		execute 'source' file
	endfor
	
call plug#end()

if exists('g:plug_install')
	" Automatically call PlugInstall to install the plugins
	execute 'PlugInstall --sync | q'
endif

" Execute the final plugin settings
doautocmd User VIModPlugSettings