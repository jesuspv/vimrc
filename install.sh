#!/bin/bash

# install config files
REPOS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CFG_FILES="vimrc gvimrc"
for FILE in $CFG_FILES; do
   [[ -h $HOME/.$FILE ]] && unlink $HOME/.$FILE
   [[ -f $HOME/.$FILE ]] && mv -f $HOME/.$FILE $HOME/.$FILE.LAST
   ln -s $REPOS_DIR/$FILE $HOME/.$FILE
done

# install fonts
if [[ ! -f $HOME/.fonts/Inconsolata.otf ]]; then
   URL="http://levien.com/type/myfonts/Inconsolata.otf"
   mkdir -p $HOME/.fonts

   cd $HOME/.fonts

   wget --quite $URL 2> /dev/null || curl --silent --remote-name $URL
   if [ $? -ne 0 ]; then
      CODE=$LINENO;
      echo "error:$CODE: wget/curl not found. Unable to download font Inconsolata.otf"
      exit $CODE
   fi

   cd - > /dev/null
fi

# working directories
mkdir -p $REPOS_DIR/backup
mkdir -p $REPOS_DIR/tmp

echo "installation finished"
