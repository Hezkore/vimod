"""""""""""""""""""""""""""""""""
" _    ________  ___          __"
"| |  / /  _/  |/  /___  ____/ /"
"| | / // // /|_/ / __ \/ __  / "
"| |/ // // /  / / /_/ / /_/ /  "
"|___/___/_/  /_/\____/\__,_/   "
"                               "
"""""""""""""""""""""""""""""""""
" VIMod
let g:vimod_version = "1.3.1"
autocmd VimEnter * echom "VIMod v" . g:vimod_version

" Load base
runtime vimod/base/common.vim
runtime vimod/base/sessions.vim
runtime vimod/base/plugins.vim
runtime vimod/base/keymap.vim
runtime vimod/base/settings.vim
runtime vimod/base/statusline.vim
runtime vimod/base/tabline.vim
runtime vimod/base/netrw.vim
runtime vimod/base/commands.vim
runtime vimod/base/languages.vim