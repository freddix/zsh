# If not running interactively, don't do anything
if [[ $- != *i* ]] ; then
    return
fi

# standard variables
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

export COLORTERM="yes"

if [ -f /usr/bin/vim ]; then
    export EDITOR=${EDITOR:-vim}
else
    export EDITOR=${EDITOR:-vi}
fi

export PAGER=${PAGER:-less}
export MAIL=${MAIL:-/var/mail/$USER}

# if we don't set $SHELL then aterm, rxvt,.. will use /bin/sh or /bin/bash :-/
export SHELL='/bin/zsh'

# remove command lines from the history list when the first character on the
# line is a space
setopt hist_ignore_space

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt hist_ignore_all_dups

# make sure to use right prompt only when not running a command
setopt transient_rprompt

bindkey -e
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend] end-of-line
bindkey $terminfo[kich1] quoted-insert
bindkey $terminfo[kdch1] delete-char
bindkey $terminfo[kpp] up-history
bindkey $terminfo[knp] end-of-history
bindkey $terminfo[kcuu1] history-beginning-search-backward
bindkey $terminfo[kcud1] history-beginning-search-forward

# prompt
PS1=$'%{\e[0;36m%}%#%{\e[0m%} '
RPS1=$'%{\e[0;31m%}%~%{\e[0m%}'

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# misc options
unsetopt beep

case "$TERM" in
    gnome*|rxvt*)
	precmd () { print -Pn "\e]0;%n@%m: %~\a" }
	bindkey '^[[H' beginning-of-line >/dev/null 2>&1
	bindkey '^[[F' end-of-line >/dev/null 2>&1
	bindkey '^[[A' history-beginning-search-backward >/dev/null 2>&1
	bindkey '^[[B' history-beginning-search-forward >/dev/null 2>&1
	;;
esac

typeset -ga ls_options
ls_options=( --color=auto )

# aliases
alias which=whence
alias cd='builtin cd'
alias precmd=' precmd'

# execute \kbd{@a@}:\quad ls with colors
alias ls='ls -b -CF '${ls_options:+"${ls_options[*]}"}

# execute \kbd{@a@}:\quad list all files, with colors
alias la='ls -la '${ls_options:+"${ls_options[*]}"}

# long colored list, without dotfiles (@a@)
alias ll='ls -l '${ls_options:+"${ls_options[*]}"}

# long colored list, human readable sizes (@a@)
alias lh='ls -hAl '${ls_options:+"${ls_options[*]}"}

# List files, append qualifier to filenames \\&\quad(\kbd{/} for directories, \kbd{@} for symlinks ...)
alias l='ls -lF '${ls_options:+"${ls_options[*]}"}

