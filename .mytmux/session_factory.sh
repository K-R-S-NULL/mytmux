#!/bin/env bash
source ~/.mytmux/mytmux_core.sh

facotrySimpleSession(){
    SESSIONNAME=$1
    createSession $SESSIONNAME
    tmux switch -t $SESSIONNAME
}

factorySSHConnection(){
    SESSIONNAME=$1
    SSHHOST=$2
    tmux has-session -t $SESSIONNAME
    if [ $? -ne 0 ]; then
        createSession $SESSIONNAME
        tmux rename-window -t $SESSIONNAME "ssh ${SSHHOST}"
        tmux send-keys -t $SESSIONNAME "ssh ${SSHHOST}" C-m
    fi
    tmux switch -t $SESSIONNAME
}

factoryMultiSSHConnection(){
    SESSIONNAME=$1
    SSHHOST=$2
    CONNECTIONS=$(((($3))-1))
    tmux has-session -t $SESSIONNAME
    if [ $? -ne 0 ]; then
        createSession $SESSIONNAME
        tmux rename-window -t $SESSIONNAME "ssh ${SSHHOST} [${3} times]"
        tmux select-pane -t $SESSIONNAME:0 -T "ssh ${SSHHOST}"
        tmux send-keys -t $SESSIONNAME "ssh ${SSHHOST}" C-m
        for i in $(seq 0 $(($CONNECTIONS-1))); do
            tmux split-window -t $SESSIONNAME -v
            tmux select-pane -t $SESSIONNAME:0 -T "ssh ${SSHHOST}"
            tmux send-keys -t $SESSIONNAME "ssh ${SSHHOST}" C-m
        done
    fi
    tmux select-layout even-vertical
    tmux switch -t $SESSIONNAME
}
