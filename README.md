# VIMod⚡
VIMod _(VIM + Vemod)_ is my personal [Vim 9.0+](https://github.com/vim/vim) configuration.

VIMod is designed to complement any existing Vim setup, but works equally well on a fresh Vim install!\
If you ever decide to remove VIMod, your Vim setup will return to its original state.

![demo](https://github.com/Hezkore/vimod/blob/main/demo.png?raw=true)
<sup>_VIMod and the Quick UI, reachable by pressing <kbd>Space</kbd>._</sup>

Learn more about VIMod, and how to use it, on the [Wiki](https://github.com/Hezkore/vimod/wiki).\
<sub>_Never used Vim before? Read the [new user](https://github.com/Hezkore/vimod/wiki/New-User) guide to get started._</sub>

## Install
Just download and add the runtime!\
OS specific instructions:
<details>
<summary><b>Windows</b></summary>

1. Clone the VIMod repository to your local machine:
	```shell
	git clone https://github.com/hezkore/vimod.git %USERPROFILE%/vimfiles/vimod
	```
2. Add the runtime at the top of your `vimrc` file:
	```vim
	runtime vimod/vimod.vim
	```
3. Add the optional [extended keymaps](https://github.com/Hezkore/vimod/wiki#extended-keymaps) below the runtime:
	```vim
	VIModKeys
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
3. Add the optional [extended keymaps](https://github.com/Hezkore/vimod/wiki#extended-keymaps) below the runtime:
	```vim
	VIModKeys
	```
</details>

Read the [Wiki](https://github.com/Hezkore/vimod/wiki) for instructions on how to use VIMod.

> [!TIP]
> Get a local copy of the wiki pages:
> `git clone https://github.com/Hezkore/vimod.wiki.git`

## Troubleshooting
If you are unsure where your vimrc file is located, run the following command in Vim: `:echo $MYVIMRC`

If you are unsure if the runtime was added correctly, look for the VIMod version number in the lower left corner when starting Vim.\
If it doesn't say `VIMod vX.X.X`, the runtime was not added correctly.

VIMod will install and manage all plugins and dependencies automatically when you start Vim for the first time.\
The install screen will automatically close when the installation is complete, so just sit tight and wait for it to finish.

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