# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="$PATH:/opt/rh/git19/root/usr/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='/usr/bin/vim'
# else
# fi

# To get fonts for agnoster theme:
# https://github.com/powerline/fonts
# https://github.com/robbyrussell/oh-my-zsh

###############################################################################
# Machine specifics.
###############################################################################

###############################################################################
# Work
if [[ $(hostname) = "rathma" || $(hostname) = "huehuehue" ]]; then
  export ZSH=/home/tallen/.oh-my-zsh
  export GOPATH='/home/tallen/gopath'
  export GOROOT=/usr/local/go
  export PATH=$PATH:$GOPATH/bin
fi

###############################################################################
# Harbinger
if [[ $(hostname) = "Harbinger" || $(hostname) = "Harbinger.local" ]]; then
  export ZSH=/Users/cyril/.oh-my-zsh
  export GOPATH='/Users/cyril/Go'
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

if [[ $(hostname) = "legion" || $(hostname) = "medusa" ]]; then
  export ZSH=/home/tallen/.oh-my-zsh
  export GOPATH='/home/tallen/gopath'
fi

###############################################################################
# Cruella
if [[ $(hostname) = "cruella" ]]; then
  # Mysterious huge git repo stuff.
  __git_files () { 
      _wanted files expl 'local files' _files     
  }

  # SSH agent stuff.
  if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
  fi

  export TOP=$HOME/main
  export PYTHONPATH=$PYTHONPATH:$TOP/.python                                                     
  export PYTHONUSERBASE=$TOP/.python
  export PATH=$PATH:$TOP/qa/agave/bin:/home/tallen/bin
  export ZSH=/home/tallen/.oh-my-zsh
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.custom_cmds
export PATH="$PATH:$HOME/bin"

#export CC=gcc
#export CXX=g++
[ -z "${NUM_CPUS}" ] && NUM_CPUS=`grep -c ^processor /proc/cpuinfo`
[ -z "${ENVOY_SRCDIR}" ] && export ENVOY_SRCDIR=/source

# UBUNTU BIONIC
export AWS_OKTA_BACKEND=secret-service
source '/home/tallen/gopath/src/github.com/lyft/awsaccess/awsaccess2.sh' # awsaccess
source '/home/tallen/gopath/src/github.com/lyft/awsaccess/oktaawsaccess.sh' # oktaawsaccess
export PS1="\$(ps1_mfa_context)$PS1" # awsaccess

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PATH=$PATH:/home/tallen/.lyftkube-bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/tallen/google-cloud-sdk/path.zsh.inc' ]; then . '/home/tallen/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/tallen/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/tallen/google-cloud-sdk/completion.zsh.inc'; fi
