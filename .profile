#!/bin/sh

export TERM="xterm-256color"
export vim="nvim"

### PATH
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go" ] ; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

if [ -d "$HOME/.local/bin/flutter/bin" ] ; then
  export PATH="$PATH:$HOME/.local/bin/flutter/bin"
fi

export EXA_COLORS="\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:"

BAT_THEME="Catppuccin Mocha"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi


fish
