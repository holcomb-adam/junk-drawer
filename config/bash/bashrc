#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set the bash prompt
export PS1='\[$(color-256 2)\]\u\[$(color-256 7)\]@\[$(color-256 2)\]\h\[$(color-256 7)\]:\[$(color-256 4)\]\W\[$(color-256 7)\]$ '


# --- Aliai ---
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C -L 2'
alias ps='ps -u adam'
alias df='df -hl'
alias hyprland="Hyprland"


# Nice information to greet the user
echo "loaded ~/bashrc"
echo
echo -e "$(color-256 5)neofetch:"
neofetch
echo -e "$(color-256 5)timedatectl status:"
timedatectl status
echo -e "$(color-256 5)df:$(color-256 7)"
df
echo
echo
echo
echo -e "$(color-256 1)Tread lightly...$(color-256 7)"
echo
