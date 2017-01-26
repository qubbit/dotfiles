dotfiles 💻
===========

This repo contains my development machine setup scripts.

Following platforms are supported:

* macOS
* Ubuntu
* Debian
* CentOS
* RHEL 6 and 7

The setup here is tailored as per my liking. You can fork the repo and make changes to the script as you see fit.


What does it contain?
---------------------

The `dev_setup.sh` script installs vim, git, tmux, curl and zsh (apt-get upgrades them if they are already installed). Configuration files for vim, tmux, git and zsh are symlinked (using `dotfiles_setup.sh`) from your $HOME and the vim plugins are installed via vim-plug

You can just run `dotfiles_setup.sh` if you just want to symlink the dot files.

Installation
------------

<pre>
git clone https://github.com/qubbit/dotfiles .dotfiles

cd .dotfiles

./dev_setup.sh
</pre>

Tools of the trade
------------------
1. ag (silver searcher)
2. git
3. curl
4. zsh
5. tmux
6. vim
7. fzf
