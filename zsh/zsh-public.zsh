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
alias gplom='git pull origin main'
alias gps='git push'
alias gpso='git push -u origin'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gr='git restore'
alias grs='git restore --staged'
alias gst='git stash'
alias gsp='git stash pop'
alias gcln='git clone'
alias oopss='git reset --soft HEAD~1'
alias oopsh='git reset --hard HEAD~1'

alias dotf='cd dotfiles'
# alias comp='cd ~/code/comp'
alias repos='cd ~/repos'
alias cfre='cd ~/repos/freerooms-mobile'
alias cios='cd ~/repos/freerooms-mobile/ios'

alias py3='python3'

# detect platform
if [[ "$OSTYPE" == "darwin"* ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# eza and zoxide for ls and cd, starship
eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
alias ls="eza --icons=auto"
eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

# syntax
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# thefuck (cmd correction lol)
eval $(thefuck --alias shibal)

# fuzzy find (ctrl+T) 
# ssh **, cd **
# ctrl+R for history
eval "$(fzf --zsh)"
# use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - the first argument to the function ($1) is the base path to start traversal
# - see the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
# fzf with git
source ~/fzf-git.sh/fzf-git.sh
# previews with eza and bat from josean martinez on yt : )
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# copy wezterm config from wsl to windows
alias sync-wezterm="cp ~/.dotfiles/wezterm/.wezterm.lua /mnt/c/Users/Gabriella/.wezterm.lua"

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
