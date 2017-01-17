# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# colorized man pages
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

VAGRANT_DIR="$HOME/vagrant"

if [[ `uname` == 'Darwin' ]]; then
  export HOST=nymeria
  alias cdc="cd $VAGRANT_DIR/code && cd"
else
  export HOST=greywind
  alias cdc="cd /vagrant/code && cd"
  xmodmap ~/.speedswapper
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

plugins=(git rails ruby)

# User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=/Users/gadhikari/Downloads/activator-1.3.11-minimal/bin:$PATH

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export EDITOR='vim'
export ARCHFLAGS="-arch x86_64"

# need these lines to prevent: command get_passphrase failed: Inappropriate ioctl for device
GPG_TTY=$(tty)
export GPG_TTY

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

ssh-add -L &> /dev/null
if [ $? -eq 1 ]; then
  ssh-add
fi

export PATH="$HOME/.rbenv/bin:$PATH"
rbenv commands &>/dev/null && eval "$(rbenv init -)"

function vssh(){
  pushd > /dev/null 2>&1
  cd $VAGRANT_DIR
  running=false
  if [[ `vagrant status | grep -o running` == "running" ]]; then
    running=true
  fi

  if $running; then; vagrant ssh; else vagrant up && vagrant ssh; fi
  popd
}

alias v="vim"
alias vi="vim"
alias g="git"
alias ag="ag --ignore=vendor"
alias agr="ag --ruby"
alias tmlink="tmate show-messages | tail -1 | cut -d' ' -f9- | pbcopy"
alias myip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"

if [[ ! $TERM =~ screen ]]; then
  # exec tmux
fi

alias ber="bundle exec rspec"
alias be="bundle exec"
alias sqshsql="sqsh -U 'innova\\gadhikari' -D CMM_Repl -S sydney.innova.local -w 200"
alias rm="rm -i"

# OS specific settings
if [[ `uname` == 'Darwin' ]]; then
  alias stfu="osascript -e 'set volume output muted true'"
  alias pumpitup="osascript -e 'set volume 7'"
  alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"
fi

# really cool aliase and functions

alias psmem="ps -eo size,pid,user,command --sort -size | awk '{ hr=$1/1024 ; printf("%13.2f Mb ",hr) } { for ( x=4 ; x<=NF ; x++ ) { printf("%s ",$x) } print "" }'"

function gitsha(){
  git log --pretty=format:'%h' -n $1
}

function duh() {
  du -h $@ | grep '[0-9\.]\+G' | sort -n -r
}

function whatport() {
  netstat -ln | grep $1 | awk '{print $NF}'
}

function ssht() {
  /usr/bin/ssh -t "$@" "tmux attach -t 0 || tmux new";
}

function mcd() {
  mkdir -p "$1" && cd "$1";
}

# customized norm theme
PROMPT='%{$fg[yellow]%}λ %n% @%m %{$fg[green]%}%c %{$fg[yellow]%}$(git_prompt_info)%{$reset_color%}'$'\n> '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[colour12]%}git %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%}%{$reset_color%}"
