# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

 #Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
SSL_CERT_FILE=/usr/local/etc/openssl/certs/cacert.pem
ZSH_THEME="arrow"
EDITOR="nv"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often to auto-update? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to the command execution time stamp shown
# in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(sublime bundler)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:/Users/ignacykasperowicz/.rvm/gems/ruby-2.0.0-p353/bin:/Users/ignacykasperowicz/.rvm/gems/ruby-2.0.0-p353@global/bin:/Users/ignacykasperowicz/.rvm/rubies/ruby-2.0.0-p353/bin:/Users/ignacykasperowicz/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/Users/ignacykasperowicz/Devel/rag/shelly/winnie-app/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

source /Users/ignacykasperowicz/zshrc.sh
source ~/.zsh/zsh-git-prompt/zshrc.sh
# an example prompt
# PROMPT='%B%m%~%b$(git_super_status) %# '
GIT_PROMPT_EXECUTABLE="haskell"
function precmd {
   PROMPT='%{$fg[$NCOLOR]%}%c$(git_super_status) %{$fg[$NCOLOR]%}➤ %{$reset_color%}'
}
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias pg-restart='pg_ctl -D /usr/local/var/postgres -m fast -l /usr/local/var/postgres/server.log restart'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/stack-1.0.4-osx-x86_64"
export NVIM_TUI_ENABLE_TRUE_COLOR=1

PERL_MB_OPT="--install_base \"/Users/ignacykasperowicz/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ignacykasperowicz/perl5"; export PERL_MM_OPT;

glog() {
  local commit_hash="%C(yellow)%h%Creset"
  local relative_time="%Cgreen(%ar)%Creset"
  local author="%C(bold 075)<%an>%Creset"
  local refs="%C(red)%d%Creset"
  local subject="%s"

  local format="$commit_hash}$relative_time}$author}$refs $subject"
  git log --graph --pretty="tformat:${format}" $* |
      # Replace (2 years ago) with (2 years)
      sed -Ee 's/(^[^<]*) ago\)/\1)/' |
      # Replace (2 years, 5 months) with (2 years)
      sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?\)/\1)/' |
      # Line columns up based on } delimiter
      column -s '}' -t |
      # Page only if we need to
      less -FXRS
}

# Only 15 last
alias glor="glog -15"
alias nv='nvim -c NERDTree 2> /dev/null'

export TERM=screen-256color

source ~/.zsh/git.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                      -o -type d -print 2> /dev/null | fzf +m) &&
                      cd "$dir"
}
