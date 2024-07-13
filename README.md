# VIMod⚡
My unnecessarily complicated Vim configuration.

## Installation
To install VIMod, follow these steps:

1. Clone the VIMod repository to your local machine.
	```shell
	git clone https://github.com/hezkore/vimod.git <path-to-vimfiles>/vimod
	```

> [!NOTE]
> `<path-to-vimfiles>` will depend on your OS. For Unix-based systems, you can use `~/.vim`. For Windows, you can use `$HOME/vimfiles`.

2. Add the runtime to your `vimrc` file.
	```vim
	runtime vimod/vimod.vim
	```
Run Vim and the automatic install process will begin.

## Usage

### Leader Key
<kbd>Space</kbd> is the leader key for VIMod.

<kbd>Leader</kbd> + <kbd>h</kbd> moves jumps to the previous buffer.\
<kbd>Leader</kbd> + <kbd>l</kbd> moves jumps to the next buffer.\
<kbd>Leader</kbd> + <kbd>q</kbd> closes the current buffer.\
<kbd>Leader</kbd> + <kbd>bl</kbd> lists and lets you pick a buffer to jump to.

### Plugins
Every VIMod plugin is self-contained in its own file.

To add your own plugins, create a new file in the `vimod/plugins` directory and add the plugin's information.\
Example plugin file:
```vim
" NERDTree - tree explorer
Plug 'preservim/nerdtree'

" Settings that can be set before the plugin is loaded
let g:NERDTreeShowHidden=1

" Settings that need to be applied after the plugin is loaded
autocmd User VIModPlugSettings call s:plugin_settings()
function! s:plugin_settings()
	" Map <C-n> to toggle NERDTree
	nmap <silent> <C-n> :NERDTreeToggle<CR>
endfunction
```
All plugins will be installed automatically the first time you run VIMod.\
If you add a new plugin, you can run `:PlugInstall` to install it.\
`:PlugUpdate` will update all plugins.