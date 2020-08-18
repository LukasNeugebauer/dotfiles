#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias activate="conda activate"

#needed for stupid vs code or stupid conda. not sure who's stupid here
export PATH=/usr/local/miniconda3/bin:$PATH
