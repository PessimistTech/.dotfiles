# jwilson zshrc file

# autocomplete
autoload -Uz compinit
compinit
_comp_options+=(globdots)

autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats '(%F{blue}%b%f)'
precmd () { vcs_info }

# prompt
setopt prompt_subst
export PS1='%F{green}%n@%m%f: %1~${vcs_info_msg_0_} %# '

# history 
export HISTFILE=~/.zsh_history
export HISTSIZE=2000
export HISTFILESIZE=3000
export SAVEHIST=$HISTSIZE


# aliases
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'

if [[ $OSTYPE == 'darwin'* ]]; then 
	alias cafd='caffeinate -d'
fi

if (( $+commands[xclip] )); then 
	alias xclip='xclip -selection clip'
fi

# git aliases
alias ga='git add .'
alias gcm='git commit -m'
# end git aliases

# end aliases

# exports
export downloads='~/Downloads'
export VISUAL=vim
export EDITOR=$VISUAL

# expansion 
if [ -f ~/.zshlocal ]; then 
	source ~/.zshlocal
fi
