#!/usr/bin/env bash

set -euo pipefail

. common.sh

common_setup() {
  bash ./dotfiles_setup.sh
  __info__ "Adding zsh to list of shells"
  sudo sh -c 'echo "$(which zsh)" >> /etc/shells'
}

package_manager_name(){
  # Both centos and RHEL have the following file
  if [ -f /etc/redhat-release ]; then
    echo yum
  elif [ -f /etc/os-release ]; then
    echo apt-get
  else
    echo 'Unsupported Linux distribution'
    exit
  fi
}

function setup() {
  if [[ $(uname) == 'Darwin' ]]; then
    mac_setup
  elif [[ $(uname) == 'Linux' ]]; then
    linux_setup
  else
    __error__ "I can't setup something that is not a MacOS or Linux"
    exit 1
  fi
}


function linux_setup() {
  PACKAGE_MGR=$(package_manager_name)
  UPDATE_COMMAND='update'
  if [[ $PACKAGE_MGR == 'yum' ]]; then UPDATE_COMMAND='check-update'; fi
  eval "sudo $PACKAGE_MGR $UPDATE_COMMAND && sudo $PACKAGE_MGR install vim tmux git zsh curl silversearcher-ag -y"
  __info__ "Installing ripgrep"
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
  sudo dpkg -i "ripgrep_11.0.1_amd64.deb"
  rm -rf "ripgrep_11.0.1_amd64.deb"
  common_setup
}

function mac_setup() {
  __info__ "Setting up your Mac"

  common_setup

  __info__ "Installing home brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


  brew doctor
  if [[ $? != 0 ]]; then
    __fatal__ "brew doctor returned non-zero exit status\n"
    exit 1
  fi

  __info__ "Installing brew bundle"
  brew bundle
}

if [[ $@ == "-y" ]]; then
  setup
else
  __info__ "This script will setup a new development environment. Continue? "
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
fi
