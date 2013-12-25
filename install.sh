#!/bin/bash

# install config files
REPOS_DIR=$(dirname "`readlink -f "${BASH_SOURCE[0]}"`")
CFG_FILES="vimrc gvimrc"
for FILE in vim $CFG_FILES; do
   [[ -h ~/.$FILE ]] && unlink ~/.$FILE
   [[ -f ~/.$FILE ]] && mv -f ~/.$FILE ~/.$FILE.last \
                     && echo "$FILE backed up as $FILE.last"
   ln -s $REPOS_DIR/$FILE ~/.$FILE
   echo "$FILE installed"
done

# install fonts
if [[ ! -f ~/.fonts/Inconsolata.otf ]]; then
   URL="http://levien.com/type/myfonts/Inconsolata.otf"
   mkdir -p ~/.fonts

   cd ~/.fonts

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
