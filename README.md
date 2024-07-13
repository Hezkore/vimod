# VIMod⚡
Vemod's unnecessarily complex Vim configuration.

VIMod _(VIM + Vemod)_ is my personal Vim configuration, designed with the philosophy that complexity should reside in the configuration itself, not in the user's workflow and setup.

The complexity of VIMod is hidden behind the scenes. The user only needs to include the VIMod runtime in their vimrc file to complete the initial installation, with no additional commands required, even if an existing Vim configuration is already in place.

## Philosophy
* Prioritize Vim's built-in features and native functionality to minimize usage of external plugins.
* Design each component to be self-contained, with both setup and configuration in its own .vim file.
* Ensure individual components can be removed without breaking the rest of the setup.
* Keep default Vim behavior unchanged, relying on the leader key for most customizations.
* Each programming or scripting language must have its own self-contained configuration file to adjust Vim's behavior to match the language's rules.
* Local user settings should not be mixed with the base VIMod settings but instead written in the user's regular vimrc file.
* Initial installation should require nothing more than the inclusion of the VIMod runtime in the user's existing vimrc file, with no additional commands needed for installation.

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