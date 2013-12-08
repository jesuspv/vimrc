" configure tags - add additional tags here or comment out not-used ones
set tags=.tags;/                " lookup ctags file up the directory, until one is found
set tags+=~/.vim/tags/cpp       " libstdc++ headers (http://www.vim.org/scripts/script.php?script_id=2358)

if empty($PROJECT)
   map <F11> :silent !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ . &>/dev/null &<CR>
else
   map <F11> :silent !touch $PROJECT/.tags && ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f $PROJECT/.tags $PROJECT &>/dev/null &<CR>
endif
