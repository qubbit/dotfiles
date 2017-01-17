#!/usr/bin/env bash

RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

function fatal() {
  printf "${RED}FATAL: $1${NO_COLOR}\n"
  exit 1
}

function warn() {
  printf "${YELLOW}WARN: $1${NO_COLOR}\n"
}

function __info__() {
  printf "${CYAN}INFO: $1${NO_COLOR}\n"
}

function setup() {
  __info__ "Installing home brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
  if [[ $? != 0 ]]; then
    fatal "brew doctor returned non-zero exit status\n"
    exit 1
  fi

  __info__ "Installing z shell..."
  brew install zsh

  __info__ "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  __info__ "Installing vim-plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  __info__ "Installing reattach-to-user-namespace"
  brew install reattach-to-user-namespace

  __info__ "Installing brew cask..."
  brew tap caskroom/cask

  __info__ "Installing software using brew cask..."
  brew cask install google-chrome spotify hipchat postman sublime-text iterm2 alfred

  __info__ "Installing command line tools..."
  brew install ag vim zsh tmux tmate git rbenv gpg2 colordiff

  __info__ "Installing programming languages: crystal, elixir, haskell, ruby..."
  brew install crystal-lang elixir rbenv
  brew cask install haskell-platform

  __info__ "Installing postgresql..."
  brew install postgres

  __info__ "Installing fun tools..."
  brew install figlet toilet cowsay fortune
  sudo gem install lolcat
}

__info__ "This script will setup a new macOS development environment. Continue? "
select yn in "Yes" "No"; do
    case $yn in
        Yes )
          setup
          break
          ;;
        No )
          exit
          ;;
    esac
done
