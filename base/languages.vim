
let s:lang_settings = g:vimfiles . '/vimod/languages'

" Load all language configuration files
let lang_files = glob(s:lang_settings."/*.vim", 0, 1)
for file in lang_files
	"echomsg "Processing language " . file
	execute 'source' file
endfor