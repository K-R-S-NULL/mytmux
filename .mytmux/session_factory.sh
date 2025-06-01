#!/bin/env bash

facotrySimpleSession(){
    SESSIONNAME=$1
    tmux has-session -t $SESSIONNAME
    if [ $? -eq 0 ]; then
        echo "Session $SESSIONNAME already exists."
    else
        tmux new-session -d -s $SESSIONNAME
        tmux attach -t $SESSIONNAME
        tmux switch -t $SESSIONNAME
    fi
}

factorySSHConnection(){
    SESSIONNAME=$1
    SSHHOST=$2
    tmux has-session -t $SESSIONNAME
    if [ $? -eq 0 ]; then
        echo "Session $SESSIONNAME already exists."
    else
        tmux new-session -d -s $SESSIONNAME
        tmux send-keys -t $SESSIONNAME "ssh ${SSHHOST}" C-m
        tmux attach -t $SESSIONNAME
        tmux switch -t $SESSIONNAME
    fi
}

factoryMultiSSHConnection(){
    SESSIONNAME=$1
    SSHHOST=$2
    CONNECTIONS=$(($3))
    echo "$SESSIONNAME"
    echo "$SSHHOST"
    echo "$CONNECTIONS"
    sleep 10
}
