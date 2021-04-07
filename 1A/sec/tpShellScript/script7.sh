#!/bin/bash

function inv {
    chaine=$*
    len=${#chaine}
    newchaine=""
    echo $len
    if [ -z $chaine ]
    then 
        echo "Il faut rentrer une chaine non vide."
    else
        for ((i=$len-1; i>=0; i--))
        do
            newchaine="$newchaine${chaine:$i:1}"
        done
        echo "$newchaine"
    fi
}