# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tallen"
#ZSH_THEME="agnoster"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

DISABLE_UPDATE_PROMPT=true

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="$PATH:/opt/rh/git19/root/usr/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/home/tallen/.cargo/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='/usr/bin/nvim'
# else
# fi

# To get fonts for agnoster theme:
# https://github.com/powerline/fonts
# https://github.com/robbyrussell/oh-my-zsh

###############################################################################
# Machine specifics.
###############################################################################

###############################################################################
# Harbinger
if [[ $(hostname) = "Harbinger" || $(hostname) = "Harbinger.local" ]]; then
  export ZSH=/Users/cyril/.oh-my-zsh
  export GOPATH='/Users/cyril/Go'
  export JAVA_HOME=$(/usr/libexec/java_home)
else
  export ZSH=/home/tallen/.oh-my-zsh
  export GOPATH='/home/tallen/gopath'
  export PATH=$PATH:$GOPATH/bin
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.tmp_aliases
source $HOME/.custom_cmds
export PATH="$PATH:$HOME/bin:$HOME/src/chronosphere/monorepo/bin:$HOME/src/chronosphere/monorepo/_tools/bin:$HOME/src/m3/bin"
mkdir -p ~/.vim_backup

export CC=clang
export CXX=clang++

go env -w GOPRIVATE=github.com/chronosphereio
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)
