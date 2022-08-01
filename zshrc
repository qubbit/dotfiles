# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

fpath+=~/.zfunc

# Helper functions
os() {
  uname
}

command_exists() {
  command -V "$@" > /dev/null 2>&1
}

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JDTLS_HOME="/Users/gopadhi/Downloads/jdt-language-server-1.9.0-202203031534"
if [[ $(os) == 'Darwin' ]]; then
  # export JAVA_HOME=$(/usr/libexec/java_home -F)
fi

#  Path configuration
export PATH="~/.dotfiles/bin:$PATH"
export PATH="~/.dotfiles/fzf/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:~/go/bin"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
[ -f "$(command_exists yarn)" ] && export PATH="$PATH:$(yarn global bin)"

ANTIGEN_PATH=~/.dotfiles/antigen/antigen.zsh

if [ -f $ANTIGEN_PATH ]; then
  source $ANTIGEN_PATH

  antigen use oh-my-zsh

  antigen bundle rails
  antigen bundle ruby
  antigen bundle bundler
  antigen bundle cp
  antigen bundle history
  antigen bundle osx
  antigen bundle postgres
  antigen bundle git
  antigen bundle command-not-found

  antigen bundle zsh-users/zsh-completions
  antigen bundle zsh-users/zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-history-substring-search

  antigen theme romkatv/powerlevel10k
  # antigen theme spaceship-prompt/spaceship-prompt
  # antigen theme geometry-zsh/geometry
  # antigen theme avit
  # antigen theme geometry-zsh/geometry
  antigen apply
fi


# Colorized man pages
# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

if [ -x nvim ]; then
  alias v=nvim
  alias vi=nvim
else
  alias v=vim
  alias vi=vim
fi

WORKSPACE_DIR="$HOME/workspace"

cdc() {
  cd $WORKSPACE_DIR/$1
}

if [[ $(os) == 'Darwin' ]]; then
else
  #if test has_app('xmodmap'); then xmodmap ~/.speedswapper; fi
fi


export LANG=en_US.UTF-8
export EDITOR='vim'
export VISUAL='vim'
export ARCHFLAGS="-arch x86_64"

rbenv commands &>/dev/null && eval "$(rbenv init -)"

alias g="git"
alias tree=tree -I "node_modules|bower_components"
alias ag="ag --ignore=vendor --ignore=node_modules"
alias agr="ag --ruby"
alias tmlink="tmate show-messages | tail -1 | cut -d' ' -f9- | pbcopy"
alias myip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"
alias bake="bundle exec rake"
alias hgrep="history | grep"
alias qfind="find . -name"

replace(){
  find $1 -name $2 | xargs sed -i "" "s/$3/$4/g"
}

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias pfzf="fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500'"

# Find files and delete them
fdel() {
  find . -name $1 -delete
}

alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'

HOSTNAME=$(hostname)

_ssh_auth_save() {
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-auth-sock.$HOSTNAME"
}
alias tmux='_ssh_auth_save ; export HOSTNAME=$(hostname) ; tmux'
alias ber="bundle exec rspec"
alias be="bundle exec"
alias bcap="bundle exec capistrano"
alias sqshsql="sqsh -U 'innova\\gadhikari' -D CMM_Repl -S sydney.innova.local -w 200"
alias rm="rm -i"

# OS specific settings
if [[ $(os) == 'Darwin' ]]; then
  alias kq="osascript -e 'set volume output muted true'"
  alias pumpitup="osascript -e 'set volume 7'"
  alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"
fi

# some cool aliases and functions

# find and replace in files while creating backup
agfr() {
  ag -0 -l $1 | xargs -0 perl -pi.bak -e "s/$1/$2/g"
}

# shuts the fuck up noisy commands with output on stderr redir to /dev/null
# thanks zenspider
stfu () {
  eval $* 2> /dev/null
}

STFU () {
  eval $* &> /dev/null
}


alias psmem="ps -eo size,pid,user,command --sort -size | awk '{ hr=$1/1024 ; printf("%13.2f Mb ",hr) } { for ( x=4 ; x<=NF ; x++ ) { printf("%s ",$x) } print "" }'"
alias ping="ping -c 8"

function gitsha(){
  git log --pretty=format:'%h' -n $1
}

function duh() {
  du -h $@ | grep '[0-9\.]\+G' | sort -n -r
}

function wp() {
  if [[ $(os) == 'Darwin' ]]; then
    lsof -n -i4TCP:$1
  else
    netstat -tulpn | grep :$1
  fi
}

# find and kill programs listening on the specified TCP port
function kp() {
  lsof -nt -i4TCP:$1 | xargs kill -15
}


function ssht() {
  ssh -t "$@" "tmux attach -t 0 || tmux new";
}

function mcd() {
  mkdir -p "$1" && cd "$1";
}

# customized norm theme
# PROMPT='%{$fg[yellow]%}%n% @%m %{$fg[green]%}%c %{$fg[yellow]%}$(git_prompt_info)%{$reset_color%}'$'\nÃÂ» '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[colour12]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%}%{$reset_color%}"

eval `ssh-agent` > /dev/null
[ -f ~/.asdf/asdf.sh ] && . ~/.asdf/asdf.sh

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

command_exists rbenv && eval "$(rbenv init -)"

export NODE_PATH=/usr/lib/node_modules

export ERL_AFLAGS="-kernel shell_history enabled"
export LOCAL_DEVELOPMENT="true"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "$(command_exists compdef)" ] && compdef '_path_files -/ -W $WORKSPACE_DIR' cdc

alias dk=docker kill

# Unfuck docker fuckiness
removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

armaggedon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.dotfiles/amazon.zsh ] && source ~/.dotfiles/amazon.zsh

# . /usr/local/etc/profile.d/z.sh
export PATH=$HOME/.toolbox/bin:$PATH
export PATH="/Users/gopadhi/code/website/src/PBCentralTeamScripts/scripts":$PATH

export PATH="/Applications/Fortify/Fortify_SCA_and_Apps_21.1.0/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/Applications/Fortify/Fortify_SCA_and_Apps_21.1.1/bin:$PATH"
function fix_insecure_dirs() {
  for f in $(compaudit);do sudo chown $(whoami):admin $f; chmod -R 755 $f; done;
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/usr/local/sbin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

. /opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash
