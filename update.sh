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
        git clone https://github.com/$gh_user/$repo.git
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

echo "Installing NerdCommenter"
get_repo "scrooloose" "nerdcommenter"

echo "Installing ColorSchemes"
get_repo "flazz" "vim-colorschemes"

echo "Installing xmledit"
get_repo "sukima" "xmledit"

echo "Installing javascript.vim"
get_repo "trevnorris" "vim-javascript-syntax"

echo "Installing Node dictionary"
get_repo "guileen" "vim-node"

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

echo "Installing L9"
get_repo "clones" "vim-l9"

echo "Installing FuzzyFinder"
get_repo "clones" "vim-fuzzyfinder"

echo "Installing Indent Guide"
get_repo "nathanaelkane" "vim-indent-guides"

#echo "Installing YouCompleteMe"
#get_repo "Valloric" "YouCompleteMe"

#echo "Installing TernJS"
#get_repo "marijnh" "tern_for_vim"

if [ -o `which curl` ]
then
	echo 'ERROR: curl not installed, cannot install pathogen'
	exit 1
fi

cd $DOTVIM/autoload
echo "Fetching latest pathogen.vim"
rm pathogen.vim
curl -O https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
