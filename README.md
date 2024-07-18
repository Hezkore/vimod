# VIMod⚡
VIMod _(VIM + Vemod)_ is my personal [Vim](https://github.com/vim/vim) configuration.

The core idea is to keep the complexity buried in the configuration, and out of the user's workflow and initial setup.

VIMod is designed to complement any existing Vim setup, adding features without complicating the workflow. To integrate VIMod, simply include the VIMod runtime in your existing vimrc file. If you ever decide to remove VIMod, your Vim setup will revert to its previous state.

## Philosophy
* Prioritize Vim's built-in features and native functionality to minimize usage of external plugins.
* Design each component to be self-contained, with both setup and configuration in its own .vim file.
* Ensure individual components can be removed without breaking the rest of the setup.
* Keep default Vim behavior unchanged, relying on the leader key for most customizations.
* Each programming or scripting language must have its own self-contained configuration file to adjust Vim's behavior to match the language's rules.
* Local user settings should not be mixed with the base VIMod settings but instead written in the user's regular vimrc file.
* Initial installation should require nothing more than the inclusion of the VIMod runtime in the user's existing vimrc file, with no additional commands needed for installation.

## Install
To install VIMod, follow these steps:

1. Clone the VIMod repository to your local machine.
	```shell
	git clone https://github.com/hezkore/vimod.git <path-to-vimfiles>/vimod
	```

> [!NOTE]
> `<path-to-vimfiles>` will depend on your OS. For Unix-based systems, use `~/.vim`. For Windows, use `$HOME/vimfiles`.

2. Add the runtime at the top of your `vimrc` file.
	```vim
	runtime vimod/vimod.vim
	```
Run Vim 9.0 or later.

Don't forget to check the [Updating](#updating) section for the latest updates.

## Usage

### Customizing VIMod
To customize VIMod, add your adjustments to your vimrc file, not directly to the VIMod base.

Access and edit your vimrc file  by using `:Settings`. This command shows your vimrc alongside VIMod's default settings.\
Changes are auto-applied upon saving the vimrc file, and can also be manually applied with `:ApplySettings`.

Restarting Vim is advised to ensure all settings are applied.

All settings can be set after the VIMod runtime is loaded, however, to be efficient, the following settings can be set before the runtime is loaded.
* `mapleader`
* `colorscheme` _(note that `set termguicolors` is also not set if a colorscheme is set before the runtime)_

### Leader Key
VIMod uses <kbd>Space</kbd> as the leader key.\
Add `let mapleader = ","` before the VIMod runtime in `:Settings` if you prefer <kbd>,</kbd> as the leader key.

### Keymaps
<kbd>Leader</kbd> + <kbd>h</kbd> or <kbd>Leader</kbd> + <kbd>j</kbd> moves jumps to the previous buffer.\
<kbd>Leader</kbd> + <kbd>l</kbd> or <kbd>Leader</kbd> + <kbd>k</kbd> moves jumps to the next buffer.\
<kbd>Leader</kbd> + <kbd>1</kbd> to <kbd>9</kbd> jumps to the corresponding buffer.\
<kbd>Leader</kbd> + <kbd>q</kbd> closes the current buffer.\
<kbd>Leader</kbd> + <kbd>n</kbd> creates a new buffer.\
<kbd>Leader</kbd> + <kbd>bl</kbd> lists and lets you pick a buffer to jump to.

<kbd>Leader</kbd> + <kbd>o</kbd> opens the file explorer.\
<kbd>Leader</kbd> + <kbd>cd</kbd> changes the current directory to the file's directory.

### Extended keymaps
Because VIMod is designed to be as unobtrusive as possible, the extended keymaps are disabled by default.\
To enable them, add `VIModExtendedKeys` to your vimrc file.\
You can also enable them temporarily with `:VIModExtendedKeys`.

<kbd>Ctrl</kbd> + <kbd>h</kbd> or <kbd>Ctrl</kbd> + <kbd>j</kbd> moves jumps to the previous buffer.\
<kbd>Ctrl</kbd> + <kbd>l</kbd> or <kbd>Ctrl</kbd> + <kbd>k</kbd> moves jumps to the next buffer.

<kbd>Ctrl</kbd> + <kbd>Space</kbd>  to show auto-complete and signature help.\
<kbd>Tab</kbd> accepts the auto-complete suggestion.

## Plugins
While VIMod strives to keep plugin use to a minimum, some features are best handled by well-maintained and regularly updated plugins.

The following plugins are included and installed automatically with VIMod:
* [vim-plug](https://github.com/junegunn/vim-plug) - Plugin manager
* [copilot.vim](https://github.com/github/copilot.vim) - GitHub Copilot integration
* [CtrlP](https://github.com/ctrlpvim/ctrlp.vim) - Fuzzy finder
* [Dracula](https://github.com/dracula/vim) - Dracula dark theme
* [LSP](https://github.com/yegappan/lsp) - Language Server Protocol
* [Surrround](https://github.com/tpope/vim-surround) - Modify surroundings

### Adding plugins
Every VIMod plugin is self-contained in its own file

> [!WARNING]
> The following process is 'destructive', and should not be used unless absolutely necessary.

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

Renaming the plugin file to something like `<plugin-name>.vim.disabled` will disable the plugin.

All plugins will be installed automatically the first time you run VIMod.\
If you add a new plugin, you can run `:PlugInstall` to install it.\
`:PlugUpdate` will update all plugins.

## Updating

### VIMod

If Git was used to clone the VIMod repository, you can update VIMod by running the following command in the VIMod directory:
```shell
git pull
```
Otherwise you can download the latest source code and extract it to the VIMod directory.

Remember to always run `:PlugInstall` after an update as plugins may have been changed.

### Plugins
To update all plugins, run the following command in Vim:
```vim
:PlugUpdate
```

## Uninstall
To uninstall VIMod, remove the runtime from your vimrc file and delete the VIMod directory.