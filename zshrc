# If not running interactively, don't do anything
if [[ $- != *i* ]] ; then
    return
fi

alias which=whence
alias cd='builtin cd'
alias precmd=' precmd'

# standard variables
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

setopt hist_ignore_space hist_ignore_all_dups list_packed transient_rprompt

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

