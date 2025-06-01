#!/bin/bash
set -x
TMUX="tmux -2"
SESSIONNAME=tmux_menu

MENU_SCRIPT=./menu_mytmux.sh

$TMUX has-session -t $SESSIONNAME
if [ $? -eq 0 ]; then
       echo "Session $SESSIONNAME already exists. Attaching."
       sleep 1
       $TMUX attach -t $SESSIONNAME
       exit 0;
fi
$TMUX new-session -d -s $SESSIONNAME
tmux source-file ~/.mytmux/tmux.conf
tmux set -g mouse on
# Attach to the created session
tmux rename-window -t $SESSIONNAME "Main Menu"
tmux send-keys -t $SESSIONNAME 'eval "$(ssh-agent -s)"' C-m
COMMAND="ssh-add ~/.ssh/ssh_user_ca && $MENU_SCRIPT"
tmux send-keys -t $SESSIONNAME "$COMMAND" C-m

tmux attach-session -t $SESSIONNAME
