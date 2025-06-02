# PROMPT='%~ > '
PROMPT='%F{blue}%~%f %F{cyan}>%f '

# vim binds
bindkey -v

# aliases
alias cl='clear'
alias cb='cd ..'

alias gs='git status'
alias gb='git branch'
alias ga='git add'
alias gl='git log'
alias gd='git diff'
alias gds='git diff --shortstat'
alias gcm='git commit -m'
alias gpl='git pull'
alias gps='git push'
alias gpo='git push -u origin'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gr='git restore'

alias comp='cd ~/code/comp'

# eza and zoxide for ls and cd, starship
alias ls="eza --icons=auto"
eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)" 

# syntax
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# cowsay greeting hell yeah
# if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
#     # choose randomly betw cowsay and cowthink
#     cowprog=$(shuf -e cowsay cowthink -n 1)

#     fav_cowfiles=(moose koala)
#     cowfile=$(printf "%s\n" "${fav_cowfiles[@]}" | shuf -n 1)

#     fortune | $cowprog -f "$cowfile"
#     echo
# fi

function zsh_greeting() {
  # Colors
  normal='\033[0m'
  red='\033[0;31m'
  brred='\033[1;31m'
  green='\033[0;32m'
  brgreen='\033[1;32m'
  yellow='\033[0;33m'
  bryellow='\033[1;33m'
  blue='\033[0;34m'
  brblue='\033[1;34m'
  magenta='\033[0;35m'
  brmagenta='\033[1;35m'
  cyan='\033[0;36m'
  brcyan='\033[1;36m'

  # ascii art
  cutiepies=(
    '
     ,_,
    (O,O)
    (   )
    -"-"---dwb-
    ' \
    '
    \|/          (__)    
         `\------(oo)
           ||    (__)
           ||w--||     \|/
       \|/
    ' \
    '
     /\_/\
    ( o.o )
     > ^ <
    '
  )
  # 1. RANDOM is biased toward the lower index
  # 2. Array index in ZSH starts at 1
  cutiepie=${cutiepies[ $(( RANDOM % ${#cutiepies[@]} + 1 )) ]}

  # Other info
  my_hostname=$(hostname -s)
  timestamp="$(date -I) $(date +"%T")"
  uptime=$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 " " }')

  # Greeting msg
  echo
  echo -e "  " "$brgreen" "Welcome back $USER!"                       "$normal"
  echo -e "  " "$brred"   "$cutiepie"                                 "$normal"
  echo -e "  " "$yellow"  " Zsh Open:\t"   "$bryellow$timestamp"     "$normal"
  echo -e "  " "$blue"    " Hostname:\t"   "$brmagenta$my_hostname"  "$normal"
  echo -e "  " "$magenta" " Uptime  :\t"   "$brblue$uptime"          "$normal"
  echo
}

zsh_greeting
