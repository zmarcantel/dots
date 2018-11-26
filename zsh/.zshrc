# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zach/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


autoload -U colors && colors

##
## Basic Setup
##

export TERM=xterm-256color

##
## Prompt
##

function preexec() {
  timer=${timer:-$SECONDS}
}

# start with empty prompt
PLAIN=""

# standard {user}{path}{time}
PLAIN+="%{$fg_bold[red]%}%n%{$reset_color%}@%m "
PLAIN+="in"
PLAIN+="%{$fg_bold[cyan]%} %~ %{$reset_color%}"
PLAIN+="at"
PLAIN+="%{$fg_bold[green]%} %T %{$reset_color%}"

# add git info to the prompt
source ~/.zmenv/zsh-git


# nothing on the rprompt
RRPOMPT=""

function precmd() {
    RPROMPT=""
    PROMPT=$PLAIN

    # do git stuff for the left prompt
    if git rev-parse --git-dir > /dev/null 2>&1; then
        PROMPT+=$(git_prompt)" "
    fi
    PROMPT+="$ "

    # previous command run details on right prompt
    RIGHT=""
    if [ $timer ]; then
        timer_show=$(($SECONDS - $timer))
        if [ $timer_show -lt 1 ]; then
            # nop for cleanliness of <1s commands
        elif [ $timer_show -gt 60 ]; then
            # show as {Xm Xs}
            timer_show=$(( $timer_show / 60 ))"m "$(( $timer_show % 60 ))"s"
            export RIGHT="%{$fg_bold[grey]%}{${timer_show}}%{$reset_color%}"
        else
            # show as {Xs}
            export RIGHT="%{$fg_bold[grey]%}{${timer_show}s}%{$reset_color%}"
        fi
        unset timer
    fi

    # return code of last command
    RPROMPT="%{$fg_bold[grey]%}[%?]%{$reset_color%} "
    RPROMPT=$RIGHT
}

source ~/.zmenv/common.sh

# added by travis gem
[ -f /home/zach/.travis/travis.sh ] && source /home/zach/.travis/travis.sh
