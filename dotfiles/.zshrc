# jwilson zshrc file

# autocomplete
autoload -Uz compinit
compinit
_comp_options+=(globdots)

autoload -Uz vcs_info
case $OSTYPE in 
	'darwin'*)
		zstyle ':vcs_info:git*' formats '(%F{red}%b%f)'
	;;
	'linux'*)
		zstyle ':vcs_info:git*' formats '(%F{blue}%b%f)'
	;;
esac
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

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
	if (( $+commands[rg] )); then 
		alias rg='rg --color=auto'
	fi
fi

# git aliases
alias ga='git add .'
alias gcm='git commit -m'
# end git aliases

# end aliases

# exports
export downloads="$HOME/Downloads"
export VISUAL=vim
export EDITOR=$VISUAL

# local machine expansion 
if [ -f ~/.zshlocal ]; then 
	source ~/.zshlocal
fi
