#!/bin/bash

DOTVIM="$HOME/.vim"

if [ ! -e `which git` ]
then
  echo "You need git. On Ubuntu, install with sudo apt-get install git-core"
  exit 0
fi

if [ ! -d $DOTVIM ]
then
  mkdir $DOTVIM
fi

get_repo() {
    gh_user=$1
    repo=$2
    echo "Checking $repo"
    if [ -d "$DOTVIM/bundle/$repo/" ]
    then
        echo "Pulling latest from $repo"
        cd $DOTVIM/bundle/$repo
        git pull origin master
        cd ..
    else
        echo "Cloning repo for $repo"
        git clone git://github.com/$gh_user/$repo.git
    fi
}

get_other_repo() {
   path=$1
   repo=$2

   echo "Checking $repo"
   if [ -d "$DOTVIM/bundle/$repo/" ]
   then
      echo "Pulling latest from $repo"
      cd $DOTVIM/bundle/$repo
      git pull origin master
      cd ..
   else
      echo "Cloning repo for $repo"
      git clone $url$repo.git
   fi
}

echo "Creating .vim folders if necessary"
mkdir -p $DOTVIM/{autoload,bundle}
cd $DOTVIM/bundle/

tpope_repos=(git surround unimpaired abolish repeat markdown ragtag fugitive speeddating)

for r in ${tpope_repos[*]}; do
    repo="vim-$r"
    get_repo "tpope" $repo
done

echo "Installing NERDTree"
get_repo "scrooloose" "nerdtree"

echo "Installing Syntastic"
get_repo "scrooloose" "syntastic"

echo "Installing TComment"
get_repo "tomtom" "tcomment_vim"

echo "Installing snipMate"
get_repo "msanders" "snipmate.vim"

echo "Installing vim-ruby"
get_repo "vim-ruby" "vim-ruby"

echo "Installing vim-matchit"
get_repo "mhz" "vim-matchit"

echo "Installing taglist.vim"
get_repo "jc00ke" "taglist.vim"

echo "Installing ack.vim"
get_repo "mileszs" "ack.vim"

echo "Installing javascript.vim"
get_repo "pangloss" "vim-javascript"

echo "Installing haskell.vim"
get_repo "vim-scripts" "haskell.vim"

echo "Installing calendar-vim"
get_repo "mattn" "calendar-vim"

echo "Installing molokai.vim"
get_repo "vim-scripts" "molokai"

echo "Installing vim-jade"
get_repo "digitaltoad" "vim-jade"

echo "Installing delimitMate"
get_repo "Raimondi" "delimitMate"

echo "Installing supertab"
get_repo "ervandew" "supertab"

echo "Installing jslint"
get_repo "hallettj" "jslint.vim"

echo "Installing align"
get_repo "tsaleh" "vim-align"

echo "Installing vim-orgmode"
get_repo "jceb" "vim-orgmode"

echo "Installing coffee-script"
get_repo "kchmck" "vim-coffee-script"

echo "Installing jellybeans"
get_repo "nanotech" "jellybeans.vim"

echo "Installing Command-T"
get_repo "wincent" "Command-T"
echo "Building Commant-T"
cd $DOTVIM/bundle/Command-T
rake make

cd $DOTVIM/autoload
echo "Fetching latest pathogen.vim"
rm pathogen.vim
curl -O https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim

echo "Checking to see if pathogen has already been added to .vimrc"
pathogen_cmd="call pathogen#runtime_append_all_bundles()"
contains=`grep "$pathogen_cmd" ~/.vimrc | wc -l`

if [ $contains == 0 ]
then
    echo "Hasn't been added, adding now."
    echo "$pathogen_cmd" >> ~/.vimrc
else
    echo "It was already added. Good to go"
fi
