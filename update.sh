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

tpope_repos=(unimpaired abolish markdown fugitive)

for r in ${tpope_repos[*]}; do
    repo="vim-$r"
    get_repo "tpope" $repo
done

echo "Installing NerdTree"
get_repo "scrooloose" "nerdtree"

echo "Installing NerdCommenter"
get_repo "scrooloose" "nerdcommenter"

echo "Installing ZenCoding"
get_repo "mattn" "zencoding-vim"

echo "Installing xmledit"
get_repo "sukima" "xmledit"

echo "Installing ir_black"
get_repo "wgibbs" "vim-irblack"

echo "Installing ack.vim"
get_repo "mileszs" "ack.vim"

echo "Installing javascript.vim"
get_repo "pangloss" "vim-javascript"

echo "Installing vim-stylus"
get_repo "wavded" "vim-stylus"

echo "Installing jshint"
get_repo "walm" "jshint.vim"

echo "Installing tabular"
get_repo "godlygeek" "tabular"

echo "Installing vim-orgmode"
get_repo "jceb" "vim-orgmode"

echo "Installing WMGraphviz"
get_repo "wannesm" "wmgraphviz.vim"

echo "Installing Command-T"
get_repo "wincent" "Command-T"
echo "Building Commant-T"
cd $DOTVIM/bundle/Command-T
# causes problems when using with rvm
#rake make
echo
echo '!!! Remember to build Command-T with Ruby 1.8.6'
echo

cd $DOTVIM/autoload
echo "Fetching latest pathogen.vim"
rm pathogen.vim
curl -O https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

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
