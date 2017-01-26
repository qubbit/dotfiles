#!/usr/bin/env bash
. ./common.sh

DRYRUN=false
NOISY=false

for arg in "$@"; do
  larg="$(tr [A-Z] [a-z] <<< "$arg")"

  if [ "$larg" == "dryrun" ]; then
    DRYRUN=true
  fi

  if [ "$larg" == "noisy" ]; then
    NOISY=true
  fi
done

if [ "$NOISY" = true ]; then
  set -ex
else
  set -e
fi

FILE_LIST=(vimrc
         zshrc
         gitconfig
         gitignore
         ctags
         tmux.conf
         pryrc
         sqshrc)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$DRYRUN" = false ]; then
  __info__ "Setting up vim"
  vim_setup
  __info__ "Setting up zsh"
  zsh_setup
else
  __info__ "dry run: vim setup"
  __info__ "dry run: zsh setup"
fi

for file in ${FILE_LIST[@]}; do

  __info__ "Processing $file"

  home_file="$HOME/.$file"
  repo_file="$DIR/$file"

  if [ -f $home_file ]; then
    backup=$home_file".backup"
    has_symlink=false
      if [ -L $home_file ]; then
        has_symlink=true
        __info__ "Unlinking $home_file\n"
        unlink_cmd="unlink $home_file"
        if [ "$DRYRUN" = false ]; then
          eval $unlink_cmd
        else
          echo $unlink_cmd
        fi
      fi

      move_cmd="mv $home_file $backup"
      symlink_cmd="ln -s $repo_file $home_file"

      __info__ "Creating symlink"

      if [ "$DRYRUN" = false ]; then
        ! $has_symlink && __info__ "Backing up $home_file to $backup" && eval $move_cmd
        eval $symlink_cmd
      else
        ! $has_symlink && __info__ "Backing up $home_file to $backup" && echo $move_cmd
        echo $symlink_cmd
      fi
  else
    __info__ "No previous config detected for $file, creating symlink"
    cmd="ln -s $repo_file $home_file"
    if [ "$DRYRUN" = false ]; then
      eval $cmd
    else
      echo $cmd
    fi
  fi
  echo ""
  has_symlink=false
done

__info__ "Configuring neovim"

NVIM_DIR="$HOME/.config/nvim"
mkdir -p $NVIM_DIR
NVIM_CONFIG_FILE="$NVIM_DIR/init.vim"

cat << HEREDOC > $NVIM_CONFIG_FILE
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
HEREDOC

exit 0
