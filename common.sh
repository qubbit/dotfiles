RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NO_COLOR='\033[0m'

__fatal__() {
  printf "${RED}FATAL: $1${NO_COLOR}\n"
  exit 1
}

__warn__() {
  printf "${YELLOW}WARN: $1${NO_COLOR}\n"
}

__info__() {
  printf "${CYAN}INFO: $1${NO_COLOR}\n"
}

command_exists() {
  command -V "$@" > /dev/null 2>&1
}

vim_setup() {
  __info__ "Installing fzf"
  rm -rf ~/.dotfiles/fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.dotfiles/fzf
  ~/.dotfiles/fzf/install --all

  __info__ "Installing vim-plug"
  mkdir -p ~/.vim/autoload
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  __info__ "Installing vim plugins using vim-plug"
  vim +PlugInstall +qall
}

zsh_setup() {
  __info__ "Intalling antigen"
  rm -rf ~/.dotfiles/antigen
  git clone --depth 1 https://github.com/zsh-users/antigen.git ~/.dotfiles/antigen
}

fonts_setup() {
  __info__ "Installing fonts"
  rm -rf ~/.dotfiles/nerd-fonts
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts ~/.dotfiles/nerd-fonts
  ~/.dotfiles/nerd-fonts/install.sh
}
