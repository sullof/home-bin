# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gam='git add -A && git commit -m '
alias sgam='export SKIP=1 && git add -A && git commit -m '
alias gaa='git add -A && git commit --amend'
alias gaap='git add -A && git commit --amend && git push -f'
alias gb='git branch'
alias gbd='git branch -d '
alias gbs='git branch --sort=-committerdate'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gpo='git pull origin'
alias gtmp='gaa && gcm "Temporary commit to check out another branch"'
alias gcf='gam "Conflicts fixed"'
alias gurl='git remote -v'
alias gdlb='~/Projects/sh/deleteLocalBranch.sh'
alias gdb='~/Projects/sh/deleteRemoteAndLocalBranch.sh'
alias grb='~/Projects/sh/renameBranch.sh'

# preactions
alias gitoa='~/Projects/sh/gito.js -a'
alias gitoc='~/Projects/sh/gito.js -c'
alias gitor='~/Projects/sh/gito.js -r'

alias tb='cd ~/Projects/tron/tron-box'
alias tw='cd ~/Projects/tron/tron-web'
alias tq='cd ~/Projects/docker-tron-quickstart'

# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }


#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

export PATH=$PATH:$HOME/bin
if [ -e /Users/sullof/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/sullof/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source ~/bin/git-prompt.sh
export PS1='[\W$(__git_ps1 " (%s)")]\$ '

source ~/bin/git-completion.bash
source ~/.profile

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

export EDITOR=/usr/bin/nano
export GOPATH=$HOME/go
