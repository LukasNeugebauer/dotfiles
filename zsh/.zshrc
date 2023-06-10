# my zsh config file, partially based on manjaro and anarchy configs

#set and unset some options on zsh level
setopt prompt_subst
setopt INC_APPEND_HISTORY #write commands to history file at once
unsetopt BG_NICE #same priority for background jobs
unsetopt CORRECT #that turns out to be more annoying than helpful
setopt EXTENDED_HISTORY #save timing information with commands
unsetopt MULTIOS

#same for general shell options
#these are just copied for now, too lazy to look them up
setopt   notify globdots pushdtohome cdablevars autolist
setopt   autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

#set some variables
PATH="/usr/local/bin:/usr/local/sbin/:$HOME/shell_scripts:$PATH"
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

#load some stuff
autoload -U colors && colors
autoload -zU vcs_info

#redefine command prompt
# redefine command prompt appearence
PS1="%B[%{$fg[yellow]%}%n%{$reset_color%}@%M %~] $%b "

#define git prompt on the right
precmd() { vcs_info }
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats "%B%{$fg[yellow]%}[ %b]"

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

# only search history that starts with the prompt
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Set colors
# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

# load alises
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# enable autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# set some environment variables
export EDITOR=vim
export BROWSER=brave
export TERMINAL=alacritty
export FREESURFER_HOME=$HOME/freesurfer
export PREPRINT=$HOME/Documents/papers/bafeg/preprint

# source syntax highlighting because why not
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#define some functions, extract is pretty nice
#these are stolen from the manjaro config I think
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function mcd () {
    mkdir -p $1
    cd $1
}

function pbpp() {
# Function to fully compile a LaTeX document including bibliography
# Redirects output and only shows errors if it fails at any step

    # Check if a filename was provided
    if [ -z "$1" ]; then
        echo "Usage: pbpp <filename.tex>"
        return 1
    fi

    # Define the name of the temporary log file
    log_file=$(mktemp)

    # Run pdflatex with options to fail at every error and not go into a prompt
    echo "Running pdflatex (pass 1)..."
    pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(dirname "$1") -aux-directory=$(dirname "$1") "$1" > "$log_file" 2>&1

    # Check if pdflatex returned an error
    if [ $? -ne 0 ]; then
        echo "pdflatex failed"
        echo "Printing last 20 lines of log file:"
        tail -n 20 "$log_file"
        return 1
    fi

    # Run biber to generate bibliography data
    echo "Running biber..."
    biber $(basename "$1" .tex) > "$log_file" 2>&1

    # Check if biber returned an error
    if [ $? -ne 0 ]; then
        echo "biber failed"
        echo "Printing last 20 lines of log file:"
        tail -n 20 "$log_file"
        return 1
    fi

    # Run pdflatex again to resolve cross-references and update the table of contents
    echo "Running pdflatex (pass 2)..."
    pdflatex -interaction=nonstopmode -output-directory=$(dirname "$1") -aux-directory=$(dirname "$1") "$1" > "$log_file" 2>&1

    # Check if pdflatex returned an error
    if [ $? -ne 0 ]; then
        echo "pdflatex failed"
        echo "Printing last 20 lines of log file:"
        tail -n 20 "$log_file"
        return 1
    fi

    # Run pdflatex a third time to ensure everything is properly resolved
    echo "Running pdflatex (pass 3)..."
    pdflatex -interaction=nonstopmode -output-directory=$(dirname "$1") -aux-directory=$(dirname "$1") "$1" > "$log_file" 2>&1

    # Check if pdflatex returned an error
    if [ $? -ne 0 ]; then
        echo "pdflatex failed"
        echo "Printing last 20 lines of log file:"
        tail -n 20 "$log_file"
        return 1
    fi

    echo "pdflatex finished successfully"
    # Delete the temporary log file
    rm "$log_file"
}

function clearlatex(){
# delete all the results from latex compilation except for the pdf
# this is to make sure you're not accidently deleting other pdfs
# this can be run in the present directory or a directory can be given as a
  #default to pwd
  if [[ -n $1 ]]; then
    newpath=$1
  else
    newpath=$(pwd)
  fi
  oldpath=$(pwd)
  cd $newpath
  # define file endings that will be deleted
  declare -a endings=("aux" "bcf" "log" "lof" "lot" "run.xml" "toc" "bbl" "blg" "out")
  for ending in $endings; do
      [[ -n $(ls *.$ending) ]] && rm -f *.$ending
  done
  cd $oldpath
}

function bib_search_title(){
# search the identifiers of a bibtex file for a pattern
# or in other words: what was this shepard paper called in my bibfile again?
    [[ -z $1 ]] && echo "Pattern is mandatory" && return 1
    pattern=$1
    if [[ -n $2 ]]; then
        bibfile=$2
    else
        n_files=$(echo *.bib | wc -w)
        if [[ $n_files -gt 1 ]]; then
            echo "Too many bib-files, specify one please." && return 1
        elif [[ $n_files -eq 0 ]]; then
            echo "No bib file found." && return 1
        fi
        bibfile=$(echo *bib)
    fi
    identifiers=$(sed -n 's/@.*{\(.*\),/\1/p' $bibfile)
    results=$(echo $identifiers | grep $pattern)
    if [[ -z $results ]]; then
        echo "No results :(" && return 1
    else
        echo $results && return 0
    fi
}

# completely useless but looks cool and impresses normies
neofetch

__conda_setup="$('/home/lukas/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lukas/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lukas/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lukas/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/lukas/miniconda3/etc/profile.d/mamba.sh" ]; then
    . "/home/lukas/miniconda3/etc/profile.d/mamba.sh"
fi

[[ -f ~/.config/.api-keys ]] && source ~/.config/.api-keys
