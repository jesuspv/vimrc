" configure tags - add additional tags here or comment out not-used ones
" ctags: ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f TAGFILE DIR
set tags=tags;/                 " lookup ctags file up the directory, until one is found
set tags+=~/.vim/tags/cpp       " libstdc++ headers (http://www.vim.org/scripts/script.php?script_id=2358)
if filereadable($PROJECT . '/.tags')
   set tags+=$PROJECT . '/.tags' " custom database
endif
