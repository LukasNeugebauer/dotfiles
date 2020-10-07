# zsh config file

# get rid of super stupid key bindings
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '\e[3~' delete-char
bindkey '\e[2~' quoted-insert
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

# make it pretty
autoload -U colors && colors

#preload calc
autoload -zU zcalc

#preload git info
autoload -zU vcs_info
precmd() { vcs_info }
setopt prompt_subst

# redefine command prompt appearence
PS1="%B[%{$fg[red]%}%n%{$reset_color%}@%M %~] $%b "
# RPROMPT shows on the right
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats "%B%{$fg[yellow]%}[ %b]"


# unset multios option to get bash-like stdin/out/err behavior
unsetopt MULTIOS

# define history
HISTSIZE=10000
SAVEHIST=10000

HISTFILE=~/.cache/zsh/history

# load alises
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# add path to custom shell scripts
export PATH=/usr/local/miniconda3/condabin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:~/.local/bin:~/shell_scripts

# enable autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# initialize conda
__conda_setup="$('/usr/local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# set some environment variables
export CMDSTAN="/home/lukas/cmdstan-2.24.1"
export EDITOR=vim
export BROWSER=brave
export TERMINAL=termite

# source syntax highlighting because why not
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# completely useless but looks cool and impresses normies
neofetch
