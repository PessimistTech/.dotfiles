# jwilson zshrc file

# autocomplete
autoload -Uz compinit
compinit
_comp_options+=(globdots)
setopt prompt_subst


git_status() {
    local GITSTATUSICON
    GITSTATUSICON=$'\ue0a0'
    local ahead behind
    ahead=$(command git log --oneline @{upstream}.. 2>/dev/null)
    behind=$(command git log --oneline ..@{upstream} 2>/dev/null)
    if [[ -n "$ahead" ]] && [[ -n "$behind" ]]; then
        GITSTATUSICON=$'\u21c5'
    elif [[ -n "$ahead" ]]; then
        GITSTATUSICON=$'\u21b1'
    elif [[ -n "$behind" ]]; then
        GITSTATUSICON=$'\u21b0'
    fi
    echo -n "$GITSTATUSICON"
}

git_prompt() {
    (( $+commands[git] )) || return
    if [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
        local GitColor
        case $OSTYPE in 
            'darwin'*)
                GitColor='red'
                ;;
            'linux'*)
                GitColor='blue'
                ;;
        esac

        autoload -Uz vcs_info
        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' unstagedstr ' *'
        zstyle ':vcs_info:*' stagedstr $' \u00b1'
        zstyle ':vcs_info:git*' formats "%b%u%c"
        vcs_info
            
        echo -n "(%F{$GitColor}$(git_status)${vcs_info_msg_0_}%f)"
    fi
}

bindkey -v

# prompt
prompt() {
    export PS1="%F{green}%n@%m%f: %1~$(git_prompt) %# "
}

precmd () { prompt }

# history 
export HISTFILE=~/.zsh_history
export HISTSIZE=2000
export HISTFILESIZE=3000
export SAVEHIST=$HISTSIZE

# opts
setopt always_to_end

# plugins
if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if (( $+commands[fzf] )); then 
    source <(fzf --zsh)
fi

# xdg vars
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config" 
fi 

if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share" 
fi 

if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache" 
fi


# aliases
alias ll='ls -alh'
alias la='ls -a'
alias vi='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
if (( $+commands[rg] )); then 
	alias rg='rg --color=auto'
fi

if [[ $OSTYPE == 'darwin'* ]]; then 
	alias cafd='caffeinate -d'
fi

if (( $+commands[xclip] )); then 
	alias xclip='xclip -selection clip'
fi

# git aliases
alias ga='git add .'
alias gcm='git commit -m'
alias gpm='git pull origin main'
# end git aliases

# end aliases

# exports
export downloads="$HOME/Downloads"
if (( $+commands[nvim] )); then 
    export VISUAL=nvim
else 
    export VISUAL=vim
fi
export EDITOR=$VISUAL

# init ssh-agent
if [ -n "$SSH_AGENT_PID" ]; then
    ps -p $SSH_AGENT_PID > /dev/null || eval "$(ssh-agent)" > /dev/null
fi


# local machine expansion 
if [ -f ~/.zshlocal ]; then 
	source ~/.zshlocal
fi
