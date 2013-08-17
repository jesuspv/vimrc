if did_filetype()
   finish
endif
if getline(1) =~# '^#!.*/bin/.*\s\+bash\>'
   setfiletype sh
endif
