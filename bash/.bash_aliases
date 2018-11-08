# /bin & /usr/bin
alias ls='ls -F --color'
alias ll='ls -al'
alias lh='ll -h'
alias l='ls'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias find='find .'
alias ..='cd ..'
alias dg='dpkg -l | grep'

# git
alias gpush='git push origin'
alias gpull='git pull origin'
alias gst='git st'
alias gdf='git df'
alias gl='git l'
alias ga='git add'
alias gap='git add -p'
alias gci='git commit -m'
alias gco='git checkout'
alias gbr='git branch'
alias gf='git fetch --prune'
alias gm='git merge'

# apt
alias apt-get='sudo apt-get'
alias apt-file='sudo apt-file'
alias apt='sudo apt'
alias agi='apt-get install'
alias agu='apt-get update'
alias agup='apt-get upgrade'
alias acs='apt-cache search'
alias acsh='apt-cache show'
alias agrm='apt-get remove'

# docker
alias d='docker'
alias dc='docker-compose'
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
alias docker-ip='docker inspect -f '\''{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\'''

# tmux
alias tmux='tmux -CC attach || tmux -CC'

# local
alias api='cd ${HOME}/dev/eduvant/eduvant_platform'
alias sw='cd ${HOME}/dev/personal/southwest'
