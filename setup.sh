#!/usr/bin/env bash

echo "                                                       ";
echo "                     _|        _|        _|    _|      ";
echo "   _|_|_|  _|    _|  _|_|_|    _|_|_|        _|_|_|_|  ";
echo " _|    _|  _|    _|  _|    _|  _|    _|  _|    _|      ";
echo " _|    _|  _|    _|  _|    _|  _|    _|  _|    _|      ";
echo "   _|_|_|    _|_|_|  _|_|_|    _|_|_|    _|      _|_|  ";
echo "       _|                                              ";
echo "       _|                                              ";
echo "                                                       ";

# Add your ASCII art from: http://patorjk.com/software/taag/#p=display&c=echo&f=Block&t=qubbit

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

FILELIST=(vimrc
         zshrc
         gitconfig
         gitignore
         ctags
         tmux.conf
         pryrc
         sqshrc)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file in ${FILELIST[@]}; do

  printf "Processing %s...\n" $file

  home_file="$HOME/.$file"
  repo_file="$DIR/$file"

  if [ -f $home_file ]; then
    backup=$home_file".backup"
    has_symlink=false
      if [ -L $home_file ]; then
        has_symlink=true
        printf "Unlinking %s\n" $home_file
        unlink_cmd="unlink $home_file"
        if [ "$DRYRUN" = false ]; then
          eval $unlink_cmd
        else
          echo $unlink_cmd
        fi
      fi

      move_cmd="mv $home_file $backup"
      symlink_cmd="ln -s $repo_file $home_file"

      printf "Creating symlink\n"

      if [ "$DRYRUN" = false ]; then
        ! $has_symlink && printf "Backing up %s to %s\n" $home_file $backup && eval $move_cmd
        eval $symlink_cmd
      else
        ! $has_symlink && printf "Backing up %s to %s\n" $home_file $backup && echo $move_cmd
        echo $symlink_cmd
      fi
  else
    printf "No previous config detected for %s, creating symlink\n" $file
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

exit 0
