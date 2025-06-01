#!/bin/env bash
createSession(){
    SESSIONNAME=$1
    tmux has-session -t $SESSIONNAME
    if [ $? -eq 0 ]; then
        echo "Session $SESSIONNAME already exists."
    else
        tmux -2 new-session -d -s $SESSIONNAME
        tmux source-file ~/.mytmux/tmux.conf
        tmux attach-session -t $
    fi
}
