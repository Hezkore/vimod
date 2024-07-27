# VIMod⚡
VIMod _(VIM + Vemod)_ is my personal [Vim 9.0+](https://github.com/vim/vim) configuration.


VIMod is designed to complement any existing Vim setup, but works equally well on a fresh install! If you ever decide to remove VIMod, your Vim setup will return to its original state.

Learn more about VIMod on our [Wiki](https://github.com/Hezkore/vimod/wiki).

<small>_Never used Vim before?_\
_Read the [new user](https://github.com/Hezkore/vimod/wiki) guide to get started._</small>

![demo](https://github.com/Hezkore/vimod/blob/main/demo.png?raw=true)

## Install
Just copy VIMod to your Vim configuration directory and add the runtime to your vimrc file. Launch Vim normal.\
Clone with Git if you want to easily update VIMod in the future.

OS specific instructions:
<details>
<summary><b>Windows</b></summary>

1. Clone the VIMod repository to your local machine.
	```shell
	git clone https://github.com/hezkore/vimod.git $HOME/vimfiles/vimod
	```
2. Add the runtime at the top of your `vimrc` file.
	```vim
	runtime vimod/vimod.vim
	```
</details>

<details>
<summary><b>Unix-based</b></summary>

1. Clone the VIMod repository to your local machine:
	```shell
	git clone https://github.com/hezkore/vimod.git ~/.vim/vimod
	```
2. Add the runtime at the top of your `vimrc` file:
	```vim
	runtime vimod/vimod.vim
	```
</details>

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