#!/bin/env bash
source ~/.mytmux/session_factory.sh

createSessionMenu(){
    clear
    echo "0) ABBORT"
    echo "1) blank new Session"
    echo "2) new ssh connection"
    echo "3) new mulit ssh connection"
    echo -n "Create Session of Type: " 
    read REPLY
    REPLY=$(($REPLY))
    case $REPLY in
        0)
            echo "no show"
            ;;
        1) 
            echo -n "Enter Session Name: " 
            read NEWSESSIONAME
            facotrySimpleSession $NEWSESSIONAME
            sleep 5
            ;;
        2)
            echo -n "Enter Session Name: " 
            read NEWSESSIONAME
            echo -n "Enter SSH Host: " 
            read HOSTNAME
            factorySSHConnection $NEWSESSIONAME $HOSTNAME
            ;;
        3)
            echo -n "Enter Session Name: " 
            read NEWSESSIONAME
            echo -n "Enter SSH Host: " 
            read HOSTNAME
            echo -n "count: " 
            read COUNT
            factoryMultiSSHConnection $NEWSESSIONAME $HOSTNAME $COUNT
            ;;
        *)
            echo "invalid Option"
            sleep 1
            createSessionMenu
            ;;
        esac
}

loadSessions(){
    options=()
    sessions=()
    options+=('RELOAD')
    options+=('CREATE NEW SESSION')
    while IFS= read <&3 -rd '
' f #new row for the sepperation symbol
    do
        readarray -d ":" sessionname <<< $f
        sessions+=(${sessionname[0]})
        options+=("$f")
    done 3< <(tmux ls)
}

showBaseMenu(){
    clear
    loadSessions
    i=0
    for opt in "${options[@]}"
    do
        echo "$i) $opt"
        i=$(($i+1))
    done
    echo -n "Enter Option: " 
    read REPLY
    #echo "you chose choice $REPLY which is $opt"
    switch_to=${sessions[($REPLY-2)]}
    REPLY=$(($REPLY))
    case $REPLY in
        0)
            ;;
        1)
            createSessionMenu
            ;;
        *) 
            session_count=${#sessions[@]}
            int_reply=$((REPLY))
            int_reply=$(($int_reply - 1))
            if [ "$session_count" -ge "$int_reply" ]; then
                tmux switch -t $switch_to
            else
                echo "invalid option $REPLY"
                sleep 1
            fi
            ;;
        esac
    showBaseMenu
}
