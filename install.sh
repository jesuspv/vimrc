#!/bin/sh

REPOS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CFG_FILES="vimrc gvimrc"

for FILE in $CFG_FILES; do
   [[ -f $HOME/.$FILE ]] && mv -f $HOME/.$FILE  $HOME/.$FILE.LAST
   [[ -h $HOME/.$FILE ]] && unlink $HOME/.$FILE
   ln -s $REPOS_DIR/$FILE $HOME/.$FILE
done
