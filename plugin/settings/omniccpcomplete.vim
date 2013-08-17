if v:version >= 700
   let OmniCpp_NamespaceSearch = 1
   let OmniCpp_GlobalScopeSearch = 1
   let OmniCpp_ShowAccess = 1
   let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
   let OmniCpp_MayCompleteDot = 1 " autocomplete after .
   let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
   let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
   let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
   " automatically open and close the popup menu / preview window
   au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
   set completeopt=menuone,menu,longest,preview

   "set omnifunc=omni#cpp#complete#Main
   " omni completion
   autocmd FileType python set omnifunc=pythoncomplete#Complete
   autocmd FileType java set omnifunc=javacomplete#Complete
   autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
   autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
   autocmd FileType css set omnifunc=csscomplete#CompleteCSS
   autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
   autocmd FileType php set omnifunc=phpcomplete#CompletePHP
   autocmd FileType c set omnifunc=ccomplete#Complete

   set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
   "  let OmniCpp_GlobalScopeSearch   = 1
   "  let OmniCpp_DisplayMode         = 1
   "  let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
   let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
   "  let OmniCpp_ShowAccess          = 1 "show access in pop-up
   "  let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
   "  set completeopt=menuone,menu,longest

   "  let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
   "highlight   clear
   " for console only!?
   highlight   Pmenu         ctermfg=0 ctermbg=2
   highlight   PmenuSel      ctermfg=0 ctermbg=7
   highlight   PmenuSbar     ctermfg=7 ctermbg=0
   highlight   PmenuThumb    ctermfg=0 ctermbg=7
endif
