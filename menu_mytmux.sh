#!/bin/bash
#set -x
source ~/.mytmux/menu_core.sh

INIT_SCRIPT=~/.mytmux/init_mytmux.sh

if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
  "$INIT_SCRIPT"
else
  showBaseMenu
fi
